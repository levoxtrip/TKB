---
comments: true
tags:
 - TD/TOPS
---

![Depth In Image Effect Img](../img/DepthInImageEffect.png)
# Depth In Image Effect
To create depth in an image we can blur the darker parts of an image which makes the lighter parts appear more to the front. For that we can use a `lumaBlurTOP` and feed it for the second source a black and white image.

Another way is to use a `depthTOP`, set pixel format to `32 bit float(RGBA)`, `Rearrange from camera space` for `Depth Space` and set camera `Far` value to smallest where you still see everything. A `levelTOP` after the `depthTOP` allows you to tweak it more.

![Depth In Image Effect Img 2](../img/DepthTOP.png)

[Download Example Here](../files/DepthInImage.tox)