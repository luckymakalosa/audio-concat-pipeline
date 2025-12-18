# Audio Concat Pipeline

![FFmpeg](https://img.shields.io/badge/FFmpeg-Audio-blue)
![PowerShell](https://img.shields.io/badge/PowerShell-Automation-5391FE)
![Platform](https://img.shields.io/badge/Platform-Windows-0078D6)
![Status](https://img.shields.io/badge/Status-Completed-success)

A production-ready **audio processing and automation pipeline** for large-scale MP3 concatenation.
This project processes **thousands of small audio segments (6,236 files)** into structured long-form outputs using **FFmpeg** and **PowerShell**.
Originally built for a structured spoken-audio corpus, the pipeline is **domain-agnostic** and applicable to audiobooks, lectures, podcasts, and archival audio.

---

## Project Goals
- Automate large-scale MP3 concatenation
- Handle thousands of input files deterministically
- Normalize loudness for long-duration playback
- Prevent ordering and boundary errors
- Use industry-standard tooling (FFmpeg)

---

## Features
- Batch processing of **6,236 MP3 files**
- Multi-stage merge:
  - Segment → Collection
  - Collection → Full-length output
- EBU R128 loudness normalization
- Exception-aware ordering logic
- PowerShell-based automation
- Windows-optimized workflow

---


## Requirements
- Windows 10 / 11
- FFmpeg (static build recommended)
- PowerShell 5+ or PowerShell Core

---

## Project Structure
```
audio-concat-pipeline/
├── scripts/
│ ├── generate-list.ps1 # Build ordered concat lists
│ ├── build-surah.ps1 # Segment → collection merge
│ └── build-quran.ps1 # Collection → full-length merge
├── ffmpeg/
│ └── commands.md # FFmpeg reference commands
└── README.md
```

---


## Usage
### Generate concat list
```powershell
.\scripts\generate-list.ps1
```
### Build grouped audio outputs
```powershell
.\scripts\build-surah.ps1
```
### Build final long-form audio (normalized)
```powershell
ffmpeg -f concat -safe 0 -i list.txt ^
-filter:a loudnorm ^
-c:a libmp3lame -b:a 128k Al-Quran.mp3
```

---

## Audio Processing Details
- Codec: MP3 (libmp3lame)
- Sample rate: 44.1 kHz
- Bitrate: 128 kbps (CBR)
- Loudness: EBU R128 normalization
- Final duration: ~29 hours

---

## Use Cases
- Large-scale spoken-word archives
- Audiobook or lecture compilation
- Long-form podcast assembly
- Media processing automation pipelines

---

## Engineering Highlights
- Deterministic file ordering at scale
- Efficient batch media processing
- Safe handling of structural exceptions
- Long-duration audio output validation

---

## Design Decisions
This project intentionally preserves original audio characteristics while improving long-form listening quality.
### Sample Rate
- 44.1 kHz was kept to match the native source audio.
- Avoids unnecessary resampling, preserving timing and pitch accuracy.
- Appropriate for spoken-word and music-focused MP3 content.
### Bitrate
- 128 kbps CBR was retained throughout the pipeline.
- Source material is already encoded at this bitrate.
- Re-encoding at higher bitrates does not improve quality and increases file size.
### Loudness Normalization
- Applied only at the final aggregation stage.
- Uses FFmpeg’s loudnorm filter (EBU R128).
- Improves listening comfort across ~29 hours of continuous playback without altering dynamics per segment.
### Processing Strategy
- Multi-stage pipeline (segment → collection → full output)
- Deterministic ordering via generated concat lists
- Minimal transcoding to reduce quality loss and processing time

---

### Performance & Scale
- Input files: 6,236 MP3 files
- Final duration: ~29 hours
- Processing speed: ~18–20× real-time (system dependent)
- Automation level: Fully scripted, repeatable runs
- Manual steps required: None after setup
This approach ensures the pipeline remains scalable and reliable even with thousands of inputs.

---
## Lessons Learned
- FFmpeg concat demuxer requires strict file ordering to avoid timestamp issues.
- Loudness normalization is best applied after full aggregation for consistent results.
- Avoiding unnecessary re-encoding preserves quality and improves processing speed.
- PowerShell is sufficient for complex media orchestration on Windows environments.
- Clear file naming conventions significantly reduce automation complexity.

## License
Personal / educational use.
