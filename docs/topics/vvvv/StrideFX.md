---
comments: true
tags:
  - VVVV
  - Stride
  - Texture
---
# StrideFX

## Change mapping of transformed texture
If we want to change how a transformed texture gets scalled we can add `SamplerState` node to the *custom sampler* input of the `Transform(Filter)`.

![alt text](./img/SamplingTextureStrideFX.png)

## Set Texturesize from Texture Window
![alt text](image.png)

## Group Textures
To group textures out of a for each loop in StrideFX in a similar way like a `Group(Spectral)` we need to use an accumulator and blend inside the for-each.

![ForEachBlendTextures](./img/BlendTexturesForEach.png)