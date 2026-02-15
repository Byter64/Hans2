`timescale 1ns/1ns
module top;
    logic        clk_25mhz = 0;
    logic        sd_clk;
    logic        sd_cmd;
    logic [3:0]  sd_d;


    top_ulx3s_sd_mem dut(
        .clk_25mhz(clk_25mhz),
        .sd_clk(sd_clk),
        .sd_cmd(sd_cmd),
        .sd_d(sd_d)
    );
    always #5 clk_25mhz = ~clk_25mhz;
    integer idx;
    initial begin
        $dumpfile("dump.vcd");

        $dumpvars(0,top);
        for (idx = 0; idx < 128; idx++) begin
        $dumpvars(0,top.dut.sd_inst.ram[idx]); 
        end
        for (idx = 0; idx < 1024; idx++) begin
        $dumpvars(0,top.dut.sd_inst.sd1.ram[idx]); 
        end
        #4000000
        $finish;
    end
endmodule