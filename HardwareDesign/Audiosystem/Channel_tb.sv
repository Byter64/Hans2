//yosys -m slang -p"read_verilog -sv ecp5pll.sv; read_slang AudioDataTypes.sv Channel.sv Channel_tb.sv; synth_ecp5 -json Ausgabe.json;"

module moduleName (
    input logic clk_25mhz,
    output logic audio_bclk,
    output logic audio_lrclk,
    output logic audio_din
);

/* CLOCK GENERATION */
wire clk_100mhz;
ecp5pll
#(
    .in_hz   (25000000),
    .out0_hz(100000000), .out0_tol_hz(50)
)
ecp5pll_inst
(
    .clk_i(clk_25mhz),
    .clk_o({clk_100mhz})
);

reg[9:0] clk_1024khz_counter;
reg clk_1024khz; 
always @(posedge clk_100mhz) begin
    clk_1024khz_counter <= clk_1024khz_counter + 1;
    if(clk_1024khz_counter + 1 == 49) begin
        clk_1024khz_counter <= 0;
        clk_1024khz <= ~clk_1024khz;
    end
end

reg[9:0] clk_64khz_counter;
reg clk_64khz; 
always @(posedge clk_1024khz) begin
    clk_64khz_counter <= clk_64khz_counter + 1;
    if(clk_64khz_counter + 1 == 16) begin
        clk_64khz_counter <= 0;
        clk_64khz <= ~clk_64khz;
    end
end

    logic [11:0] startDataAddress;  
    logic [23:0] sampleCount;           
    logic [23:0] loopStart;         
    logic [23:0] loopEnd;           
    logic [15:0] loopStartSample;   

    logic [23:0] currentPosition;   
    logic [15:0] lastSample;        
    logic [7:0] volume;             

    logic isLooping;                   
    logic isPlaying;                
    logic isMono;                   
    logic isLeft; 

    typedef enum logic[3:0] {
        IDLE                = 0,
        SET_STARTADDRESS    = 1,
        SET_SAMPLECOUNT     = 2,
        SET_LOOPSTART       = 3,
        SET_LOOPEND         = 4,
        SET_CURRENTPOSITION = 5,
        SET_LASTSAMPLE      = 6,
        SET_VOLUME          = 7,
        SET_ISLOOPING       = 8,
        SET_ISPLAYING       = 9,
        SET_ISMONO          = 10,
        SET_ISLEFT          = 11
    } ChannelSettings;
    ChannelSettings channelSettings;

logic[23:0] w_ChannelData = startDataAddress;

always_ff @(posedge clk_25mhz) begin
    case (channelSettings)
        SET_STARTADDRESS: begin
            w_ChannelData <= sampleCount;
            channelSettings <= SET_SAMPLECOUNT;
        end
        SET_SAMPLECOUNT: begin
            w_ChannelData <= loopStart;
            channelSettings <= SET_LOOPSTART;
        end
        SET_LOOPSTART: begin
            w_ChannelData <= loopEnd;
            channelSettings <= SET_LOOPEND;
        end
        SET_LOOPEND: begin
            w_ChannelData <= currentPosition;
            channelSettings <= SET_CURRENTPOSITION;
        end
        SET_CURRENTPOSITION: begin
            w_ChannelData <= lastSample;
            channelSettings <= SET_LASTSAMPLE;
        end
        SET_LASTSAMPLE: begin
            w_ChannelData <= volume;
            channelSettings <= SET_VOLUME;
        end
        SET_VOLUME: begin
            w_ChannelData <= isLooping;
            channelSettings <= SET_ISLOOPING;
        end
        SET_ISLOOPING: begin
            w_ChannelData <= isMono;
            channelSettings <= SET_ISMONO;
        end
        SET_ISMONO: begin
            w_ChannelData <= isLeft;
            channelSettings <= SET_ISLEFT;
        end
        SET_ISLEFT: begin
            w_ChannelData <= isPlaying;
            channelSettings <= SET_ISPLAYING;
        end
        SET_ISPLAYING: begin
            w_ChannelData <= 24'b0;
            channelSettings <= IDLE;
        end
    endcase
end

logic [31:0] o_nextSampleAddress;
logic [15:0] o_SampleOut;
logic [11:0] ram [283989];
initial $readmemb("encoded.bin", ram);
logic [11:0] i_sampleDelta;

Channel channel(
    .clk(clk),
    .rst(rst),

    .w_ChannelData(w_ChannelData),
    .w_selectChannelData(channelSettings),
    .i_sampleDelta(i_sampleDelta),
    .lrclk(lrclk),
    .o_SampleOut(o_SampleOut),
    .o_nextSampleAddress(o_nextSampleAddress)
);


always_ff @(posedge clk_25mhz) begin : blockName
    i_sampleDelta <= ram[o_nextSampleAddress];
end

assign audio_bclk = clk_1024khz; //bclk
assign audio_lrclk = clk_64khz; //lrclk
assign audio_din = o_SampleOut; //din

endmodule