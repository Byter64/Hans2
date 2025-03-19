`timescale 1ns/1ns
module debouncer_tb;

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
    
    // debouncer-specific logic
    logic [7:0] btn_i = 0;
    logic [7:0] btn_o;

    // Timer instances
    genvar i;
    generate
        for (i = 0; i < 8; i++) begin : timer_instances
            Debouncer #(
                .DEBOUNCE_BITS(8+i)
            ) uut (
                .clk(clk),
                .btn_i(btn_i[i]),
                .btn_o(btn_o[i])
            );
        end
    endgenerate

    // Testbench execution
    initial begin
        fork
            repeat(TEST_AMOUNT) testDebouncer(7);
            repeat(TEST_AMOUNT) testDebouncer(6);
            repeat(TEST_AMOUNT) testDebouncer(5);
            repeat(TEST_AMOUNT) testDebouncer(4);
            repeat(TEST_AMOUNT) testDebouncer(3);
            repeat(TEST_AMOUNT) testDebouncer(2);
            repeat(TEST_AMOUNT) testDebouncer(1);
            repeat(TEST_AMOUNT) testDebouncer(0);
        join

        $display("%d/%d Tests ran successfully!", successful_tests, test);
        $finish;
    end

    // Task: Test Timer module
    task automatic testDebouncer(integer idx);
        int randomTime;
        int randomAmount;
        int counter;
        int this_test;
        int finished = 0;

        test++;
        this_test = test;
        randomTime = $urandom_range(1, 5);
        randomAmount = $urandom_range(10, 15);
        fork
            begin
                for(int i = 0; i< randomAmount; i++) begin
                    #(randomTime) btn_i[idx] <= ~btn_i[idx];
                end
                #1 btn_i[idx] <= 1;
                #(CLOCK_CYCLE*5) btn_i[idx] <= 0;
                finished = 1;
            end
            begin 
                while(finished == 0) begin
                    @(posedge clk);
                    if(btn_o[idx]) counter = counter + 1;
                end
            end
        join
        repeat(10) begin
            @(posedge clk);
                if(btn_o[idx]) counter = counter + 1;
        end

        // Initialize test conditions
        #(CLOCK_CYCLE);

        // Validate results
        if (counter != 1) begin
            $display("Test: %d in Debouncer Module[%d] Error: Counter: %d Should: %d", this_test, idx, counter, 1);
        end else begin
            successful_tests++;
            `ifdef CONFIRM
            $display("Test %d successful!", this_test);
            `endif
        end
        #(CLOCK_CYCLE * (2**(8+idx)));
    endtask

    // Generate VCD file if enabled
    `ifdef VCD
        initial begin
            $dumpfile("debouncer_tb.vcd");
            $dumpvars(0, debouncer_tb);
        end
    `endif

endmodule
