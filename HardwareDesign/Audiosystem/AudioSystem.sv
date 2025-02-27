module AudioSystem (
    input logic clk,
    input logic rst,

    input logic lrclk,

    input logic [31:0] data,

    output logic [15:0] sample
    //TODO
);
    typedef struct packed {
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
    } ChannelData;

    typedef enum logic[3:0] { 
        RENDER_RIGHT,
        RENDER_LEFT,
        WAIT_LR_CLOCK_R,
        WAIT_LR_CLOCK_L
    } states_main_loop;

    localparam CHANNEL_COUNT = 8;
    ChannelData datas[CHANNEL_COUNT];

    logic [34:0] mixedSample;
    logic [31:0] newMixedSamples [CHANNEL_COUNT];

    logic [15:0] sampleDataIn [CHANNEL_COUNT];

    //Communication to Data Channels
    logic [CHANNEL_COUNT-1:0] w_startDataAddress;
    logic [11:0] i_startDataAddress;


    logic risingEdgeLRClk;

    genvar channel_select; 
    generate
        for(channel_select = 0; channel_select < CHANNEL_COUNT; channel_select++) begin
            states_main_loop state = WAIT_LR_CLOCK_R;

            always_ff @( posedge clk ) begin
                case (state)
                    RENDER_RIGHT, RENDER_LEFT: begin
                        //TODO Channel last sample & Channel current position
                        if(datas[channel_select].isPlaying
                        && ((state == RENDER_LEFT && datas[channel_select].isLeft)
                            ||(state == RENDER_RIGHT && !datas[channel_select].isLeft))) begin
                                //Sample TODO: Update sample
                            newMixedSamples[channel_select] <= ((sampleDataIn[channel_select] + datas[channel_select].lastSample) * (datas[channel_select].volume<<<4)>>>4);
                        end else begin
                            newMixedSamples[channel_select] <= 0;
                        end
                        if(state == RENDER_RIGHT) begin
                            state <= WAIT_LR_CLOCK_R;
                        end else begin
                            state <= WAIT_LR_CLOCK_L;
                        end
                    end
                    WAIT_LR_CLOCK_L: begin
                        //TODO Preload the next data
                        //TODO LRClock implemnetiation
                        if(risingEdgeLRClk) begin
                            state <= RENDER_RIGHT;
                        end
                    end
                    WAIT_LR_CLOCK_R: begin
                        //TODO Preload the next data
                        if(risingEdgeLRClk) begin
                            state <= RENDER_LEFT;
                        end
                    end
                endcase
            end
            //All the communication from CPU to write into ChannelData
            //TODO All things in the struct that need to be set/initialized etc.
            always_ff @( posedge clk ) begin : setStartAddress
                if(w_startDataAddress[channel_select]) begin
                    datas[channel_select].startDataAddress <= i_startDataAddress;
                end
            end

            always_ff @(posedge clk) begin : setIsPlaying
                //TODO

                if(rst) begin
                    datas[channel_select].isPlaying <= 0;
                end
            end
        end
        always_comb begin : calculateMixedSample
            for(int sample_select = 0; sample_select < CHANNEL_COUNT; sample_select++) begin
                mixedSample = mixedSample + newMixedSamples[sample_select];
            end
            if(mixedSample>(32767)) begin
                mixedSample = 32767;
            end
            if(mixedSample<(-32768))begin
                mixedSample = -32768;
            end
        end
    endgenerate

    assign sample = mixedSample[15:0];



endmodule