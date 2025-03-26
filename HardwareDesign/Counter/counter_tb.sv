`timescale 1ns/1ns
module counter_tb;

    // Global parameters
    localparam HALF_CLOCK_CYCLE = 5;
    localparam CLOCK_CYCLE = 2 * HALF_CLOCK_CYCLE;
    localparam TEST_AMOUNT = 10;

    // Global variables
    int test = 0;
    int successful_tests = 0;

    // Global logic
    logic clk;

    // Clock generation
    initial clk = 0;
    always #(HALF_CLOCK_CYCLE) clk = ~clk;

    logic [63:0] data_out [8];
    logic [7:0]  rst = 0;
    
    // Counter-specific logic
    genvar i;
    generate
        for (i = 0; i < 8; i++) begin : counter_instances
            counter #(
                .COUNTER_BIT_WIDTH(8 + i*8) // Different bit widths
            ) uut (
                .clk(clk),
                .rst(rst[i]),
                .data_out(data_out[i])
            );
        end
    endgenerate

    // Testbench execution
    initial begin
        fork
            repeat(TEST_AMOUNT) testCounter(7, 8 + 7*8);
            repeat(TEST_AMOUNT) testCounter(6, 8 + 6*8);
            repeat(TEST_AMOUNT) testCounter(5, 8 + 5*8);
            repeat(TEST_AMOUNT) testCounter(4, 8 + 4*8);
            repeat(TEST_AMOUNT) testCounter(3, 8 + 3*8);
            repeat(TEST_AMOUNT) testCounter(2, 8 + 2*8);
            repeat(TEST_AMOUNT) testCounter(1, 8 + 1*8);
            repeat(TEST_AMOUNT) testCounter(0, 8 + 0*8);
        join

        $display("%d/%d Tests ran successfully!", successful_tests, test);
        $finish;
    end

    // Task: Test Counter module
    task automatic testCounter(integer idx, integer bit_width);
        longint cycles_to_test;
        longint expected_value;
        int this_test;

        test++;
        this_test = test;
        cycles_to_test = $urandom_range(10, 255*(idx+1));
        expected_value = 0;

        apply_reset(idx);

        // Wait and count cycles
        for (int i = 0; i < cycles_to_test; i++) begin
            @(posedge clk);
            expected_value++;
        end

        // Validate results
        if (data_out[idx] !== expected_value -1) begin
            $display("%t Test: %d in Counter Module[%d] Error: Counter: %d Should: %d", $time ,this_test, idx, data_out[idx], expected_value);
        end else begin
            successful_tests++;
            `ifdef CONFIRM
            $display("Test %d successful!", this_test);
            `endif
        end
        #(CLOCK_CYCLE * 5);
    endtask

    // Task: Apply reset
    task automatic apply_reset(integer idx);
        rst[idx] <= 1'b1;
        repeat(2) @(posedge clk);
        rst[idx] <= 1'b0;
    endtask

    // Generate VCD file if enabled
    `ifndef VCD
        initial begin
            $dumpfile("counter_tb.vcd");
            $dumpvars(0, counter_tb);
        end
    `endif

endmodule
