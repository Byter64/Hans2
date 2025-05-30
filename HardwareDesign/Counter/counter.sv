module counter #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 3,
    parameter STRB_WIDTH = 1
) (
    input                               aclk,
    input                               aresetn,

    /*
     * AXI lite slave interfaces
     */
    input  [ADDR_WIDTH-1:0]             s_axil_awaddr,
    input  [2:0]                        s_axil_awprot,
    input                               s_axil_awvalid,
    output                              s_axil_awready,
    input  [DATA_WIDTH-1:0]             s_axil_wdata,
    input  [STRB_WIDTH-1:0]             s_axil_wstrb,
    input                               s_axil_wvalid,
    output                              s_axil_wready,
    output [1:0]                        s_axil_bresp,
    output                              s_axil_bvalid,
    input                               s_axil_bready,
    input  [ADDR_WIDTH-1:0]             s_axil_araddr,
    input  [2:0]                        s_axil_arprot,
    input                               s_axil_arvalid,
    output                              s_axil_arready,
    output [DATA_WIDTH-1:0]             s_axil_rdata,
    output [1:0]                        s_axil_rresp,
    output                              s_axil_rvalid,
    input                               s_axil_rready
);
    initial begin 
        assert (DATA_WIDTH > 0); 
    end

    logic[DATA_WIDTH-1:0] next_rData; //Assign the data here
    logic[63:0] counter = 0;
    logic[ADDR_WIDTH-1:0] address;

    always_ff @(posedge aclk) begin      
        counter <= counter + 1;
        if(~aresetn) begin
            counter <= 0;
        end
    end

    logic[63:0] le_counter;
    assign le_counter = {counter[7:0],counter[15:8],counter[23:16],counter[31:24],counter[39:32],counter[47:40],counter[55:48],counter[63:56]};

    always_comb begin : next_rData
        case (address)
            0: next_rData = le_counter[31:0];
            1: next_rData = le_counter[39:8];
            2: next_rData = le_counter[47:16];
            3: next_rData = le_counter[55:24];
            4: next_rData = le_counter[63:32];
            default: next_rData = le_counter[63:32];
        endcase
    end

    logic next_rvalid;
    assign next_rvalid = 1; //Assign your valid logic to this signal
    always_ff @(posedge aclk) begin
        if (!aresetn)
            s_axil_rvalid <= 0;
        else if (!s_axil_rvalid || s_axil_rready) begin
            s_axil_rvalid <= next_rvalid;
        end
    end

    always_ff @(posedge aclk) begin
        if (!aresetn)
            s_axil_rdata <= 0;
        else if (!s_axil_rvalid || s_axil_rready)
        begin
            s_axil_rdata <= next_rData;

            if (!next_rvalid)
                s_axil_rdata <= 0;
        end
    end

    always_ff @(posedge aclk) begin
		// Logic to determine S_AXIS_TREADY
        s_axil_arready <= 1;
    end

    always_ff @(posedge aclk) begin
        if (s_axil_arvalid && s_axil_arready) begin //Never add any other conditions. This is likely to break axi
            // Do something
            address <=  s_axil_araddr;
        end
    end

endmodule

/*
64 Bit
=== counter ===
Number of wires:                 37
Number of wire bits:            163
Number of public wires:          37
Number of public wire bits:     163
Number of ports:                  3
Number of port bits:             66
Number of memories:               0
Number of memory bits:            0
Number of processes:              0
Number of cells:                 98
  $check                          1
  CCU2C                          32
  LUT4                            1
  TRELLIS_FF                     64

WITH AXI-L :/
[build] === counter ===
[build] 
[build]    Number of wires:                 97
[build]    Number of wire bits:            496
[build]    Number of public wires:          97
[build]    Number of public wire bits:     496
[build]    Number of ports:                 21
[build]    Number of port bits:             93
[build]    Number of memories:               0
[build]    Number of memory bits:            0
[build]    Number of processes:              0
[build]    Number of cells:                236
[build]      $check                          1
[build]      CCU2C                          32
[build]      LUT4                          103
[build]      TRELLIS_FF                    100
*/