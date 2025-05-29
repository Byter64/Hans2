#include "Audio.h"

void Hall::SetGlobalVolume(unsigned char volume)
{
	*AUDIO_GLOBAL_VOLUME = volume;
}

void Hall::SetupMono(int channelID, short* data, int sampleCount, unsigned char volume = 128)
{
	*AUDIO_CHANNEL_SELECT = 1 << channelID;
	*AUDIO_START_ADDRESS = data;
	*AUDIO_SAMPLE_COUNT = sampleCount;
	*AUDIO_CURRENT_POSITION = 0;
	*AUDIO_VOLUME = volume;
	*AUDIO_IS_LOOPING = false;
	*AUDIO_IS_PLAYING = false;
	*AUDIO_IS_MONO = true;
}

void Hall::SetupMono(int channelID, short* data, int sampleCount, unsigned int loopStart, unsigned int loopEnd, unsigned char volume = 128)
{
	*AUDIO_CHANNEL_SELECT = 1 << channelID;
	*AUDIO_START_ADDRESS = data;
	*AUDIO_SAMPLE_COUNT = sampleCount;
	*AUDIO_CURRENT_POSITION = 0;
	*AUDIO_VOLUME = volume;
	*AUDIO_IS_LOOPING = true;
	*AUDIO_LOOP_START = loopStart;
	*AUDIO_LOOP_END = loopEnd;
	*AUDIO_IS_PLAYING = false;
	*AUDIO_IS_MONO = true;
}

void Hall::SetupStereo(int channelID_left, int channelID_right, short* data, int sampleCount, unsigned char volume = 128)
{
	*AUDIO_CHANNEL_SELECT = (1 << channelID_left) | (1 << channelID_right);
	*AUDIO_START_ADDRESS = data;
	*AUDIO_SAMPLE_COUNT = sampleCount;
	*AUDIO_CURRENT_POSITION = 0;
	*AUDIO_VOLUME = volume;
	*AUDIO_IS_LOOPING = false;
	*AUDIO_IS_PLAYING = false;
	*AUDIO_IS_MONO = false;
	*AUDIO_IS_RIGHT = false;

	*AUDIO_CHANNEL_SELECT = 1 << channelID_right;
	*AUDIO_IS_RIGHT = true;
}

void Hall::SetupStereo(int channelID_left, int channelID_right, short* data, int sampleCount, unsigned int loopStart, unsigned int loopEnd, unsigned char volume = 128)
{
	*AUDIO_CHANNEL_SELECT = (1 << channelID_left) | (1 << channelID_right);
	*AUDIO_START_ADDRESS = data;
	*AUDIO_SAMPLE_COUNT = sampleCount;
	*AUDIO_CURRENT_POSITION = 0;
	*AUDIO_VOLUME = volume;
	*AUDIO_LOOP_START = loopStart;
	*AUDIO_LOOP_END = loopEnd;
	*AUDIO_IS_LOOPING = true;
	*AUDIO_IS_PLAYING = false;
	*AUDIO_IS_MONO = false;
	*AUDIO_IS_RIGHT = false;

	*AUDIO_CHANNEL_SELECT = 1 << channelID_right;
	*AUDIO_IS_RIGHT = true;

}

void Hall::Play(unsigned char channelSelect)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_IS_PLAYING = true;
}

void Hall::Pause(unsigned char channelSelect)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_IS_PLAYING = false;
}

void Hall::SetData(unsigned char channelSelect, short* data)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_START_ADDRESS = data;
}

void Hall::SetLoop(unsigned char channelSelect, bool isLooping)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_IS_LOOPING;
}

void Hall::SetLoopBoundaries(unsigned char channelSelect, int start, int end)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_LOOP_START = start;
	*AUDIO_LOOP_END = end;
}

void Hall::SetPosition(unsigned char channelSelect, int position)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_CURRENT_POSITION = position;
}

void Hall::SetSample(unsigned char channelSelect, short sample)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_LAST_SAMPLE = sample;
}

void Hall::SetVolume(unsigned char channelSelect, unsigned char volume)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_VOLUME = volume;
}