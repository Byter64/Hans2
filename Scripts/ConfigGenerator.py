import argparse
import json

def ParseArgs():
	parser = argparse.ArgumentParser(
		prog="ConfigGenerator",
		description="Generates a config file for librelane from the given source files.\nWARNING: This only works when none of the verilog files have spaces in their path",
	)

	parser.add_argument("-n", "--name", help = "The name of the design")
	parser.add_argument("-f", "--frequency", help = "The target clock frequency whith which the design should be run")
	parser.add_argument("-c", "--clockPortName", help = "The name of the design’s clock port used in Static Timing Analysis.", default = "clk")
	parser.add_argument("-i", "--inputFiles")
	parser.add_argument("-o", "--output")

	return parser.parse_args()

def GeneratePaths(sourceFilePaths: list):
	result = []

	for path in sourceFilePaths:
		#Please let it be as easy as this
		nixPath = "dir::" + path
		result.append(nixPath)
	
	return result

def HertzToNanoSeconds(frequency):
	return int(1_000_000_000.0 / frequency)

def Main():
	args = ParseArgs()

	config = {}
	config["DESIGN_NAME"] = args.name
	config["VERILOG_FILES"] = GeneratePaths(args.inputFiles.split())
	config["CLOCK_PERIOD"] = HertzToNanoSeconds(int(args.frequency))
	config["CLOCK_PORT"] = args.clockPortName

	#print(sourceFilePaths)
	#print(args.output)
	print("Here is config json:")
	print(json.dumps(config, indent = 4))

if __name__ == "__main__":
	Main()