# build-surah.ps1
# Merges small audio segments into grouped outputs
# using FFmpeg concat demuxer.

param (
    [string]$InputPath = ".\surah",
    [string]$OutputFile = "quran.txt"
)

Get-ChildItem $InputPath -Filter "*.mp3" |
    Sort-Object Name |
    ForEach-Object {
        "file '$($_.FullName)'"
    } | Out-File $OutputFile -Encoding utf8

Write-Host "Final Quran concat list generated"
