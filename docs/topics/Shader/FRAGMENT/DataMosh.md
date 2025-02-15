---
comments: true
tags:
 - Shader/Fragment
 - GLSL
---
# Datamosh
Datamosh effects base on an issue between different types of frames in compressed videos. Because not all frames are actually full frames of data.

Many compression algorithms try to hold amount of data that has changed since the last frame. Thats why compressing grainy textures or textures with a lot of noise is hard to compress to small sizes.

So a video has different kind of frames for different amount of information.

Get/create set of motion vectors for movement in the entire image

optical flow operator

Displace our colour original image sampling uv position

inside glsl

Find a way to recycle the pixels on screen/ don't clear screen every frame

feedback

Add mechanism to blend between unrpocessd and processed pixels

Quantizie the sampling block of our movement vector to creat a blocky effect

Add some noise per block