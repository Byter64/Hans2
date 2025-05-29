#include <stdint.h>

volatile void* AUDIO_START 						= (void*) 0x2000100;
volatile int** AUDIO_START_ADDRESS 				= (int*)(AUDIO_START + 4);
volatile int* AUDIO_SAMPLE_COUNT 				= (int*)(AUDIO_START + 8);
volatile int* AUDIO_LOOP_START 					= (int*)(AUDIO_START + 12);
volatile int* AUDIO_LOOP_END 					= (int*)(AUDIO_START + 16);
volatile int* AUDIO_CURRENT_POSITION 			= (int*)(AUDIO_START + 20);
volatile int16_t* AUDIO_LAST_SAMPLE 			= (int16_t*)(AUDIO_START + 24);
volatile unsigned char* AUDIO_VOLUME 			= (unsigned char*)(AUDIO_START + 28);
volatile bool* AUDIO_IS_LOOPING 				= (bool*)(AUDIO_START + 32);
volatile bool* AUDIO_IS_PLAYING 				= (bool*)(AUDIO_START + 36);
volatile bool* AUDIO_IS_MONO 					= (bool*)(AUDIO_START + 40);
volatile bool* AUDIO_IS_RIGHT 					= (bool*)(AUDIO_START + 44);
unsigned char* AUDIO_GLOBAL_VOLUME 		= (unsigned char*)(AUDIO_START + 48); //I think we can skip volatile for these two
unsigned char* AUDIO_CHANNEL_SELECT 	= (unsigned char*)(AUDIO_START + 52); //Because they will never change and always address the same value

namespace Hapi
{
	/// <summary>
	/// Sets the global volume. 0 is muted, 128 is the default, 255 is max
	/// </summary>
	/// <param name="volume">0 is muted, 128 is the default, 255 is max</param>
	void SetGlobalVolume(unsigned char volume);
	
	/// <summary>
	/// Prepares a channel to be used to play a non-looped single-channel audio
	/// </summary>
	/// <param name="channelID">The ID of the channel. Must be within [0,7]</param>
	/// <param name="data">A pointer to the first sample of the audio data</param>
	/// <param name="sampleCount">The total number of samples in the audio data</param>
	/// <param name="volume">The channel's local volume. 0 is muted, 128 is the default, 255 is max</param>
	void SetupMono(int channelID, int16_t* data, int sampleCount, unsigned char volume = 128);
	
	/// <summary>
	/// Prepares a channel to be used to play a looped single-channel audio
	/// </summary>
	/// <param name="channelID">The ID of the channel. Must be within [0,7]</param>
	/// <param name="data">A pointer to the first sample of the audio data</param>
	/// <param name="sampleCount">The total number of samples in the audio data</param>
	/// <param name="loopStart">The index of the first sample of the loop (inclusive)</param>
	/// <param name="loopEnd">The index of the last sample of the loop (exclusive?)</param>
	/// <param name="volume">The channel's local volume. 0 is muted, 128 is the default, 255 is max</param>
	void SetupMono(int channelID, int16_t* data, int sampleCount, unsigned int loopStart, unsigned int loopEnd, unsigned char volume = 128);
	
	/// <summary>
	/// Prepares two channels to be used to play a non-looped stereo audio
	/// </summary>
	/// <param name="channelID_left">The ID of the channel for the left audio. Must be within [0,7]</param>
	/// <param name="channelID_right">The ID of the channel for the right audio. Must be within [0,7]</param>
	/// <param name="data">A pointer to the first sample of the audio data</param>
	/// <param name="sampleCount">The total number of samples in the audio data</param>
	/// <param name="volume">The channel's local volume. 0 is muted, 128 is the default, 255 is max</param>
	void SetupStereo(int channelID_left, int channelID_right, int16_t* data, int sampleCount, unsigned char volume = 128);

	/// <summary>
	/// Prepares two channels to be used to play a looped stereo audio
	/// </summary>
	/// <param name="channelID_left">The ID of the channel for the left audio. Must be within [0,7]</param>
	/// <param name="channelID_right">The ID of the channel for the right audio. Must be within [0,7]</param>
	/// <param name="data">A pointer to the first sample of the audio data</param>
	/// <param name="sampleCount">The total number of samples in the audio data</param>
	/// <param name="loopStart">The index of the first sample of the loop (inclusive)</param>
	/// <param name="loopEnd">The index of the last sample of the loop (exclusive?)</param>
	/// <param name="volume">The channel's local volume. 0 is muted, 128 is the default, 255 is max</param>
	void SetupStereo(int channelID_left, int channelID_right, int16_t* data, int sampleCount, unsigned int loopStart, unsigned int loopEnd, unsigned char volume = 128);
	

	void Play(unsigned char channelSelect);	
	void Pause(unsigned char channelSelect);
	void SetData(unsigned char channelSelect, int16_t* data);
	void SetLoop(unsigned char channelSelect, bool isLooping);
	void SetLoopBoundaries(unsigned char channelSelect, int start, int end);
	void SetPosition(unsigned char channelSelect, int position);
	void SetSample(unsigned char channelSelect, int16_t sample);
	void SetVolume(unsigned char channelSelect, unsigned char volume);
	
}

void Hapi::SetGlobalVolume(unsigned char volume)
{
	*AUDIO_GLOBAL_VOLUME = volume;
}

void Hapi::SetupMono(int channelID, int16_t* data, int sampleCount, unsigned char volume = 128)
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

void Hapi::SetupMono(int channelID, int16_t* data, int sampleCount, unsigned int loopStart, unsigned int loopEnd, unsigned char volume = 128)
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

void Hapi::SetupStereo(int channelID_left, int channelID_right, int16_t* data, int sampleCount, unsigned char volume = 128)
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

void Hapi::SetupStereo(int channelID_left, int channelID_right, int16_t* data, int sampleCount, unsigned int loopStart, unsigned int loopEnd, unsigned char volume = 128)
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

void Hapi::Play(unsigned char channelSelect)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_IS_PLAYING = true;
}

void Hapi::Pause(unsigned char channelSelect)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_IS_PLAYING = false;
}

void Hapi::SetData(unsigned char channelSelect, int16_t* data)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_START_ADDRESS = data;
}

void Hapi::SetLoop(unsigned char channelSelect, bool isLooping)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_IS_LOOPING;
}

void Hapi::SetLoopBoundaries(unsigned char channelSelect, int start, int end)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_LOOP_START = start;
	*AUDIO_LOOP_END = end;
}

void Hapi::SetPosition(unsigned char channelSelect, int position)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_CURRENT_POSITION = position;
}

void Hapi::SetSample(unsigned char channelSelect, int16_t sample)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_LAST_SAMPLE = sample;
}

void Hapi::SetVolume(unsigned char channelSelect, unsigned char volume)
{
	*AUDIO_CHANNEL_SELECT = channelSelect;
	*AUDIO_VOLUME = volume;
}