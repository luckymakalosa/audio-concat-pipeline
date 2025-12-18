# build-surah.ps1
# Merges small audio segments into grouped outputs
# using FFmpeg concat demuxer.

$lists = Get-ChildItem -Filter *.txt

foreach ($list in $lists) {
    $output = [System.IO.Path]::ChangeExtension($list.Name, ".mp3")

    ffmpeg -f concat -safe 0 -i $list.FullName -c copy $output
}
