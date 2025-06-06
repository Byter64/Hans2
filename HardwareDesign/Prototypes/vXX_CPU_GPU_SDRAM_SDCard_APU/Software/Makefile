CC = riscv64-unknown-elf-g++
LD = riscv64-unknown-elf-gcc
OBJCOPY = riscv64-unknown-elf-objcopy
PYTHON = python3

CXXFLAGS = -mabi=ilp32 -march=rv32im -W -Os -Bstatic,-T,riscv.ld,--strip-debug --freestanding -lstdc++ -IHalib/include -IGraphics/include
LDFLAGS = -Wl,--gc-sections -o firmware.elf -Os -Wl,-Bstatic,-T,riscv.ld --freestanding -lstdc++ -mabi=ilp32 -march=rv32im

SRC = Halib/src/Veci2.cpp Halib/src/Image.cpp Graphics/Hans/src/Hapi.cpp Graphics/src/Color.cpp main.cpp
OBJ = $(SRC:.cpp=.o)

all: firmware32.hex

%.o: %.cpp
	$(CC) $(CXXFLAGS) -c $< -o $@

firmware.elf: $(OBJ)
	$(LD) $(LDFLAGS) $(OBJ)

firmware.tmp: firmware.elf
	$(OBJCOPY) -O verilog firmware.elf firmware.tmp

firmware.hex: firmware.tmp start.tmp
	cat start.tmp firmware.tmp > firmware.hex

firmware32.hex: firmware.hex
	$(PYTHON) hex8tohex32.py firmware.hex > firmware32.hex

clean:
	rm -f $(OBJ) firmware.elf firmware.tmp firmware.hex firmware32.hex
