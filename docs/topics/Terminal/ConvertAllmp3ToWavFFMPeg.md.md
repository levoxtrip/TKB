---
comments: true
tags:
  - Terminal


---
# Convert all mp3 into wav with ffmpeg
Navigate with your terminal to the folder where you have all the mp3s. Then insert this code.

`Get-ChildItem -Filter *.mp3 | ForEach-Object { ffmpeg -i $_.FullName "$($_.BaseName).wav" }`