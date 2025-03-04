//yosys -m slang -p"read_verilog -sv ecp5pll.sv; read_slang AudioDataTypes.sv Channel.sv Channel_tb.sv; synth_ecp5 -json Ausgabe.json;"
import audio_data_types::*;

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

ChannelData channelData;
initial begin
channelData.startDataAddress = 0;
channelData.sampleCount = 128000;
channelData.loopStart = 0; 
channelData.loopEnd = 127999;
channelData.currentPosition = 0;
channelData.lastSample = 0;
channelData.volume = 8'b11111111;
channelData.isLooping = 1;
channelData.isPlaying = 1;
channelData.isMono = 1;
channelData.isLeft = 1;
end

ChannelSettings channelSettings = SET_STARTADDRESS;
logic[23:0] w_ChannelData = channelData.startDataAddress;

always_ff @(posedge clk_25mhz) begin
    case (channelSettings)
        SET_STARTADDRESS: begin
            w_ChannelData <= channelData.sampleCount;
            channelSettings <= SET_SAMPLECOUNT;
        end
        SET_SAMPLECOUNT: begin
            w_ChannelData <= channelData.loopStart;
            channelSettings <= SET_LOOPSTART;
        end
        SET_LOOPSTART: begin
            w_ChannelData <= channelData.loopEnd;
            channelSettings <= SET_LOOPEND;
        end
        SET_LOOPEND: begin
            w_ChannelData <= channelData.currentPosition;
            channelSettings <= SET_CURRENTPOSITION;
        end
        SET_CURRENTPOSITION: begin
            w_ChannelData <= channelData.lastSample;
            channelSettings <= SET_LASTSAMPLE;
        end
        SET_LASTSAMPLE: begin
            w_ChannelData <= channelData.volume;
            channelSettings <= SET_VOLUME;
        end
        SET_VOLUME: begin
            w_ChannelData <= channelData.isLooping;
            channelSettings <= SET_ISLOOPING;
        end
        SET_ISLOOPING: begin
            w_ChannelData <= channelData.isMono;
            channelSettings <= SET_ISMONO;
        end
        SET_ISMONO: begin
            w_ChannelData <= channelData.isLeft;
            channelSettings <= SET_ISLEFT;
        end
        SET_ISLEFT: begin
            w_ChannelData <= channelData.isPlaying;
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