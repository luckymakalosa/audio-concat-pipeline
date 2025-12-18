# build-quran.ps1
# Concatenates all Surah MP3s into a single long-form audio file.
# Applies EBU R128 loudness normalization for consistent volume across the entire Quran.
# Produces production-ready final output (~29 hours) using FFmpeg.

$Root       = Resolve-Path "$PSScriptRoot\.."
$SurahPath  = Join-Path $Root "surah"
$OutputPath = Join-Path $Root "output"
$QuranFile  = Join-Path $OutputPath "quran.mp3"
$ListFile   = Join-Path $OutputPath "quran-list.txt"

# Ensure output folder exists
if (-not (Test-Path $OutputPath)) {
    New-Item -ItemType Directory -Force -Path $OutputPath | Out-Null
}

# Generate list of Surahs in order
Get-ChildItem $SurahPath -Filter "*.mp3" |
    Sort-Object Name |
    ForEach-Object { "file '$($_.FullName)'" } |
    Out-File $ListFile -Encoding utf8

Write-Host "Quran list generated: $ListFile"

# Build full Quran with normalization
Write-Host "Building full Quran with loudness normalization..."

ffmpeg -y `
    -f concat -safe 0 `
    -i $ListFile `
    -af "loudnorm=I=-16:LRA=11:TP=-1.5" `
    -c:a libmp3lame -b:a 128k `
    -ar 44100 `
    -ac 2 `
    $QuranFile

Write-Host "Quran MP3 built successfully with normalized volume: $QuranFile"
