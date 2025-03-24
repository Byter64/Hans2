//Please make clk and aclk be the same clock,
module Audiosystem (
    input clk,
    input clk_25mhz,
    input rst,

    //CPU Interface
    input[23:0] registerData,
    input[3:0] registerSelect,
    input[7:0] channelSelect,
    
    //Memory Interface (AXI Lite Master)
    input           aclk,
    input           aresetn,
    output [31:0]   m_axil_awaddr,
    output [2:0]    m_axil_awprot,
    output          m_axil_awvalid,
    input           m_axil_awready,

    output [15:0]   m_axil_wdata,
    output [1:0]    m_axil_wstrb,
    output          m_axil_wvalid,
    input           m_axil_wready,

    input  [1:0]    m_axil_bresp,
    input           m_axil_bvalid,
    output          m_axil_bready,

    output [31:0]   m_axil_araddr,
    output [2:0]    m_axil_arprot,
    output          m_axil_arvalid,
    input           m_axil_arready,

    input  [15:0]   m_axil_rdata,
    input  [1:0]    m_axil_rresp,
    input           m_axil_rvalid,
    output          m_axil_rready,

    //I²S Interface
    output audio_bclk,
    output audio_lrclk,
    output audio_dout
);

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

logic[15:0] i_sample;
logic[7:0] i_ready;
logic[7:0] isPlaying;
logic oldSampleClk;
logic[3:0] loadingState;

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
            default: m_axil_araddr <= 0;
        endcase
    end
end
// AXI ADDRESS READ END

// AXI READ
always @(posedge aclk) begin
		m_axil_rready <= loadingState < 8;
end

always @(posedge aclk) begin
	if (m_axil_rvalid && m_axil_rready) begin
        i_sample <= m_axil_rdata;
        sampleReady <= 1;
    end else begin
        sampleReady <= 0;
    end

end
//AXI READ END

logic sampleReady;
always_ff @(posedge aclk) begin
    oldSampleClk <= sampleClk;
    i_ready <= 0;
    case (loadingState)
        4'd0: begin
            if(sampleReady) begin
                i_ready[0] <= 1;
                loadingState <= 1;
            end
        end
        4'd1: begin
            if(sampleReady) begin
                i_ready[1] <= 1;
                loadingState <= 2;
            end
        end
        4'd2: begin
            if(sampleReady) begin
                i_ready[2] <= 1;
                loadingState <= 3;
            end
        end
        4'd3: begin
            if(sampleReady) begin
                i_ready[3] <= 1;
                loadingState <= 4;
            end
        end
        4'd4: begin
            if(sampleReady) begin
                i_ready[4] <= 1;
                loadingState <= 5;
            end
        end
        4'd5: begin
            if(sampleReady) begin
                i_ready[5] <= 1;
                loadingState <= 6;
            end
        end
        4'd6: begin
            if(sampleReady) begin
                i_ready[6] <= 1;
                loadingState <= 7;
            end
        end
        4'd7: begin
            if(sampleReady) begin
                i_ready[7] <= 1;
                loadingState <= 8;
            end
        end
        default: 
    endcase

    if(oldSampleClk == 0 && oldSampleClk && loadingState >= 8) begin
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