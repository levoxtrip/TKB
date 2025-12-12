---
comments: true
tags:
 - TD/TOPS
 - TD/TECHNIQUE
 - TD/TEXT
 - TouchDesigner

---

![Low Pixel Noise To Blend In/Out Img](../img/LowPixelNoiseBlendIn.png)
# Low Pixel Noise To Blend In/Out
We can use a `NoiseTOP` to control the blending of different visuals on for example multiple screens. Or just to blend visuals in and out on each screen.
Combine with a `LayoutTOP` each visuals horizontally and then `MultiplyTOP` to combine the `NoiseTOP` with the `LayoutTOP`.