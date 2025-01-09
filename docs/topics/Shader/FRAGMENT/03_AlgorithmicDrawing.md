---
comments: true
tags:
 - Shader/Fragment
 - GLSL
 - Math
---
# Algorithmic Drawing
To draw intresting and complex graphics in GLSL it is *It is important to understand one-dimensional mathematical functions and especially their graph on the x-axis* in order to be able to work better with them later.
==Learn and explain the behavior of mathematical functions.==
The behavior of math. functions can be used to draw shapes by changing the colors of the pixels.

# Mathematical Functions
GLSL provides mathematical functions to set or calculate values in the shader.

A basic questions to ask yourself when using these functions is: ==what shapes does the math. function create
when I insert values like the pixelposition==.

## Trigonomic Functions
To animate graphics it's a good start to use the trigonimic functions Sine `sin()` and Cosine `cos()`.

<iframe src="https://thebookofshaders.com/05/sincos.gif" allow="fullscreen" allowfullscreen="" style="height:100%;width:100%; aspect-ratio: 16 / 9; "></iframe>

If you insert the the uv.x values into the sin function you get a gradient from left to right.
<iframe width="640" height="360" frameborder="0" src="https://codepen.io/levoxtrip/pen/YPKeYKE"></iframe>
If you insert uv.y you get a gradient from top to buttom.

If you multiply the uv.x inside the `sin(uv.x*10.)` you can change the frequency of the sin function and 
you get multiple peaks of the sin-wave.

If you multiply the `sin(uv)*2.0` outside the function you modify the amplitude of the sin function.

If you add/subtract values to the `uv` inside the function `sin(uv.x+time)` you move the graph along the x-axis.

If you add/subtract values outside the `sin(uv.x)+0.5` you move the graph along the y-axis.

<iframe src="https://thebookofshaders.com/glossary/?search=sin" allow="fullscreen" allowfullscreen="" style="height:100%;width:100%; aspect-ratio: 16 / 9; "></iframe>

