`timescale 1ns/1ns
module Counter_tb;

    // Global parameters
    localparam HALF_CLOCK_CYCLE = 5;
    localparam CLOCK_CYCLE = 2 * HALF_CLOCK_CYCLE;
    localparam TEST_AMOUNT = 10;

    // Global variables
    int test = 0;
    int successful_tests = 0;

    // Global logic
    logic clk;
    logic rst;

    // Clock generation
    initial clk = 0;
    always #(HALF_CLOCK_CYCLE) clk = ~clk;
    
    // Timer-specific logic
    logic [7:0] write;
    logic [31:0] data_in[7:0];
    logic [7:0] timer_interrupt;
    logic [31:0] data_out[7:0];

    // Timer instances
    genvar i;
    generate
        for (i = 0; i < 8; i++) begin : timer_instances
            Timer #(
                .TIMER_ADDITIONAL_BITS(i)
            ) uut (
                .clk(clk),
                .rst(rst),
                .write(write[i]),
                .data_in(data_in[i]),
                .timer_interrupt(timer_interrupt[i]),
                .data_out(data_out[i])
            );
        end
    endgenerate

    // Testbench execution
    initial begin
        rst = 1;
        apply_reset();

        fork
            repeat(TEST_AMOUNT) testTimer(7);
            repeat(TEST_AMOUNT) testTimer(6);
            repeat(TEST_AMOUNT) testTimer(5);
            repeat(TEST_AMOUNT) testTimer(4);
            repeat(TEST_AMOUNT) testTimer(3);
            repeat(TEST_AMOUNT) testTimer(2);
            repeat(TEST_AMOUNT) testTimer(1);
            repeat(TEST_AMOUNT) testTimer(0);
        join

        $display("%d/%d Tests ran successfully!", successful_tests, test);
        $finish;
    end

    // Task: Test Timer module
    task automatic testTimer(integer idx);
        int randomTime;
        int counter;
        int this_test;

        test++;
        this_test = test;
        randomTime = $urandom_range(0, 2000);
        counter = 0;

        // Initialize test conditions
        #(CLOCK_CYCLE);
        data_in[idx] <= randomTime;
        #(CLOCK_CYCLE);
        write[idx] <= 1'b1;
        #(CLOCK_CYCLE);
        write[idx] <= 1'b0;
        #(CLOCK_CYCLE);

        // Wait for interrupt
        while (timer_interrupt[idx] == 1'b0) begin
            @(posedge clk);
            counter = counter + 1;
        end

        // Validate results
        if (counter / 2**idx != randomTime) begin
            $display("Test: %d in Timer Module[%d] Error: Counter: %d Should: %d", this_test, idx, counter / 2**idx, randomTime);
        end else begin
            successful_tests++;
            `ifdef CONFIRM
            $display("Test %d successful!", this_test);
            `endif
        end
    endtask

    // Task: Apply reset
    task apply_reset();
        rst <= 1'b1;
        repeat(2) @(posedge clk);
        rst <= 1'b0;
        #(CLOCK_CYCLE);
    endtask

    // Generate VCD file if enabled
    `ifdef VCD
        initial begin
            $dumpfile("timer_tb.vcd");
            $dumpvars(0, Timer_tb);
        end
    `endif

endmodule
