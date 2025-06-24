#pragma once

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
	void SetupMono(int channelID, const short* data, int sampleCount, unsigned char volume = 128);
	
	/// <summary>
	/// Prepares a channel to be used to play a looped single-channel audio
	/// </summary>
	/// <param name="channelID">The ID of the channel. Must be within [0,7]</param>
	/// <param name="data">A pointer to the first sample of the audio data</param>
	/// <param name="sampleCount">The total number of samples in the audio data</param>
	/// <param name="loopStart">The index of the first sample of the loop (inclusive)</param>
	/// <param name="loopEnd">The index of the last sample of the loop (exclusive?)</param>
	/// <param name="volume">The channel's local volume. 0 is muted, 128 is the default, 255 is max</param>
	void SetupMono(int channelID, const short* data, int sampleCount, unsigned int loopStart, unsigned int loopEnd, unsigned char volume = 128);
	
	/// <summary>
	/// Prepares two channels to be used to play a non-looped stereo audio
	/// </summary>
	/// <param name="channelID_left">The ID of the channel for the left audio. Must be within [0,7]</param>
	/// <param name="channelID_right">The ID of the channel for the right audio. Must be within [0,7]</param>
	/// <param name="data">A pointer to the first sample of the audio data</param>
	/// <param name="sampleCount">The total number of samples PER CHANNEL in the audio data</param>
	/// <param name="volume">The channel's local volume. 0 is muted, 128 is the default, 255 is max</param>
	void SetupStereo(int channelID_left, int channelID_right, const short* data, int sampleCount, unsigned char volume = 128);

	/// <summary>
	/// Prepares two channels to be used to play a looped stereo audio
	/// </summary>
	/// <param name="channelID_left">The ID of the channel for the left audio. Must be within [0,7]</param>
	/// <param name="channelID_right">The ID of the channel for the right audio. Must be within [0,7]</param>
	/// <param name="data">A pointer to the first sample of the audio data</param>
	/// <param name="sampleCount">The total number of samples PER CHANNEL in the audio data</param>
	/// <param name="loopStart">The index of the first sample of the loop (inclusive)</param>
	/// <param name="loopEnd">The index of the last sample of the loop (exclusive?)</param>
	/// <param name="volume">The channel's local volume. 0 is muted, 128 is the default, 255 is max</param>
	void SetupStereo(int channelID_left, int channelID_right, const short* data, int sampleCount, unsigned int loopStart, unsigned int loopEnd, unsigned char volume = 128);
	

	void Play(unsigned char channelSelect);	
	void Pause(unsigned char channelSelect);
	void SetData(unsigned char channelSelect, short* data);
	void SetLoop(unsigned char channelSelect, bool isLooping);
	void SetLoopBoundaries(unsigned char channelSelect, int start, int end);
	void SetPosition(unsigned char channelSelect, int position);
	void SetSample(unsigned char channelSelect, short sample);
	void SetVolume(unsigned char channelSelect, unsigned char volume);
	
}
