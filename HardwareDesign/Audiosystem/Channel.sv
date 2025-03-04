import audio_data_types::*;
module Channel (
    input logic clk,
    input logic rst,

    input logic [23:0] w_ChannelData,
    input ChannelSettings w_selectChannelData,

    input logic [11:0] i_sampleDelta,

    input logic lrclk,

    output logic [15:0] o_SampleOut,
    output logic [31:0] o_nextSampleAddress
);

    ChannelData channelData;

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

    assign nextDataAddressMono      = channelData.startDataAddress + channelData.currentPosition        + 1;
    assign nextDataAddressLeft      = channelData.startDataAddress + (channelData.currentPosition << 1) + 2;
    assign nextDataAddressRight     = channelData.startDataAddress + (channelData.currentPosition << 1) + 3;

    assign nextDataAddress          = (channelData.isMono) ? nextDataAddressMono : 
                                      (channelData.isLeft) ? nextDataAddressLeft : nextDataAddressRight;

    assign positionPlus1            = channelData.currentPosition + 1;
    assign nextPosition             = (!channelData.isPlaying) ? channelData.currentPosition :
                                      (positionPlus1 >= channelData.loopEnd && channelData.isLooping) ? channelData.loopStart :
                                       positionPlus1;

    assign sampleDelta              = {{3{i_sampleDelta[11]}},i_sampleDelta,1'b0};

    assign sampleCalculation        = sampleDelta + channelData.lastSample;

    assign nextSampleCalculation    = (positionPlus1 >= channelData.loopEnd && channelData.isLooping) ? channelData.loopStartSample : sampleCalculation;

    assign nextSample               = (!channelData.isPlaying)           ? 0     :
                                      (nextSampleCalculation > 32767)   ? 32767  :
                                      (nextSampleCalculation < -32768)  ? -32768 :
                                       nextSampleCalculation[15:0];

    assign o_SampleOut              = (nextSample  * (channelData.volume<<<4))>>>4;
    

    logic old_lrclk;
    always_ff @(posedge clk) begin
        if(old_lrclk == 0 && lrclk == 1) begin
            channelData.lastSample <= nextSample;
        end
        if(w_selectChannelData == SET_LASTSAMPLE) begin
            channelData.lastSample <= w_ChannelData;
        end
    end


    always_ff @(posedge clk) begin
        old_lrclk <= lrclk;
        if(old_lrclk == 0 && lrclk == 1) begin
            channelData.currentPosition <= nextPosition;
        end
        if(w_selectChannelData == SET_CURRENTPOSITION) begin
            channelData.currentPosition <= w_ChannelData;
        end
        if(rst) begin
            channelData.currentPosition <= 0;
        end
    end

    always_ff @(posedge clk) begin
        case (w_selectChannelData)
            SET_STARTADDRESS:   channelData.startDataAddress    <= w_ChannelData;
            SET_SAMPLECOUNT:    channelData.sampleCount         <= w_ChannelData;
            SET_LOOPSTART:      channelData.loopStart           <= w_ChannelData;
            SET_LOOPEND:        channelData.loopEnd             <= w_ChannelData;
            SET_VOLUME:         channelData.volume              <= w_ChannelData;
            SET_ISLOOPING:      channelData.isLooping           <= w_ChannelData;
            SET_ISPLAYING:      channelData.isPlaying           <= w_ChannelData;
            SET_ISMONO:         channelData.isMono              <= w_ChannelData;
            SET_ISLEFT:         channelData.isLeft              <= w_ChannelData;
        endcase
        if(channelData.currentPosition >= channelData.sampleCount) begin
            channelData.isPlaying <= 0;
        end
        if(rst) begin
            channelData.isPlaying <= 0;
        end
    end

    always_ff @(posedge clk) begin
        if(channelData.currentPosition == channelData.loopStart) begin
            channelData.loopStartSample <= channelData.lastSample;
        end
    end
endmodule
