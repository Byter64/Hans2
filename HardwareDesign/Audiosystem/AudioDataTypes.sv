package audio_data_types;
    typedef enum logic[3:0] {
        SET_STARTADDRESS,
        SET_SAMPLECOUNT,
        SET_LOOPSTART,
        SET_LOOPEND,
        SET_CURRENTPOSITION,
        SET_LASTSAMPLE,
        SET_VOLUME,
        SET_ISLOOPING,
        SET_ISPLAYING,
        SET_ISMONO,
        SET_ISLEFT,
        IDLE
    } ChannelSettings;

    typedef struct packed {
        logic [11:0] startDataAddress;  //1
        logic [23:0] sampleCount;       //2
        
        logic [23:0] loopStart;         //3
        logic [23:0] loopEnd;           //4
        logic [15:0] loopStartSample;   //5

        logic [23:0] currentPosition;   //6
        logic [15:0] lastSample;        //7

        logic [7:0] volume;             //8

        logic isLooping;                //9
        logic isPlaying;                //10
        logic isMono;                   //11
        logic isLeft;                   //12
    } ChannelData;
endpackage;
