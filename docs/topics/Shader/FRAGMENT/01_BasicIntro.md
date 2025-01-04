---
comments: true
tags:
 - Shader/Fragment
 - GLSL
---
# Basic Intro

Fragment shader is code that get's executed for every single pixel of the canvas we draw on.
The output of a shader is a color in rgba values from 0.0 to 1.0. *So we assign to every pixel on the canvas a rgb color value between 0.0 and 1.0.*

The code must behave differently depending on the position of the currently processed pixel on the canvas . 
For that the shader receives the position/coordinate of the respective pixel as an input and returns the color for the pixel as a result/output.

Every single pixel gets processed independently from the others. There is no before or after it is always just the current pixel the needs to calculated now.

With `gl_FragColor` the shader definies the final color value of the pixel that gets returned from the shader.
`gl_FragColor` is `vec4` - a Vector that contains 4 values - `vec4(r,g,b,a)`

![VertexFragmentShader](../img/VertexFragmentShader.png)