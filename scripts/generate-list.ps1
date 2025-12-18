# generate-list.ps1
# Generates deterministic FFmpeg concat list files
# based on ordered audio segments.

param (
    [string]$InputPath = ".",
    [string]$OutputFile = "list.txt"
)

Get-ChildItem $InputPath -Filter *.mp3 |
    Sort-Object Name |
    ForEach-Object {
        "file '$($_.FullName)'" 
    } | Out-File $OutputFile -Encoding utf8

Write-Host "Concat list generated: $OutputFile"
