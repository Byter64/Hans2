`timescale 1ns/1ns
module counter_tb;
    //global parameters
    localparam HALF_CLOCK_CYCLE = 5;
    localparam CLOCK_CYCLE = 2*HALF_CLOCK_CYCLE;
    localparam COUNTER_BIT_WIDTH = 32;
    
    //global variables
    integer test = 0;
    integer sucessfull_tests = 0;
   
    //global logic
    logic clk;
    logic rst;
    logic [COUNTER_BIT_WIDTH-1:0] data_out;

    initial clk = 0;
    always #(HALF_CLOCK_CYCLE) clk = ~clk;
    

    //module instantiation
    counter #(
        .COUNTER_BIT_WIDTH(COUNTER_BIT_WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .data_out(data_out)
    );

    // Main testbench process
    initial begin
        rst = 1;
        repeat(10) testCounter();
        
        $display("%d/%d Tests ran successfully!", sucessfull_tests, test);

        // End of simulation
        $finish;
    end

    //Variables for Task
    integer expected_value;
    integer cycles_to_test;

    //task that tests module
    task testCounter();
        test++;
        cycles_to_test = $urandom_range(1, 1000);
        expected_value = 0;
        
        // Reset the counter
        apply_reset();
        
        // Count for specified number of cycles
        for (int i = 0; i < cycles_to_test; i++) begin
            @(posedge clk);
            expected_value++;
        end
        
        // Check counter value
        if(data_out != expected_value) begin
            $display("Test %D Failed: Counter: %D Expected: %D", test, data_out, expected_value);
        end
        else begin
            sucessfull_tests++;
            `ifdef CONFIRM
            $display("Test %d passed!", test);
            `endif
        end
        repeat(2) @(posedge clk); 
    endtask

    //Reset task
    task apply_reset();
        rst <= 1;
        repeat(2) @(posedge clk) 
        rst <= 0;
    endtask

    //Print VCD if necessary
    `ifndef VCD
        initial begin
            $dumpfile("counter_tb.vcd");
            $dumpvars(0);
        end
    `endif
endmodule