import audio_data_types::*;

module moduleName (
    input logic clk_25mhz
);

ChannelData channelData;
initial begin
channelData.startDataAddress = 0;
channelData.sampleCount = 0; //TODO
channelData.loopStart = 0; //TODO
channelData.loopEnd = 0; //TODO
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

logic [31:0] lr_clk_generator;
logic lr_rising_edge_clk;
localparam lrclkParam = 234;

always_ff @(posedge clk_25mhz) begin
    lr_clk_generator <= lr_clk_generator + 1;
    lr_rising_edge_clk <= 0;
    if(lr_clk_generator > lrclkParam) begin
        lr_clk_generator <= 0;
        lr_rising_edge_clk <= 1;
    end
end
logic [31:0] o_nextSampleAddress;
logic [15:0] o_SampleOut;
logic [11:0] ram [16384];
initial $readmemh("program.txt", ram);
logic [11:0] i_sampleDelta;
assign i_sampleDelta = ram[o_nextSampleAddress];


endmodule