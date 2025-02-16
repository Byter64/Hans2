package ChannelData;

typedef struct packed {
    bit[31:0] data; //Meint gerade noch 12 Bit enkodierte Punkte
	
    bit[23:0] sampleCount;
    bit[23:0] loopStart;
    bit[23:0] loopEnd;
    bit[23:0] currentPosition;
	
    bit[7:0] volume;
	
    bit isPlaying; //reset
    bit isMono; //If stereo, then stride data by 2
    bit isLeft; //Decides if stride offset is 0 or 1

} ChannelData;
    
endpackage