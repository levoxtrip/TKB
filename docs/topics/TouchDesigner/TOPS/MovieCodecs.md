---
comments: true
tags:
 - TD/TOPS
 - TD/Rendering
---

![Change Values Locked TOP](./img/AccesCameraDepth.png)

# Movie Codecs for File Output
Here some information about the different Codecs you can choose in the `MovieFileOutTOP`:
`Animation`- Almost perfect quality at huge file size

`Photo Motion JPG`- QuickTime Format - medium quality

`H.264` - Encoded in Realtime when NVIDIA Graphicscard - better quality

`GoPro Cineform` - Like ProRes for Windows - Optimised for working with editing software like after effects

`HAP` - For realtime world - Allows to playback big videofiles because it works on the GPU; As soon as you play more than 3 movie files pick `HAP`. It doesnt't drop the framerate so much because graficscard handles `HAP` Videos in parallel. 

`HAP Q` - Better quality HAP

Generally avoid recording videos in Realtime - deactivate `Realtime` on the top of UI

