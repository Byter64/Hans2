//Please make clk and aclk be the same clock,
module Audiosystem (
    input logic  clk,
    input logic  clk_25mhz,
    input logic  rst,

    //CPU Interface
    input logic[31:0] registerData,
    input logic[3:0] registerSelect,
    input logic[7:0] channelSelect,
    
    //Memory Interface (AXI Lite Master)
    input logic            aclk,
    input logic            aresetn,
    output logic[31:0]     m_axil_awaddr,
    output logic[2:0]      m_axil_awprot,
    output logic           m_axil_awvalid,
    input logic            m_axil_awready,

    output logic[15:0]     m_axil_wdata,
    output logic[1:0]      m_axil_wstrb,
    output logic           m_axil_wvalid,
    input logic            m_axil_wready,

    input logic[1:0]       m_axil_bresp,
    input logic            m_axil_bvalid,
    output logic           m_axil_bready,

    output logic[31:0]     m_axil_araddr,
    output logic[2:0]      m_axil_arprot,
    output logic           m_axil_arvalid,
    input logic            m_axil_arready,

    input logic[15:0]      m_axil_rdata,
    input logic[1:0]       m_axil_rresp,
    input logic            m_axil_rvalid,
    output logic           m_axil_rready,

    //I²S Interface
    output logic  audio_bclk,
    output logic  audio_lrclk,
    output logic  audio_dout
);
logic[7:0] isMono;
logic[7:0] isRight;
logic[15:0] sample[8];
logic[31:0] o_nextSampleAddress[8];

assign m_axil_awaddr  = 'b0;
assign m_axil_awprot  = 'b0;
assign m_axil_awvalid = 'b0;
assign m_axil_wdata   = 'b0;
assign m_axil_wstrb   = 'b0;
assign m_axil_wvalid  = 'b0;
assign m_axil_bready  = 'b0;

assign m_axil_arprot = 'b0;

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

logic old_bitclk;
logic old_clk_64khz;
logic old_sampleClk;
always_ff @(posedge clk) begin
    old_bitclk <= bitclk;
    old_clk_64khz <= clk_64khz;
    old_sampleClk <= sampleClk;
end

logic signal_bitclk;
logic signal_clk_64khz;
logic signal_sampleClk;
assign signal_bitclk =    !old_bitclk && bitclk;
assign signal_clk_64khz = !old_clk_64khz && clk_64khz;
assign signal_sampleClk = !old_sampleClk && sampleClk;


logic[15:0] i_sample;
logic[7:0] i_ready;
logic[7:0] isPlaying;
logic[3:0] channelState = 0;
logic[1:0] loadingState = 0;
logic[1:0] nextLoadingState;

localparam SEND_ADDRESS = 0;
localparam RECEIVE_DATA = 1;
localparam PASS_DATA    = 2;


always_comb begin
    case (loadingState)
        SEND_ADDRESS: if(m_axil_arvalid && m_axil_arready && channelState < 8) nextLoadingState = RECEIVE_DATA;
        RECEIVE_DATA: if(m_axil_rvalid && m_axil_rready) nextLoadingState = PASS_DATA;
        PASS_DATA: nextLoadingState = SEND_ADDRESS;
        default: nextLoadingState = loadingState;
    endcase
    if(!aresetn)
        nextLoadingState = 0;
end

always_ff @(posedge aclk) loadingState <= nextLoadingState;

//AXI ADDRESS READ
always @(posedge aclk) begin
	if (!aresetn)
		m_axil_arvalid <= 0;
	else if (!m_axil_arvalid || m_axil_arready)
		m_axil_arvalid <= channelState < 8 && (nextLoadingState == SEND_ADDRESS);
end

always @(posedge aclk) begin
	if (!aresetn)
		m_axil_araddr <= 0;
	else if (!m_axil_arvalid || m_axil_arready)
	begin
		case (channelState)
            0: m_axil_araddr <= o_nextSampleAddress[0];
            1: m_axil_araddr <= o_nextSampleAddress[1];
            2: m_axil_araddr <= o_nextSampleAddress[2];
            3: m_axil_araddr <= o_nextSampleAddress[3];
            4: m_axil_araddr <= o_nextSampleAddress[4];
            5: m_axil_araddr <= o_nextSampleAddress[5];
            6: m_axil_araddr <= o_nextSampleAddress[6];
            7: m_axil_araddr <= o_nextSampleAddress[7];
            default: m_axil_araddr <= o_nextSampleAddress[0];
        endcase
    end
end
// AXI ADDRESS READ END

// AXI READ
always @(posedge aclk) begin
		m_axil_rready <= channelState < 8 && loadingState == RECEIVE_DATA;
end

always @(posedge aclk) begin
	if (m_axil_rvalid && m_axil_rready) begin
        i_sample <= {m_axil_rdata[7:0], m_axil_rdata[15:8]};
    end
end

//AXI READ END

always_ff @(posedge aclk) begin
    i_ready <= 0;
    if(loadingState == PASS_DATA) begin
        case (channelState)
            4'd0: begin
                i_ready[0] <= 1;
                channelState <= 1;
            end
            4'd1: begin
                i_ready[1] <= 1;
                channelState <= 2;
            end
            4'd2: begin
                i_ready[2] <= 1;
                channelState <= 3;
            end
            4'd3: begin
                i_ready[3] <= 1;
                channelState <= 4;
            end
            4'd4: begin
                i_ready[4] <= 1;
                channelState <= 5;
            end
            4'd5: begin
                i_ready[5] <= 1;
                channelState <= 6;
            end
            4'd6: begin
                i_ready[6] <= 1;
                channelState <= 7;
            end
            4'd7: begin
                i_ready[7] <= 1;
                channelState <= 8;
            end
        endcase
    end

    if(signal_sampleClk && channelState >= 8) begin
        channelState <= 0;
    end
    if (rst) begin
        i_ready <= 0;
        channelState <= 0;
    end
end


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

logic[31:0] leftSample[8];
logic[31:0] rightSample[8];
genvar lrIter;
for (lrIter = 0; lrIter < 8; lrIter++) begin
    assign leftSample[lrIter][15:0]  = (isMono[lrIter] || !isRight[lrIter]) ? sample[lrIter] : 0;
    assign leftSample[lrIter][31:16] = (isMono[lrIter] || !isRight[lrIter]) ? {16{sample[lrIter][15]}} : 0;
    assign rightSample[lrIter][15:0]  = (isMono[lrIter] || isRight[lrIter]) ? sample[lrIter] : 0;
    assign rightSample[lrIter][31:16] = (isMono[lrIter] || isRight[lrIter]) ? {16{sample[lrIter][15]}} : 0;
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

logic[15:0] finalSample;
assign finalSample = sampleClk ? rightFinalMix : leftFinalMix; //sampleClk == 0 <==> left


logic[15:0] latchedFinalSample;
logic[3:0] bitIndex = 4'b0;
always_ff @(posedge bitclk) begin
    bitIndex <= bitIndex + 1;
    if(bitIndex == 15)
        latchedFinalSample <= finalSample;
end
 
I2STransmitter I2STransmitter 
(
    .clk(clk),
    .dataIn(latchedFinalSample),
    .bitclk(bitclk),
    .dataOut(audio_dout)
);

assign audio_bclk = bitclk;
assign audio_lrclk = sampleClk;
endmodule