#include <iostream>
#include <fstream>
#include <list>

//Delta has 12 Bits, with bitnumbers 1-12
static int DELTA_MAX = (1 << 12) - 2; 
static int DELTA_MIN = -(1 << 12);

int16_t EncodeDelta(std::list<unsigned char>& bytes, int32_t delta, bool isEven)
{
	if (delta > DELTA_MAX)
		delta = DELTA_MAX;
	else if (delta < DELTA_MIN)
		delta = DELTA_MIN;

	uint32_t u_delta = *(uint32_t*)&delta;
	if (isEven)
	{
		bytes.push_back((u_delta >> 5) & 0xFF); //Storing bits 5 to 12
		bytes.push_back((u_delta << 3) & 0xF0); //Storing bits 1 to 4
	}
	else
	{
		unsigned char lastByte = bytes.back();
		bytes.pop_back();
		lastByte |= (u_delta >> 9) & 0x0F;
		bytes.push_back(lastByte);				 //Storing bits 9 to 12
		bytes.push_back((u_delta >> 1) & 0xFF); //Storing bits 1 to 8
	}

	int16_t realDelta = delta;
	realDelta &= 0xFFFE; //Remove low bit

	return realDelta;
}

int CountSamples(std::ifstream* file)
{
	file->clear();
	std::streampos oldPos = file->tellg();
	std::streampos fsize = 0;

	file->seekg(0);
	fsize = file->tellg();
	file->seekg(0, std::ios::end);
	fsize = file->tellg() - fsize;

	file->seekg(oldPos);

	return fsize / 2;
}

int main(int argc, char* argv[])
{
	if (argc != 3)
	{
		printf("argument count != 2. EXITING\n");
		printf("AudioDecoder \"source/file.raw\" \"destination/file.raw\"");
		return -1;
	}
	
	long error = 0;

	std::ifstream source = std::ifstream(argv[1], std::ios::binary);
	std::ofstream destination = std::ofstream(argv[2], std::ios::binary);

	std::cout << "Encoding file: " << argv[1] << std::endl;

	std::list<unsigned char> bytes;
	int16_t lastSample = 0;

	bool isEven = true;
	while (!source.eof())
	{
		unsigned char byte0 = static_cast<unsigned char>(source.get());
		unsigned char byte1 = static_cast<unsigned char>(source.get());
		uint16_t u_sample = byte0 + (byte1 << 8);
		int16_t sample = *(int16_t*)&u_sample;
		int32_t delta = sample - lastSample;

		int16_t realDelta = EncodeDelta(bytes, delta, isEven);


		while (bytes.size() > 1)
		{
			unsigned char byte = bytes.front();
			bytes.pop_front();
			destination.put((byte));
		}

		lastSample = lastSample + realDelta; //Using the actual delta here has the positive of not accumulating errors
		error += std::abs(sample - lastSample);
		isEven = !isEven;
	}

	int sampleCount = CountSamples(&source);

	std::cout << "Samples: " << sampleCount << std::endl;
	std::cout << "Accumulated error: " << error << std::endl;
	std::cout << "Average error per sample:" << error / (float)sampleCount << std::endl;

	source.close();
	destination.close();
	return 0;
}
