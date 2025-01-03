---
comments: true
tags:
 - Shader/Fragment
 - GLSL
---
# Basic Intro

Fragment shader is code that get's executed for every single pixel of the canvas we draw on.
The output of a shader is a color in rgba values from 0.0 to 1.0. *So we assign to every pixel on the canvas a rgb color value between 0.0 and 1.0.*

So the code must behave differently depending on the position on the canvas of the currently processed pixel. 
For that the shader receives the position/coordinate of the respective pixel as an input and returns the color for the pixel as a result/output.



