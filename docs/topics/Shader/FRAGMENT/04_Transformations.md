---
comments: true
tags:
  - Shader/Fragment
  - GLSL
  - Math
---

# Transformations

# Moving shapes / 2D Matrix

To move a shape on the canvas the trick is to translate the coordinate system underneath the shape.

![Transforming the Canvas](../img/TransformingCoordSystem.png)

To achieve that we add/subtract values to the `uv` variable.

<iframe height="300" style="width: 100%;" scrolling="no" title="GLSL - Moving Shape" src="https://codepen.io/levoxtrip/embed/EaxEgeO?default-tab=html%2Cresult" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/levoxtrip/pen/EaxEgeO">
  GLSL - Moving Shape</a> by levoxtrip (<a href="https://codepen.io/levoxtrip">@levoxtrip</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>

# Rotating Shapes

To rotate a shape around itself we need a `2D rotation matrix`.

It rotates the coordinate system around the point (0,0) and if we apply the rotation to the `uv` the whole canvas gets rotated.

```
mat2 rotate2D(float theta) {
    float s = sin(theta);
    float c = cos(theta);
    return mat2(c,-s,s,c);
}

//directly in the return
mat2 rotate2D(float theta){
    return mat2(cos(theta),-sin(theta),sin(theta),cos(theta))
}

[c -s]
[s  c]
```

![Matrix Multiplication](../img/MatrixMultiplication.png)

![Rotation Around 0,0](../img/RotationAround00.png)
![Rotation Around 0,0 Shape](../img/RotationAround00Shape.png)

Is the the center of the shape on (0,0) does appear to rotate around itself. But if the shape has its center somewhere else the shape is rotation relative to (0,0).

To fix that and let the shape always rotate around its own center no matter where the shape is
we have to move the shape from its center to 0.0, execute the rotation, and then move it back to its center.

![Rotating Canvas](../img/RotateCanvas.png)

<iframe height="300" style="width: 100%;" scrolling="no" title="GLSL-RotatingShapes" src="https://codepen.io/levoxtrip/embed/wBvmoMq?default-tab=html%2Cresult" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/levoxtrip/pen/wBvmoMq">
  GLSL-RotatingShapes</a> by levoxtrip (<a href="https://codepen.io/levoxtrip">@levoxtrip</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>
