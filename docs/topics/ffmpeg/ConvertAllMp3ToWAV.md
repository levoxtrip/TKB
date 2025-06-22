---
comments: true
tags:
 - Video
---

# Convert All mp4 into wav in powershell terminal on windows
`Get-ChildItem *.mp3 | ForEach-Object { ffmpeg -i $_.Name ($_.BaseName + ".wav") }`