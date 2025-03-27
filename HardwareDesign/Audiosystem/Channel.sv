module Channel (
    input logic clk,
    input logic rst,

    input logic [31:0] w_ChannelData,
    input logic[3:0] w_selectChannelData,
    input logic w_valid,

    input logic i_ready,
    input logic [15:0] i_sample,
    
    output logic isMono = 1,
    output logic isRight = 0,
    output logic isPlaying = 0,
    output logic [15:0] o_SampleOut,
    output logic [31:0] o_nextSampleAddress
);

    typedef enum logic[3:0] {
        IDLE                = 0,
        SET_STARTADDRESS    = 1,
        SET_SAMPLECOUNT     = 2,
        SET_LOOPSTART       = 3,
        SET_LOOPEND         = 4,
        SET_CURRENTPOSITION = 5,
        SET_LASTSAMPLE      = 6,
        SET_VOLUME          = 7,
        SET_ISLOOPING       = 8,
        SET_ISPLAYING       = 9,
        SET_ISMONO          = 10,
        SET_ISLEFT          = 11
    } ChannelSettings;

    logic [31:0] startDataAddress = 0;  
    logic [23:0] sampleCount = 0;
    logic [23:0] loopStart = 0;
    logic [23:0] loopEnd = 0;

    logic [23:0] currentPosition = 0;
    logic [15:0] lastSample = 0;
    logic [7:0] volume = 128;

    logic isLooping = 0;

    logic[31:0] nextDataAddressMono;
    logic[31:0] nextDataAddressLeft;
    logic[31:0] nextDataAddressRight;

    logic[31:0] nextDataAddress;

    logic[23:0] positionPlus1;
    logic[23:0] nextPosition;

    logic [31:0] amplifiedSample;

    assign nextDataAddressMono      = startDataAddress +  currentPosition       + 1;
    assign nextDataAddressLeft      = startDataAddress + (currentPosition << 1) + 2;
    assign nextDataAddressRight     = startDataAddress + (currentPosition << 1) + 3;

    assign nextDataAddress          = rst ? 32'b0 : 
                                      (isMono) ? nextDataAddressMono : 
                                      (isRight) ? nextDataAddressRight : nextDataAddressLeft;

    assign positionPlus1            = currentPosition + 1;
    assign nextPosition             = (!isPlaying || !i_ready) ? currentPosition :
                                      (positionPlus1 >= loopEnd && isLooping) ? loopStart :
                                       positionPlus1;

    assign amplifiedSample = ($signed(lastSample) * $signed({1'b0,volume})) >>> 7;

    assign o_SampleOut              = !isPlaying ? 0 :
                                      $signed(amplifiedSample) > $signed(32767) ? 32767 : 
                                      $signed(amplifiedSample) < $signed(-32768) ? $signed(-32768) :
                                      $signed(amplifiedSample);
    
    assign o_nextSampleAddress = nextDataAddress;

    always_ff @(posedge clk) begin
        if(i_ready)
            lastSample <= i_sample;
        else
            lastSample <= lastSample;
        if(w_selectChannelData == SET_LASTSAMPLE && w_valid) begin
            lastSample <= w_ChannelData;
        end
        if(rst)
            lastSample <= 0;
    end


    always_ff @(posedge clk) begin
        if(i_ready) begin
            currentPosition <= nextPosition;
        end
        if(w_selectChannelData == SET_CURRENTPOSITION && w_valid) begin
            currentPosition <= w_ChannelData;
        end
        if(rst) begin
            currentPosition <= 0;
        end
    end

    always_ff @(posedge clk) begin
        if(w_valid) begin
            case (w_selectChannelData)
                SET_STARTADDRESS:   startDataAddress    <= w_ChannelData;
                SET_SAMPLECOUNT:    sampleCount         <= w_ChannelData;
                SET_LOOPSTART:      loopStart           <= w_ChannelData;
                SET_LOOPEND:        loopEnd             <= w_ChannelData;
                SET_VOLUME:         volume              <= w_ChannelData;
                SET_ISLOOPING:      isLooping           <= w_ChannelData;
                SET_ISPLAYING:      isPlaying           <= w_ChannelData;
                SET_ISMONO:         isMono              <= w_ChannelData;
                SET_ISLEFT:         isRight             <= w_ChannelData;
            endcase
        end
        if(currentPosition >= sampleCount) begin
            isPlaying <= 0;
        end
        if(rst) begin
            isPlaying <= 0;
        end
    end
endmodule
