---
comments: true
tags:
 - TD/SOP
 - TD/TOP
 - TD/MAT
 - TouchDesigner
---
![Assigning Height, Normal and Color Information to PhongMAT](./img/Create3DShapePhongMAT1.png)
# Create 3D Shape with PhongMAT
Instead of using for example a `noiseSOP` to displace the vertex of a shape like a `gridSOP` we also can create this displacement with TOPs and a `PhongMAT` Material. We assign TOPs as *color* , *height* and *normal* Maps in the `PhongMAT`. 
To enable the a texture as a heightmap we need to turn on `Enable Height Map` and to get actual displacement of the verteces of the Shape we need to turn on `Displace Vertices` in the `PhongMAT`. A bigger `Displace Scale` creates more extreme effects. Especially for values bigger than 1. 

To create a *normal* Texture out of a TOP we can use the `normalTOP`. 

It is important that we add `attributeCreateSOP` and a `textureSOP` to out shape SOP.

By playing with the `offset` values in `textureSOP` we can create a scrolling effect.
Also changing the `scale` in the `textureSOP` can create interesting effects.

![Important to add attributeCreateSOP and textureSOP](./img/Create3DShapePhongMAT2.png)

[Download](./files/bumpmapping.tox)    