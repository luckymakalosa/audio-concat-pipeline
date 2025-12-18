# build-lists.ps1
# Generates per-Surah MP3 concat lists including taʿawwudh and basmalah.
# Handles Surah 009 exception and ensures deterministic file ordering for FFmpeg.

$Root = Resolve-Path "$PSScriptRoot\.."

$InputPath = Join-Path $Root "input"
$ListPath  = Join-Path $Root "lists"

$Taawwudh = Join-Path $InputPath "000000.mp3"
$Basmalah = Join-Path $InputPath "000001.mp3"

if (-not (Test-Path $Taawwudh)) {
    Write-Error "Missing taʿawwudh file: 000000.mp3"
    exit 1
}

if (-not (Test-Path $Basmalah)) {
    Write-Error "Missing basmalah file: 000001.mp3"
    exit 1
}

New-Item -ItemType Directory -Force -Path $ListPath | Out-Null

Get-ChildItem $InputPath -Filter "*.mp3" |
    Where-Object { $_.Name -match '^\d{6}\.mp3$' } |
    Where-Object { $_.Name -notin @("000000.mp3","000001.mp3") } |
    Sort-Object Name |
    Group-Object { $_.Name.Substring(0,3) } |
    ForEach-Object {

        $surah = $_.Name
        $listFile = Join-Path $ListPath "$surah.txt"

        $lines = @()

        # Always add taʿawwudh
        $lines += "file '$Taawwudh'"

        # Add basmalah except Surah 009
        if ($surah -ne "009") {
            $lines += "file '$Basmalah'"
        }

        # Add ayahs
        $_.Group | ForEach-Object {
            $lines += "file '$($_.FullName)'"
        }

        $lines | Out-File $listFile -Encoding utf8

        Write-Host "Surah $surah built (basmalah: $($surah -ne '009'))"
    }
