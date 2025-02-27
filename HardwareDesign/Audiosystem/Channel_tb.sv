`timescale 1ns/1ns
module Channel_tb;
    //global parameters
    localparam HALF_CLOCK_CYCLE = 5;
    localparam CLOCK_CYCLE = 2*HALF_CLOCK_CYCLE;
    
    //global variables
    integer test = 0;
    integer sucessfull_tests = 0;
   
    //global logic
    logic clk;
    logic rst;

    initial clk = 0;
    always #(HALF_CLOCK_CYCLE) clk = ~clk;
    

    //parameters for test
    localparam TIMER_ADDITIONAL_BITS = 8;
    
    //logic for test
    logic write;
    logic [31:0] data_in;

    logic timer_interrupt;
    logic [31:0] data_out;

    //module instantiations
    Timer #(
        .TIMER_ADDITIONAL_BITS(TIMER_ADDITIONAL_BITS)
    ) uut (
        .clk(clk),
        .rst(rst),
        .write(write),
        .data_in(data_in),
        .timer_interrupt(timer_interrupt),
        .data_out(data_out)
    );

    // Main testbench process
    initial begin
        rst = 1;
        apply_reset();
        testTimer();
        apply_reset();
        repeat(10) testTimer();
        
        $display("%d/%d Tests ran successfully!", sucessfull_tests,test);

        // End of simulation
        $finish;
    end

    //Variables for Task
    integer randomTime;
    integer counter;

    //task that tests module
    task testTimer();
        test++;
        randomTime = $urandom_range(0,2000);
        counter = 0;
        #(CLOCK_CYCLE)
        data_in <= randomTime;
        #(CLOCK_CYCLE)
        write <= 1;
        #(CLOCK_CYCLE)
        write <= 0;
        #(CLOCK_CYCLE);
        while(timer_interrupt == 0) begin
            @(posedge clk)
            counter = counter + 1;
        end
        if(counter/2**TIMER_ADDITIONAL_BITS!=randomTime) begin
            $display("Test %D Fehler: Counter: %D Soll: %D",test,counter/2**TIMER_ADDITIONAL_BITS,randomTime);
        end
        else begin
            sucessfull_tests++;
            `ifdef CONFIRM
            $display("Test %d bestanden!", test);
            `endif
        end
    endtask

    //Reset task
    task apply_reset();
        rst <= 1;
        repeat(2) @(posedge clk) 
        rst <= 0;
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
