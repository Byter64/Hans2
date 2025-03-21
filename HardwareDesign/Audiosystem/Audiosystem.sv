module Audiosystem (
    input clk,
    input clk_25mhz,
    input rst,

    //CPU Interface
    input[23:0] registerData,
    input[3:0] registerSelect,
    input[7:0] channelSelect,
    
    //Memory Interface

    //I²S Interface
    output audio_bclk,
    output audio_lrclk,
    output audio_dout
);

logic sampleClk; //This is also the Word Select for the left/right channel
logic clk_64khz;
logic bitclk;
ClockGenerator ClockGenerator 
(
    .clk_25mhz(clk_25mhz),
    .clk_1024khz(bitclk),
    .clk_64khz(clk_64khz),
    .clk_32khz(sampleClk)
);

logic[15:0] i_sample;
logic[7:0] i_ready;
logic[7:0] isPlaying;
logic oldSampleClk;
logic[3:0] loadingState;
always_ff @(posedge clk) begin
    oldSampleClk <= sampleClk;
    case (loadingState)
        4'd0: 
        default: 
    endcase

    if(oldSampleClk == 0 && oldSampleClk) begin
        i_ready <= 0;
        loadingState <= 0;
    end
end


logic[7:0] isMono;
logic[7:0] isRight;
logic[15:0] sample[8];
logic[31:0] o_nextSampleAddress[8];
genvar i;
generate
    for(i = 0; i < 8; i++) begin
        Channel channel 
        (
            .clk(clk),
            .rst(rst),

            .w_ChannelData(registerData),           //CPU Interface
            .w_selectChannelData(registerSelect),   //CPU Interface
            .w_valid(channelSelect[i]),             //CPU Interface

            .i_ready(i_ready[i]),
            .i_sample(i_sample),

            .isMono(isMono[i]),
            .isRight(isRight[i]),
            .isPlaying(isPlaying[i]),
            .o_SampleOut(sample[i]),
            .o_nextSampleAddress(o_nextSampleAddress[i])
        );
    end
endgenerate

logic[15:0] leftSample[8];
logic[15:0] rightSample[8];
integer lrIter;
for (lrIter = 0; lrIter < 8; lrIter++) begin
    assign leftSample[lrIter] = (isMono[lrIter] || !isRight[lrIter]) ? sample[lrIter] : 0;
    assign rightSample[lrIter] = (isMono[lrIter] || isRight[lrIter]) ? sample[lrIter] : 0;
end

logic[31:0] leftMix;
logic[31:0] rightMix;
logic[15:0] leftFinalMix;
logic[15:0] rightFinalMix;
assign leftMix = leftSample[0] + leftSample[1] + leftSample[2] + leftSample[3] + 
                 leftSample[4] + leftSample[5] + leftSample[6] + leftSample[7];

assign rightMix = rightSample[0] + rightSample[1] + rightSample[2] + rightSample[3] + 
                  rightSample[4] + rightSample[5] + rightSample[6] + rightSample[7];

assign leftFinalMix = $signed(leftMix) > $signed(32767) ? 32767 : 
                      $signed(leftMix) < $signed(-32768) ? $signed(-32768) :
                      $signed(leftMix);

assign rightFinalMix = $signed(rightMix) > $signed(32767) ? 32767 : 
                       $signed(rightMix) < $signed(-32768) ? $signed(-32768) :
                       $signed(rightMix);

logic[15:0] dataOut;
assign dataOut = sampleClk ? rightFinalMix : leftFinalMix; //sampleClk == 0 <==> left

I2STransmitter I2STransmitter 
(
    .dataIn(dataOut),
    .bitclk(bitclk),
    .dataOut(audio_dout)
);

assign audio_bclk = bitclk;
assign audio_lrclk = sampleClk;
endmodule