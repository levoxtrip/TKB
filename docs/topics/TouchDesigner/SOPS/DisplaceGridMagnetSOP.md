---
tags:
 - TD/SOP
 - TD/GRID
 - TD/DISPLACE
 - TouchDesigner

---

![Displace Grid With MagnetSOP](./img/DisplaceGridByMagnet.png)
# Displace Grid With MagnetSOP

To displace specific parts or vertices of SOP shapes, you can use a combination of the `MetaballSOP `and the `ForceSOP`. The `MetaballSOP` acts as a magnet, and by adjusting its position, you determine the area of influence on the base shape. When connected to the `ForceSOP`, the vertices in the specified area are displaced according to the Metaball's position and strength, creating a controlled deformation effect.

[Download](./files/DisplaceGridMagnet.tox)    

## Creative Tangent

An interesting effect happens when we add a `SphereSOP` with a `noiseSOP` at the beginning of the `metaballSOP`. 
It generates a more fluent and organic displace then just a static surface.

![Displace Grid With MagnetSOPCreative](./img/DisplaceGridByMagnetCreative.png)