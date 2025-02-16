interface I2S;
    logic bclk;
    logic lrclk;
    logic data;

    modport Transmitter (
    output bclk, lrclk, data
    );
    
    modport Receiver (
    input bclk, lrclk, data
    );
endinterface //I2S