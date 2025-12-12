---
comments: true
tags:
 - TD/SOP
 - TD/TOP
 - TouchDesigner

---

![Converting 2D Image into 3D Shape](../img/2DImageInto3DShape.png)
# Convert 2D Image into 3D Shape

To transform your 2D image into a 3D shape we can use a `TraceSOP` and then extrude it with the `ExtrudeSOP` into the 3rd dimension. To be able to properly apply textures and lighting later you need to add a `Attribute CreateSOP` and set `compute normals` and `compute tangents`*ON*. 

With `depth scale` parameter in the `extrudeSOP` can we define the depth of the Shape.


[Download Example File](../files/2DImageTo3DShape.tox)    

