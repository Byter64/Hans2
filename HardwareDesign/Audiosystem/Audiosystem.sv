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
logic[3:0] loadingState = 0;
logic sentFirstAddress;

always_comb begin
    if(!aresetn)
        sentFirstAddress = 0;
    else if(sentFirstAddress == 0 && m_axil_arready && m_axil_arvalid)
        sentFirstAddress = 1;
    else if(sentFirstAddress == 1 && loadingState >= 8)
        sentFirstAddress = 0;
end

//AXI ADDRESS READ
always @(posedge aclk) begin
	if (!aresetn)
		m_axil_arvalid <= 0;
	else if (!m_axil_arvalid || m_axil_arready)
		m_axil_arvalid <= loadingState < 8;
end

always @(posedge aclk) begin
	if (!aresetn)
		m_axil_araddr <= 0;
	else if (!m_axil_arvalid || m_axil_arready)
	begin
		case (loadingState)
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
logic sampleReceived;
logic sampleReady;
always @(posedge aclk) begin
		m_axil_rready <= loadingState < 8 && sentFirstAddress;
end

always @(posedge aclk) begin
	if (m_axil_rvalid && m_axil_rready) begin
        i_sample <= {m_axil_rdata[7:0], m_axil_rdata[15:8]};
        sampleReceived <= 1;
    end else begin
        sampleReceived <= 0;
    end
end

always_ff @(posedge aclk) sampleReady <= sampleReceived;

//AXI READ END

always_ff @(posedge aclk) begin
    i_ready <= 0;
    case (loadingState)
        4'd0: begin
            if(sampleReceived) begin
                i_ready[0] <= 1;
                loadingState <= 1;
            end
        end
        4'd1: begin
            if(sampleReceived) begin
                i_ready[1] <= 1;
                loadingState <= 2;
            end
        end
        4'd2: begin
            if(sampleReceived) begin
                i_ready[2] <= 1;
                loadingState <= 3;
            end
        end
        4'd3: begin
            if(sampleReceived) begin
                i_ready[3] <= 1;
                loadingState <= 4;
            end
        end
        4'd4: begin
            if(sampleReceived) begin
                i_ready[4] <= 1;
                loadingState <= 5;
            end
        end
        4'd5: begin
            if(sampleReceived) begin
                i_ready[5] <= 1;
                loadingState <= 6;
            end
        end
        4'd6: begin
            if(sampleReceived) begin
                i_ready[6] <= 1;
                loadingState <= 7;
            end
        end
        4'd7: begin
            if(sampleReceived) begin
                i_ready[7] <= 1;
                loadingState <= 8;
            end
        end
    endcase

    if(signal_sampleClk && loadingState >= 8) begin
        loadingState <= 0;
    end
    if (rst) begin
        i_ready <= 0;
        loadingState <= 0;
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