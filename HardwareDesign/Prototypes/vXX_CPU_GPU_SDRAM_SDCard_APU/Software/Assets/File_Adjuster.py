from pathlib import Path
import subprocess

source = Path(r"C:\Users\Yanni\Desktop\Hans2_MinigameCollection\Assets\include\sprites\SproutLands")

for root, dirs, files in source.walk():
    for file in files:
        filePath = Path(root.joinpath(file))
        if(filePath.suffix == ".h"):
            # Read in the file
            with open(filePath, 'r') as f:
                filedata = f.read()

            # Replace the target string
            filedata = filedata.replace(".h", '')

            # Write the file out again
            with open(filePath, 'w') as f:
                f.write(filedata)
            