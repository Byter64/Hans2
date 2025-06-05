from pathlib import Path
import subprocess

source = Path(r"C:\Users\Yanni\Desktop\Hans2_MinigameCollection\Assets\sprites\SproutLands")
dest   = Path(r"C:\Users\Yanni\Desktop\Hans2_MinigameCollection\Assets\include\sprites\SproutLands")

for root, dirs, files in source.walk():
    for file in files:
        filePath = Path(root.joinpath(file))
        if(filePath.suffix == ".png"):
            destFile = list(filePath.parts)
            destFile.insert(6, "include")
            destFile = Path("").joinpath(*destFile)
            destFile = destFile.with_suffix(".h")
            destFile = destFile.with_stem(destFile.stem + "_alpha")
            destFile.parent.mkdir(parents=True, exist_ok=True)
            subprocess.run(["magick", str(filePath), "-alpha", "extract", str(destFile)])