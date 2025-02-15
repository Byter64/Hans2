module Channel (
    input clk,
    input rst,

);

logic[31:0] data; //Meint gerade noch 12 Bit enkodierte Punkte
	
logic[23:0] sampleCount;
logic[23:0] loopStart;
logic[23:0] loopEnd;
logic[23:0] currentPosition;
	
logic[7:0] volume;
	
logic isPlaying; //reset
logic isMono; //If stereo, then stride data by 2
logic isLeft; //Decides if stride offset is 0 or 1


logic[31:0] nextDataMono = data + currentPosition + 1;
logic[31:0] nextDataLeft = data + (currentPosition << 1) + 2;
logic[31:0] nextDataRight = data + (currentPosition << 1) + 3;

logic[31:0] nextData = isMono ? nextDataMono : 
						isLeft ? nextDataLeft : nextDataRight;

logic[23:0] positionPlus1 = currentPosition + 1;
logic[23:0] nextPosition = positionPlus1 == loopEnd ? loopStart : positionPlus1;
endmodule