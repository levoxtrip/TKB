---
comments: true
tags:
 - TD/TECHNIQUE
 - TouchDesigner
---

# Output Transparent Video
To output transparent videos in TouchDesigner you need to choose a video codec that supports alpha like:
- Animation
- HAP 
- HAP Q
- HAP R

There are also output codecs for Notch and GoPro
- GoPro - Cineform
- NotchLC

Set `movie pixel format` to `RGBA`.
