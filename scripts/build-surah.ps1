# build-surah.ps1
# Builds individual Surah MP3s from a list of audio files, fixing DTS issues.

$Root = Resolve-Path "$PSScriptRoot\.."

$ListPath   = Join-Path $Root "lists"
$OutputPath = Join-Path $Root "surah"

if (-not (Test-Path $ListPath)) {
    Write-Error "lists folder not found: $ListPath"
    exit 1
}

# Create surah output folder if it doesn't exist
New-Item -ItemType Directory -Force -Path $OutputPath | Out-Null

Get-ChildItem $ListPath -Filter "*.txt" |
    Sort-Object Name |
    ForEach-Object {

        $surah = $_.BaseName
        $output = Join-Path $OutputPath "$surah.mp3"

        Write-Host "Building Surah $surah..."

        # Re-encode to fix DTS issues
        ffmpeg -y `
            -f concat -safe 0 `
            -i $_.FullName `
            -c:a libmp3lame -b:a 128k `
            -ar 44100 `
            -ac 2 `
            $output
    }

Write-Host "All surahs built successfully."
