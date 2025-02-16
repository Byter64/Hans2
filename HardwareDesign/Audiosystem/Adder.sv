module Adder (
    input[15:0] number0,
    input[15:0] number1,
    input[15:0] number2,
    input[15:0] number3,
    input[15:0] number4,
    input[15:0] number5,
    input[15:0] number6,
    input[15:0] number7,
    output sum
);

assign sum = number0 + number1 + number2 + number3 + number4 + number5 + number6 + number7;

endmodule