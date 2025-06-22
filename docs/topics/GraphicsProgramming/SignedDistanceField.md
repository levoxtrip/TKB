---
comments: true
tags:
 - Shader
---
# Signed Distance Fields

*Signed Distance Fields* are functions that describe surfaces in 2D and 3D space.
They take the coordinate space as an input and for each point in that space the signed distance fields returns the distance from that point to the nearest point of the surface. The further away the point the higher the distance to the surface.
If the point lies on the surface it's distance is 0 and if the point lies outside the shape it is positive and negative when the point lies inside.

*SDF* are a scalar field so they return a single value per point in space.


[More Information](https://bytewrangler.blogspot.com/2011/10/signed-distance-fields.html)