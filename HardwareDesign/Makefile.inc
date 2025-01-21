.DEFAULT_GOAL := all

.PHONY: simulation synthesis synthesis_generic visualize visualize_generic pr formal gen_bitstream flash_bitstream all clean

simulation: test_pre
	vvp test_pre

test_pre: $(MODULES_SIM)
	iverilog -g2012 -o test_pre $(MODULES_SIM)

formal:
	sby -f $(TOP).sby

synthesis: $(TOP).json
$(TOP).json: $(MODULES_SYNTH)
	yosys -p "synth_ecp5 -top $(TOP); write_json $(TOP).json" $(MODULES_SYNTH)

pr: $(TOP).config
$(TOP).config: $(TOP).json
	nextpnr-ecp5 --85k --package CABGA381 --lpf ulx3s.lpf --lpf-allow-unconstrained --json $(TOP).json --textcfg $(TOP).config

gen_bitstream: $(TOP).bit
$(TOP).bit: $(TOP).config
	ecppack $(TOP).config $(TOP).bit

flash_bitstream: $(TOP).bit
	fujprog -j flash $(TOP).bit

all: simulation synthesis pr gen_bitstream flash_bitstream

clean:
	rm -f test_pre *.vcd $(TOP).json* $(TOP).asc $(TOP).bit $(TOP).config
