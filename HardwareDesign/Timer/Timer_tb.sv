`timescale 1ns/1ns
module Timer_tb;
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

    // Main testbench process
    integer test_index;

    initial begin
        rst = 1;
        apply_reset();
        testTimer(0);
        apply_reset();
        for(test_index = 0; test_index<8; test_index++) begin
            fork
                repeat(20) testTimer(test_index);
            join
        end
        $display("%d/%d Tests ran successfully!", sucessfull_tests,test);
        // End of simulation
        $finish;
    end



    //task that tests module
    task automatic testTimer(integer i);
        //Variables for Task
        integer randomTime;
        integer counter;
        test++;
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
            $display("Test %D Fehler: Counter: %D Soll: %D",test,counter/2**i,randomTime);
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
