//Please make clk and aclk be the same clock, as well as rst == !aresetn
//Be aware, that unfortunate timing of changing channel settings can lead
//To channels being off by 1 sample
module Audiosystem (
    input logic            clk,
    input logic            clk_25mhz,
    input logic            rst,

    input logic            aclk,
    input logic            aresetn,
    //CPU Interface (AXI Late Slave)
    input logic [31:0]     s_axil_awaddr,
    input logic            s_axil_awvalid,
    output logic           s_axil_awready,
    input logic [31:0]     s_axil_wdata,
    input logic [3:0]      s_axil_wstrb,
    input logic            s_axil_wvalid,
    output logic           s_axil_wready,
    output logic [1:0]     s_axil_bresp,
    output logic           s_axil_bvalid,
    input logic            s_axil_bready,

    
    //Memory Interface (AXI Lite Master)
    output logic[31:0]     m_axil_araddr,
    output logic           m_axil_arvalid,
    input logic            m_axil_arready,
    input logic[31:0]      m_axil_rdata,
    input logic            m_axil_rvalid,
    output logic           m_axil_rready,

    //I²S Interface
    output logic           audio_bclk,
    output logic           audio_lrclk,
    output logic           audio_dout,

    //Clock
    output logic           clk_32khz
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
        SET_ISRIGHT         = 11,
        SET_GLOBAL_VOLUME   = 12,
		SET_CHANNEL_SELECT	= 13
    } ChannelSettings;

logic[7:0] isMono;
logic[7:0] isRight;
logic[15:0] sample[8];
logic[31:0] o_nextSampleAddress[8];

logic sampleClk; //This is also the Word Select for the left/right channel
logic clk_64khz;
logic bitclk;
ClockGenerator ClockGenerator 
(
    .clk_25mhz(clk_25mhz),
    .clk_1024khz(bitclk),
    .clk_64khz(clk_64khz),
    .clk_32khz(clk_32khz)
);
assign sampleClk = clk_32khz;


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
logic[3:0] nextChannelState;
logic[1:0] loadingState = 0;
logic[1:0] nextLoadingState;

localparam SEND_ADDRESS = 0;
localparam RECEIVE_DATA = 1;
localparam PASS_DATA    = 2;
localparam SKIP_CHANNEL = 3;

always_comb begin
    nextChannelState = channelState;
    if(loadingState == PASS_DATA || loadingState == SKIP_CHANNEL) begin
        case (channelState)
            4'd0: nextChannelState = 1;
            4'd1: nextChannelState = 2;
            4'd2: nextChannelState = 3;
            4'd3: nextChannelState = 4;
            4'd4: nextChannelState = 5;
            4'd5: nextChannelState = 6;
            4'd6: nextChannelState = 7;
            4'd7: nextChannelState = 8;
        endcase
    end

    if(signal_sampleClk && channelState >= 8) nextChannelState = 0;
    if (rst) nextChannelState = 8;
end

always @(posedge aclk) channelState <= nextChannelState;


logic nextIsPlaying;
assign nextIsPlaying = nextChannelState == 0 ? isPlaying[0] : 
                       nextChannelState == 1 ? isPlaying[1] : 
                       nextChannelState == 2 ? isPlaying[2] : 
                       nextChannelState == 3 ? isPlaying[3] : 
                       nextChannelState == 4 ? isPlaying[4] : 
                       nextChannelState == 5 ? isPlaying[5] : 
                       nextChannelState == 6 ? isPlaying[6] : 
                       nextChannelState == 7 ? isPlaying[7] : isPlaying[0];

always_comb begin
    nextLoadingState = loadingState;
    case (loadingState)
        SEND_ADDRESS: if(m_axil_arvalid && m_axil_arready && channelState < 8) nextLoadingState = RECEIVE_DATA;
        RECEIVE_DATA: if(m_axil_rvalid && m_axil_rready) nextLoadingState = PASS_DATA;
        PASS_DATA: nextLoadingState = nextIsPlaying ? SEND_ADDRESS : SKIP_CHANNEL;
        SKIP_CHANNEL: nextLoadingState = nextIsPlaying ? SEND_ADDRESS : SKIP_CHANNEL;
        default: nextLoadingState = loadingState;
    endcase
    if(!aresetn)
        nextLoadingState = SKIP_CHANNEL;
end


always_ff @(posedge aclk) loadingState <= nextLoadingState;

//###############################################
//AXI MASTER
//AXI ADDRESS READ
logic[31:0] next_m_araddr;

always_comb begin
    case (nextChannelState)
        0: next_m_araddr        = o_nextSampleAddress[0];
        1: next_m_araddr        = o_nextSampleAddress[1];
        2: next_m_araddr        = o_nextSampleAddress[2];
        3: next_m_araddr        = o_nextSampleAddress[3];
        4: next_m_araddr        = o_nextSampleAddress[4];
        5: next_m_araddr        = o_nextSampleAddress[5];
        6: next_m_araddr        = o_nextSampleAddress[6];
        7: next_m_araddr        = o_nextSampleAddress[7];
        default: next_m_araddr  = o_nextSampleAddress[0];
    endcase
end

always_ff @(posedge aclk) begin
	if (!aresetn)
		m_axil_arvalid <= 0;
	else if (!m_axil_arvalid || m_axil_arready)
		m_axil_arvalid <= channelState < 8 && (nextLoadingState == SEND_ADDRESS);
end

always_ff @(posedge aclk) begin
	if (!aresetn)
		m_axil_araddr <= 0;
	else if (!m_axil_arvalid || m_axil_arready)
	begin
		m_axil_araddr <= { next_m_araddr[31:2], 2'b00 };
    end
end
// AXI ADDRESS READ END

// AXI READ
always_ff @(posedge aclk) begin
		m_axil_rready <= channelState < 8 && loadingState == RECEIVE_DATA;
end

always_ff @(posedge aclk) begin
	if (m_axil_rvalid && m_axil_rready) begin
        if(next_m_araddr[1])
            i_sample <= m_axil_rdata[31:16];
        else
            i_sample <= m_axil_rdata[15:0];
    end
end

//AXI READ END

//##################################################
//AXI SLAVE
//CPU Interface
logic[31:0] registerData;
logic[3:0]  registerSelect; //s_axil_xdata[5:2]
logic[7:0]  channelSelect;

`ifndef SYNTHESIS
logic[20 * 8 -1:0] dbg_registerSelect;
always_comb begin
    case (registerSelect)
        IDLE                : dbg_registerSelect = "IDLE";
        SET_STARTADDRESS    : dbg_registerSelect = "SET_STARTADDRESS";
        SET_SAMPLECOUNT     : dbg_registerSelect = "SET_SAMPLECOUNT";
        SET_LOOPSTART       : dbg_registerSelect = "SET_LOOPSTART";
        SET_LOOPEND         : dbg_registerSelect = "SET_LOOPEND";
        SET_CURRENTPOSITION : dbg_registerSelect = "SET_CURRENTPOSITION";
        SET_LASTSAMPLE      : dbg_registerSelect = "SET_LASTSAMPLE";
        SET_VOLUME          : dbg_registerSelect = "SET_VOLUME";
        SET_ISLOOPING       : dbg_registerSelect = "SET_ISLOOPING";
        SET_ISPLAYING       : dbg_registerSelect = "SET_ISPLAYING";
        SET_ISMONO          : dbg_registerSelect = "SET_ISMONO";
        SET_ISRIGHT         : dbg_registerSelect = "SET_ISRIGHT";
        SET_GLOBAL_VOLUME   : dbg_registerSelect = "SET_GLOBAL_VOLUME";
        SET_CHANNEL_SELECT	: dbg_registerSelect = "SET_CHANNEL_SELECT";
    endcase
end
`endif

//AW
always_ff @(posedge aclk) s_axil_awready <= 1;

always_ff @(posedge aclk) begin
	if (s_axil_awvalid && s_axil_awready) begin //Never add any other conditions. This is likely to break axi
		registerSelect <= s_axil_awaddr[5:2];
    end
end

//W
always_ff @(posedge aclk) s_axil_wready <= 1;

logic write_happened;
always_ff @(posedge aclk) begin
    write_happened <= 0;
	if (s_axil_wvalid && s_axil_wready) begin //Never add any other conditions. This is likely to break axi
		if(registerSelect == SET_CHANNEL_SELECT)
			channelSelect <= s_axil_wdata[7:0];
		else
			registerData <= s_axil_wdata;
        write_happened <= 1;
    end
end

//B
assign s_axil_bvalid = 1;
assign s_axil_bresp = 0;


always_ff @(posedge aclk) begin
    i_ready <= 0;
    if(loadingState == PASS_DATA) begin
        case (channelState)
            4'd0: i_ready[0] <= 1;
            4'd1: i_ready[1] <= 1;
            4'd2: i_ready[2] <= 1;
            4'd3: i_ready[3] <= 1;
            4'd4: i_ready[4] <= 1;
            4'd5: i_ready[5] <= 1;
            4'd6: i_ready[6] <= 1;
            4'd7: i_ready[7] <= 1;
        endcase
    end

    if (rst) begin
        i_ready <= 0;
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
            .w_valid(channelSelect[i] && write_happened),//CPU Interface

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

logic[7:0] masterVolume = 128;
always_ff @(posedge clk) begin
    if(registerSelect == SET_GLOBAL_VOLUME)
        masterVolume <= registerData;
    
    if(rst)
        masterVolume <= 128;
end

logic[31:0] leftMix;
logic[31:0] rightMix;
logic[31:0] leftAmplifiedMix;
logic[31:0] rightAmplifiedMix;
logic[15:0] leftFinalMix;
logic[15:0] rightFinalMix;
assign leftMix = leftSample[0] + leftSample[1] + leftSample[2] + leftSample[3] + 
                 leftSample[4] + leftSample[5] + leftSample[6] + leftSample[7];

assign rightMix = rightSample[0] + rightSample[1] + rightSample[2] + rightSample[3] + 
                  rightSample[4] + rightSample[5] + rightSample[6] + rightSample[7];

assign leftAmplifiedMix = ($signed(leftMix) * $signed({1'b0, masterVolume})) >>> 7;
assign rightAmplifiedMix = ($signed(rightMix) * $signed({1'b0, masterVolume})) >>> 7;

assign leftFinalMix = $signed(leftAmplifiedMix) > $signed(32767) ? 32767 : 
                      $signed(leftAmplifiedMix) < $signed(-32768) ? $signed(-32768) :
                      $signed(leftAmplifiedMix);

assign rightFinalMix = $signed(rightAmplifiedMix) > $signed(32767) ? 32767 : 
                       $signed(rightAmplifiedMix) < $signed(-32768) ? $signed(-32768) :
                       $signed(rightAmplifiedMix);

logic[15:0] finalSample;
assign finalSample = sampleClk ? rightFinalMix : leftFinalMix; //sampleClk == 0 <==> left


logic[15:0] latchedFinalSample1;
logic[15:0] latchedFinalSample2;
logic[3:0] bitIndex = 4'b0;
always_ff @(posedge bitclk) begin
    bitIndex <= bitIndex + 1;
    if(bitIndex == 15) begin
        latchedFinalSample1 <= finalSample;
        latchedFinalSample2 <= latchedFinalSample1;
    end
end 
 
I2STransmitter I2STransmitter 
(
    .clk(clk),
    .dataIn(latchedFinalSample2),
    .bitclk(bitclk),
    .dataOut(audio_dout)
);

assign audio_bclk = bitclk;
assign audio_lrclk = sampleClk;
endmodule