# build-quran.ps1
# Builds a single long-form audio file with loudness normalization.

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
