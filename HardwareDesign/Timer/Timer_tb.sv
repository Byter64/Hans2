`timescale 1ns/1ns
module Timer_tb;
    //global parameters
    localparam HALF_CLOCK_CYCLE = 5;
    localparam CLOCK_CYCLE = 2*HALF_CLOCK_CYCLE;
    
    //global variables
    int test = 0;
    int sucessfull_tests = 0;
   
    localparam test_amount = 10;
    //global logic
    logic clk;
    logic rst;

    initial clk = 0;
    always #(HALF_CLOCK_CYCLE) clk = ~clk;
        
    //logic for test
    logic [7:0] write;
    logic [31:0] data_in[7:0];

    logic [7:0] timer_interrupt;
    logic [31:0] data_out[7:0];

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

    initial begin
        rst = 1;
        apply_reset();
        fork
            repeat(test_amount) testTimer(7);
            repeat(test_amount) testTimer(6);
            repeat(test_amount) testTimer(5);
            repeat(test_amount) testTimer(4);
            repeat(test_amount) testTimer(3);
            repeat(test_amount) testTimer(2);
            repeat(test_amount) testTimer(1);
            repeat(test_amount) testTimer(0);
        join
        $display("%d/%d Tests ran successfully!", sucessfull_tests,test);
        // End of simulation
        $finish;
    end



    //task that tests module
    task automatic testTimer(integer i);
        //Variables for Task
        integer randomTime;
        integer counter;
        integer thistest;
        automatic int this_test;
        test++;
        this_test = test;
        randomTime = $urandom_range(0,2000);
        counter = 0;
        #(CLOCK_CYCLE)
        data_in[i] <= randomTime;
        #(CLOCK_CYCLE)
        write[i] <= 1'b1;
        #(CLOCK_CYCLE)
        write[i] <= 1'b0;
        #(CLOCK_CYCLE);
        while(timer_interrupt[i] == 1'b0) begin
            @(posedge clk)
            counter = counter + 1;
        end
        if(counter/2**i!=randomTime) begin
            $display("Test: %D in Timer Modul[%D] Error: Counter: %D Should: %D",this_test,i,counter/2**i,randomTime);
        end
        else begin
            sucessfull_tests++;
            `ifdef CONFIRM
            $display("Test %d sucessfull!", this_test);
            `endif
        end
    endtask

    //Reset task
    task apply_reset();
        rst <= 1'b1;
        repeat(2) @(posedge clk) 
        rst <= 1'b0;
        #(CLOCK_CYCLE);
    endtask

    //Print VCD if necessary
    `ifdef VCD
        initial begin
            $dumpfile("timer_tb.vcd");
            $dumpvars(0);
        end
    `endif
endmodule
