# FFmpeg Command Reference

This document contains the FFmpeg commands used in the audio concat pipeline.

## Final Long-Form Audio Build (Normalized)

```bash
ffmpeg -f concat -safe 0 -i list.txt \
-filter:a loudnorm \
-c:a libmp3lame -b:a 128k output.mp3
