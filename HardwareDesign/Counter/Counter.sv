module Counter (
    input logic clk,
    input logic rst,

    output logic [63:0] data_out
);


    always_ff @(posedge clk) begin      
        data_out <= data_out + 1;
        if(rst) begin
            data_out <= 0;
        end
    end

endmodule
/*
=== Counter ===

   Number of wires:                 37
   Number of wire bits:            163
   Number of public wires:          37
   Number of public wire bits:     163
   Number of ports:                  3
   Number of port bits:             66
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                 97
     CCU2C                          32
     LUT4                            1
     TRELLIS_FF                     64
*/
