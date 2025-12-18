# build-quran.ps1
# Builds a single long-form audio file with loudness normalization.

ffmpeg -f concat -safe 0 -i list.txt `
-filter:a loudnorm `
-c:a libmp3lame -b:a 128k final-output.mp3
