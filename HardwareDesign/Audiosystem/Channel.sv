module Channel (
    input logic clk,
    input logic rst,

    input logic [23:0] w_ChannelData,
    input logic[3:0] w_selectChannelData,

    input logic [11:0] i_sampleDelta,

    input logic lrclk,

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

    logic [11:0] startDataAddress;  
    logic [23:0] sampleCount;           
    logic [23:0] loopStart;         
    logic [23:0] loopEnd;           
    logic [15:0] loopStartSample;   

    logic [23:0] currentPosition;   
    logic [15:0] lastSample;        
    logic [7:0] volume;             

    logic isLooping;                   
    logic isPlaying;                
    logic isMono;                   
    logic isLeft;                   

    logic[31:0] nextDataAddressMono;
    logic[31:0] nextDataAddressLeft;
    logic[31:0] nextDataAddressRight;

    logic[31:0] nextDataAddress;

    logic[23:0] positionPlus1;
    logic[23:0] nextPosition;

    logic[15:0] sampleDelta;
    logic [31:0] sampleCalculation;

    logic [31:0] nextSampleCalculation;

    logic [15:0] nextSample;

    assign nextDataAddressMono      = startDataAddress +  currentPosition       + 1;
    assign nextDataAddressLeft      = startDataAddress + (currentPosition << 1) + 2;
    assign nextDataAddressRight     = startDataAddress + (currentPosition << 1) + 3;

    assign nextDataAddress          = (isMono) ? nextDataAddressMono : 
                                      (isLeft) ? nextDataAddressLeft : nextDataAddressRight;

    assign positionPlus1            = currentPosition + 1;
    assign nextPosition             = (!isPlaying) ? currentPosition :
                                      (positionPlus1 >= loopEnd && isLooping) ? loopStart :
                                       positionPlus1;

    assign sampleDelta              = {{3{i_sampleDelta[11]}},i_sampleDelta,1'b0};

    assign sampleCalculation        = sampleDelta + lastSample;

    assign nextSampleCalculation    = (positionPlus1 >= loopEnd && isLooping) ? loopStartSample : sampleCalculation;

    assign nextSample               = (!isPlaying)           ? 0     :
                                      (nextSampleCalculation > 32767)   ? 32767  :
                                      (nextSampleCalculation < -32768)  ? -32768 :
                                       nextSampleCalculation[15:0];

    assign o_SampleOut              = (nextSample  * (volume<<<4))>>>4;
    

    logic old_lrclk;
    always_ff @(posedge clk) begin
        if(old_lrclk == 0 && lrclk == 1) begin
            lastSample <= nextSample;
        end
        if(w_selectChannelData == SET_LASTSAMPLE) begin
            lastSample <= w_ChannelData;
        end
    end


    always_ff @(posedge clk) begin
        old_lrclk <= lrclk;
        if(old_lrclk == 0 && lrclk == 1) begin
            currentPosition <= nextPosition;
        end
        if(w_selectChannelData == SET_CURRENTPOSITION) begin
            currentPosition <= w_ChannelData;
        end
        if(rst) begin
            currentPosition <= 0;
        end
    end

    always_ff @(posedge clk) begin
        case (w_selectChannelData)
            SET_STARTADDRESS:   startDataAddress    <= w_ChannelData;
            SET_SAMPLECOUNT:    sampleCount         <= w_ChannelData;
            SET_LOOPSTART:      loopStart           <= w_ChannelData;
            SET_LOOPEND:        loopEnd             <= w_ChannelData;
            SET_VOLUME:         volume              <= w_ChannelData;
            SET_ISLOOPING:      isLooping           <= w_ChannelData;
            SET_ISPLAYING:      isPlaying           <= w_ChannelData;
            SET_ISMONO:         isMono              <= w_ChannelData;
            SET_ISLEFT:         isLeft              <= w_ChannelData;
        endcase
        if(currentPosition >= sampleCount) begin
            isPlaying <= 0;
        end
        if(rst) begin
            isPlaying <= 0;
        end
    end

    always_ff @(posedge clk) begin
        if(currentPosition == loopStart) begin
            loopStartSample <= lastSample;
        end
    end
endmodule
