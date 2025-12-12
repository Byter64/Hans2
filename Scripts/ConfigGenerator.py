import argparse

def ParseArgs():
	parser = argparse.ArgumentParser(
		prog="ConfigGenerator",
		description="Generates a config file for librelane from the given source files",
	)

	parser.add_argument('-f', '--file')
	parser.add_argument('-o', '--output')

	return parser.parse_args()

def Main():
	args = ParseArgs()
	print(args.file)
	print(args.output)

if __name__ == "__main__":
	Main()