---
comments: true
tags:
  - Shader/Fragment
  - GLSL
  - Math
---

# Pattern

## Tiling

To create a tiling effect we first want to scale up our canvas and then return the same values for every decimal value
between 0.0 and 0.-x.0.

As we have seen before with the [fract](03_AlgorithmicDrawing.md#fract) function we always can return the same decimal value

```
fract(0.2) = 0.2
fract(3.2) = 0.2
fract(400.2) = 0.2
```
