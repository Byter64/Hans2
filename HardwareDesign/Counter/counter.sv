module counter #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32,
    parameter STRB_WIDTH = 4
) (
    input logic                              aclk,
    input logic                              aresetn,

    /*
     * AXI lite slave interfaces
     */
    input logic[ADDR_WIDTH-1:0]             s_axil_araddr,
    input logic                              s_axil_arvalid,
    output logic                             s_axil_arready,
    output logic[DATA_WIDTH-1:0]             s_axil_rdata,
    output logic[1:0]                        s_axil_rresp,
    output logic                             s_axil_rvalid,
    input logic                              s_axil_rready
);

    assign s_axil_rresp = 0;

    initial begin 
        assert (DATA_WIDTH > 0); 
    end

    logic[DATA_WIDTH-1:0] next_rData; //Assign the data here
    logic[63:0] counter = 0;
    logic[7:0] address;

    always_ff @(posedge aclk) begin      
        counter <= counter + 1;
        if(~aresetn) begin
            counter <= 0;
        end
    end

    always @* begin
        case (address) //So that the CPU can stick to address alignment
            0: next_rData = counter[63:32];
            1: next_rData = counter[55:24];
            2: next_rData = counter[47:16];
            3: next_rData = counter[39:8];
            4: next_rData = counter[31:0];
            default: next_rData = counter[63:32];
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
            address <=  s_axil_araddr[7:2];
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