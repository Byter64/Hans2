module Audiosystem_Test (
    input logic clk_25mhz,
    output logic audio_bclk,
    output logic audio_lrclk,
    output logic audio_dout
);


logic clk;
logic rst;

//CPU Interface
logic[31:0] registerData = 0;
logic[3:0] registerSelect = 0;
logic[7:0] channelSelect = 0;
logic masterSelect = 0;

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
    SET_ISRIGHT          = 11
} ChannelSettings;


logic[31:0] initState = 0;
always_ff @(posedge clk_25mhz) begin
    if(!rst) begin
        case (initState)
            0: begin
                channelSelect <= 3;
                registerSelect <= SET_SAMPLECOUNT;
                registerData <= 239616;
                initState <= initState + 1;
            end
            1: begin
                channelSelect <= 3;
                registerSelect <= SET_LOOPEND;
                registerData <= 239615;
                initState <= initState + 1;
            end
            2: begin
                channelSelect <= 3;
                registerSelect <= SET_ISLOOPING;
                registerData <= 1;
                initState <= initState + 1;
            end
            3: begin
                channelSelect <= 3;
                registerSelect <= SET_ISMONO;
                registerData <= 0;
                initState <= initState + 1;
            end
            4: begin
                channelSelect <= 1;
                registerSelect <= SET_ISRIGHT;
                registerData <= 0;
                initState <= initState + 1;
            end
            5: begin
                channelSelect <= 2;
                registerSelect <= SET_ISRIGHT;
                registerData <= 1;
                initState <= initState + 1;
            end
            6: begin
                channelSelect <= 3;
                registerSelect <= SET_ISPLAYING;
                registerData <= 1;
                initState <= initState + 1;
            end
        endcase
    end
end

//Memory Interface (AXI Lite Master)
logic           aclk;
logic           aresetn;
logic [31:0]    m_axil_awaddr;
logic [2:0]     m_axil_awprot;
logic           m_axil_awvalid;
logic           m_axil_awready;

logic [15:0]    m_axil_wdata;
logic [1:0]     m_axil_wstrb;
logic           m_axil_wvalid;
logic           m_axil_wready;

logic  [1:0]    m_axil_bresp;
logic           m_axil_bvalid;
logic           m_axil_bready;

logic [31:0]    m_axil_araddr;
logic [2:0]     m_axil_arprot;
logic           m_axil_arvalid;
logic           m_axil_arready;

logic  [15:0]   m_axil_rdata;
logic  [1:0]    m_axil_rresp;
logic           m_axil_rvalid;
logic           m_axil_rready;

assign clk = clk_25mhz;
assign aclk = clk;
assign aresetn = ~rst;

logic[15:0] resetCounter = 0;
always_ff @(posedge clk) begin
    if(resetCounter != 49 * 12)
        resetCounter <= resetCounter + 1;
end
assign rst = resetCounter != 49 * 12;

Audiosystem Audiosystem 
(
    .*
);

AXILiteMemory #(
    .DATA_WIDTH(16),
    .MEMORY_DEPTH(239616)
) AXILiteMemory (
    .aclk(aclk),
    .aresetn(aresetn),
    .s_axil_awvalid(m_axil_awvalid),
    .s_axil_awaddr(m_axil_awaddr),
    .s_axil_awprot(m_axil_awprot),
    .s_axil_awready(m_axil_awready),
    .s_axil_wdata(m_axil_wdata),
    .s_axil_wstrb(m_axil_wstrb),
    .s_axil_wvalid(m_axil_wvalid),
    .s_axil_wready(m_axil_wready),
    .s_axil_bvalid(m_axil_bvalid),
    .s_axil_bready(m_axil_bready),
    .s_axil_araddr(m_axil_araddr),
    .s_axil_arprot(m_axil_arprot),
    .s_axil_arvalid(m_axil_arvalid),
    .s_axil_arready(m_axil_arready),
    .s_axil_rdata(m_axil_rdata),
    .s_axil_rresp(m_axil_rresp),
    .s_axil_rvalid(m_axil_rvalid),
    .s_axil_rready(m_axil_rready)
    
);


endmodule