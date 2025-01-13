---
comments: true
tags:
 - Shader/Fragment
 - GLSL
---
# Basic Intro

Fragment shader is code that get's executed for every single pixel of the canvas we draw on. It determines how each pixel should be colored.
The output of a shader is a color in rgba values from 0.0 to 1.0. *So we assign to every pixel on the canvas a rgb color value between 0.0 and 1.0.*

The code must behave differently depending on the position of the currently processed pixel on the canvas . 
For that the shader receives the position/coordinate of the respective pixel as an input and returns the color for the pixel as a result/output.

Every single pixel gets processed independently from the others. There is no before or after it is always just the current pixel the needs to calculated now.

With `gl_FragColor` the shader definies the final color value of the pixel that gets returned from the shader.
`gl_FragColor` is `vec4` - a Vector that contains 4 values - `vec4(r,g,b,a)`

![VertexFragmentShader](../img/VertexFragmentShader.png)

# Coordinates of the pixel
`gl_FragCoord` is the GLSL variable that provides the coordinates of the pixel currently being processed by the shader.

`gl_FragCoord` is a vec4 with the `vec4(x,y,z,w)` value.

The coordinate system of a shader is: ![Fragment coordinate system](../img/FragCoordSystem.png)

Because the value range of a the final pixelcolor lies between 0.0 - 1.0 it makes sense to normalise the coordinates of the pixels in the screen. 

We can nomalise the these with by dividing the coordinates by the resolution.
`gl_FragCoord.xy/u_resolution`.

With that we can map the xy position of the pixel onto the value range from 0.0 - 1.0.

# Parallel Processing
The GPU of a computer enables that multiple small programms can be executed in parallel. It executes for each pixel the shader programm at the same time.

Shader programm doesn't know anything about the values of the other pixels when a pixel gets painted.

So every pixel and vertex is independent from the other.

