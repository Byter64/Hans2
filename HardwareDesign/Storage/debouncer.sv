module debouncer #(
    parameter DEBOUNCE_BITS = 25
) (
    input logic clk,
    input logic btn_i,
    output logic btn_o
);

    logic [DEBOUNCE_BITS-1:0] counter = 0;


    always_ff @(posedge clk) begin
        counter <= counter + 1;
        if(&(~counter)) begin
            if(btn_i) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
            end
        end
    end

    always_ff @(posedge clk ) begin
        btn_o <= 0;
        if(&(~counter) && btn_i) begin
            btn_o <= 1;
        end
    end
    
endmodule