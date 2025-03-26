module counter #(
    parameter COUNTER_BIT_WIDTH = 64
) (
    input logic clk,
    input logic rst,

    output logic [COUNTER_BIT_WIDTH-1:0] data_out
);
    initial begin 
        assert (COUNTER_BIT_WIDTH > 0); 
    end


    always_ff @(posedge clk) begin      
        data_out <= data_out + 1;
        if(rst) begin
            data_out <= 0;
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
*/