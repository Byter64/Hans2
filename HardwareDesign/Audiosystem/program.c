#include <stdint.h>
typedef uint32_t uint24_t;
typedef uint8_t bool;
typedef uint16_t uint12_t;
#define true 1
#define false 0

//INFO: Wenn Audio gesetzt wird, muss das ganze Struct einmal ausgefüllt werden
//TODO: Genaue regeln fürs ausfüllen aufschreiben

//data zeigt auf 12-Bit breite Worte. Das muss beim Datenladen umgewandelt werden

//Current Size: 172 Bit = 21,5 Byte
typedef struct ChannelData {
    uint12_t* data; //Meint 12 Bit enkodierte Punkte
    
    uint24_t sampleCount;

    uint24_t loopStart;
    uint24_t loopEnd;
    uint16_t loopStartSample;

    uint24_t currentPosition;
    uint16_t lastSample;
    
    uint8_t volume; //Festkommazahl, 4 Bit vor, 4 Bit nach (Zahlenraum: [-8,0 ; 7,9375])
    
    bool isLooping;
    bool isPlaying; //reset
    bool isMono; //If stereo, then stride data by 2
    bool isLeft; //Decides if stride offset is 0 or 1

} ChannelData;

#define CHANNEL_COUNT 8
ChannelData datas[CHANNEL_COUNT];
ChannelData* channelEnd = datas + CHANNEL_COUNT;
int16_t samples[CHANNEL_COUNT];

void main()
{
    while(true)
    {
        RenderChannels(true);
        WaitForLRClock();
        RenderChannels(false);
        WaitForLRClock();
    }
}

void RenderChannels(bool isLeft)
{
    int16_t mixedSample = 0;
    for(ChannelData* channel = datas; channel < channelEnd; channel++)
    {
        if(!channel->isMono && channel->isLeft != isLeft) continue;
        if(!channel->isPlaying) continue;
        // volume ist eine Festkommazahl!!!
        int32_t newMixedSample = mixedSample + DecodeSample(channel) * channel->volume;
        if(newMixedSample > INT16_MAX)
            mixedSample = INT16_MAX;
        else if(newMixedSample < INT16_MIN)
            mixedSample = INT16_MIN;
        else
            mixedSample = newMixedSample;

        if(channel->currentPosition >= channel->sampleCount)
        {
            channel->isPlaying = false;
        }
    }
    
    SetI2SData(mixedSample);
}

int16_t DecodeSample(ChannelData* channel)
{    
    int16_t sample = channel->lastSample;
    channel->currentPosition++;
    if(channel->isLooping && channel->currentPosition >= channel->loopEnd)
    {
        channel->currentPosition = channel->loopStart;
        channel->lastSample = channel->loopStartSample;
    }
    int16_t delta = GetDelta(channel);
    sample += delta;
    channel->lastSample = sample;
    return sample;
}

int16_t GetDelta(ChannelData* channel)
{
    char* address = channel->data;
    if(channel->isMono)
        address += channel->currentPosition;
    else if(channel->isLeft)
        address += channel->currentPosition * 2;
    else
        address += channel->currentPosition * 2 + 1;
    int16_t delta = *address;
    return Decode(delta); //This should be done by hardware (left shift + sign expansion)
}