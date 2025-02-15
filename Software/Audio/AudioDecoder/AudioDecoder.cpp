#include <fstream>
#include <queue>
#include <cstdint>

void AddByteToQueue(std::queue<bool>& bits, unsigned char byte)
{
	for (int i = 7; i >= 0; i--)
		bits.push((byte >> i) & 1);
}

int16_t DecodeDelta(std::queue<bool>& bits)
{
	int16_t delta = 0;
	// Because of the encoding,
	// we explicitely want the range from bit 12 to 1, instead of 11 to 0
	int16_t bit = bits.front();
	delta += bit ? -4096 : 0;
	bits.pop();
	for (int i = 11; i > 0; i--)
	{
		bit = bits.front();
		delta += bit << i;
		bits.pop();
	}
	return delta;
}

int main(int argc, char* argv[])
{
	if (argc != 3)
	{
		printf("argument count != 2. EXITING\n");
		printf("AudioDecoder \"source/file.raw\" \"destination/file.raw\"");
		return -1;
	}

	std::ifstream source = std::ifstream( argv[1], std::ios::binary);
	std::ofstream destination = std::ofstream(argv[2], std::ios::binary);

	std::queue<bool> bits;
	int16_t lastSample = 0;

	while (!source.eof())
	{
		while (bits.size() < 12)
		{
			unsigned char byte = static_cast<unsigned char>(source.get());
			AddByteToQueue(bits, byte);
		}

		int16_t delta = DecodeDelta(bits);
		int16_t sample = lastSample + delta;

		uint16_t unsignedSample = *(uint16_t*)(&sample);
		
		//Save sample in little endian
		destination.put((unsignedSample & 0xFF));
		destination.put((unsignedSample >> 8));

		lastSample = sample;
	}
	

	source.close();
	destination.close();
	return 0;
}
