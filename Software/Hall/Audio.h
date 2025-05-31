#pragma once
#include <stdint.h>

volatile void* AUDIO_START 						= (void*) 0x2000100;
volatile short** AUDIO_START_ADDRESS 			= (short**)(AUDIO_START + 4);
volatile int* AUDIO_SAMPLE_COUNT 				= (int*)(AUDIO_START + 8);
volatile int* AUDIO_LOOP_START 					= (int*)(AUDIO_START + 12);
volatile int* AUDIO_LOOP_END 					= (int*)(AUDIO_START + 16);
volatile int* AUDIO_CURRENT_POSITION 			= (int*)(AUDIO_START + 20);
volatile short* AUDIO_LAST_SAMPLE 			= (short*)(AUDIO_START + 24);
volatile unsigned char* AUDIO_VOLUME 			= (unsigned char*)(AUDIO_START + 28);
volatile bool* AUDIO_IS_LOOPING 				= (bool*)(AUDIO_START + 32);
volatile bool* AUDIO_IS_PLAYING 				= (bool*)(AUDIO_START + 36);
volatile bool* AUDIO_IS_MONO 					= (bool*)(AUDIO_START + 40);
volatile bool* AUDIO_IS_RIGHT 					= (bool*)(AUDIO_START + 44);
unsigned char* AUDIO_GLOBAL_VOLUME 		= (unsigned char*)(AUDIO_START + 48); //I think we can skip volatile for these two
unsigned char* AUDIO_CHANNEL_SELECT 	= (unsigned char*)(AUDIO_START + 52); //Because they will never change and always address the same value

namespace Hall
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
	void SetupMono(int channelID, short* data, int sampleCount, unsigned char volume = 128);
	
	/// <summary>
	/// Prepares a channel to be used to play a looped single-channel audio
	/// </summary>
	/// <param name="channelID">The ID of the channel. Must be within [0,7]</param>
	/// <param name="data">A pointer to the first sample of the audio data</param>
	/// <param name="sampleCount">The total number of samples in the audio data</param>
	/// <param name="loopStart">The index of the first sample of the loop (inclusive)</param>
	/// <param name="loopEnd">The index of the last sample of the loop (exclusive?)</param>
	/// <param name="volume">The channel's local volume. 0 is muted, 128 is the default, 255 is max</param>
	void SetupMono(int channelID, short* data, int sampleCount, unsigned int loopStart, unsigned int loopEnd, unsigned char volume = 128);
	
	/// <summary>
	/// Prepares two channels to be used to play a non-looped stereo audio
	/// </summary>
	/// <param name="channelID_left">The ID of the channel for the left audio. Must be within [0,7]</param>
	/// <param name="channelID_right">The ID of the channel for the right audio. Must be within [0,7]</param>
	/// <param name="data">A pointer to the first sample of the audio data</param>
	/// <param name="sampleCount">The total number of samples in the audio data</param>
	/// <param name="volume">The channel's local volume. 0 is muted, 128 is the default, 255 is max</param>
	void SetupStereo(int channelID_left, int channelID_right, short* data, int sampleCount, unsigned char volume = 128);

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
	void SetupStereo(int channelID_left, int channelID_right, short* data, int sampleCount, unsigned int loopStart, unsigned int loopEnd, unsigned char volume = 128);
	

	void Play(unsigned char channelSelect);	
	void Pause(unsigned char channelSelect);
	void SetData(unsigned char channelSelect, short* data);
	void SetLoop(unsigned char channelSelect, bool isLooping);
	void SetLoopBoundaries(unsigned char channelSelect, int start, int end);
	void SetPosition(unsigned char channelSelect, int position);
	void SetSample(unsigned char channelSelect, short sample);
	void SetVolume(unsigned char channelSelect, unsigned char volume);
	
}