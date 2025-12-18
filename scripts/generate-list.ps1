# generate-list.ps1
# Generates deterministic FFmpeg concat list files
# based on ordered audio segments.

param (
    [string]$InputPath = ".\input",
    [string]$ListPath  = ".\lists"
)

# Ensure output directory exists
New-Item -ItemType Directory -Force -Path $ListPath | Out-Null

Get-ChildItem $InputPath -Filter "*.mp3" |
    Sort-Object Name |
    Group-Object { $_.Name.Substring(0,3) } |
    ForEach-Object {
        $surah = $_.Name
        $listFile = Join-Path $ListPath "$surah.txt"

        $_.Group | ForEach-Object {
            "file '$($_.FullName)'"
        } | Out-File $listFile -Encoding utf8

        Write-Host "Generated list for Surah $surah"
    }
