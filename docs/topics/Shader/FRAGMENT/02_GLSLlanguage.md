---
comments: true
tags:
 - Shader/Fragment
 - GLSL
---
# GLSL Language

GLSL is strictly typed programming language which means you can't combine different datatypes.

`int myvar = 1.0*3;` is not possible because you can't combine `float` with `int` datatype.

You can combine these with type declaration
`int myvar = int(1.0)*3;`

# Datatypes

Common datatypes in GLSL are `bool`,`int` and`float`.

```
float Vektoren = vec2, vec3, vec4 
int Vektoren = ivec2, ivec3,ivec4
bool Vektoren = bvec2,bvec3 ...
```

with `v.x v.y v.z` we can access the components of the vectors. We also can use the arrayformat `v[0]`.
```
vec4 vector;
vector[0] = vector.r = vector.x = vector.s;
vector[1] = vector.g = vector.y = vector.t;
vector[2] = vector.b = vector.z = vector.p;
vector[3] = vector.a = vector.w = vector.q;
```

GLSL also has constants `const`. The difference is that these must be initialised and they can't be changed in the code.

# Varying
A *varying* is a variable that gets passed from the vertex shader to the frament shader.

In the vertex shader varyings get defined with `out` and in the fragment shader they get definied with `in` 

# If
```
if(condition){
    //do
} else {
    //do that
}
```

Other way to write an if condition

```
float func(... bool soften){
    float edge = (soften) ? radius * 0.05 : 0.0;
    // (soften) ? if soften
    // 0.05 - true condition
    // 0.0 - false condition
}
```

# For-Loop
```
const int count = 10
for(int i=0; i<count;i++){
    //do something
}
```

# Functions
If you have functions that have the same name but they have differnt input parameters the get considered as different functions.
```
bool inRect(vec2 pt, vec4 rect){
	bool result = false;
	//calculate
	return bool;
}

bool inRect(float x, float y, vec4 rect){
	bool result = false;
	//calculate
	return bool;
}
```

The fragment and the vertex shader have a `void main()` function that automatically gets called.

# Swizzling
*Swizzling* in GLSL is the possibility to reorder values from a vector. 

```
vec4 color = vec4(1.0,0.5,0.0,0.25);

color.argb -> vec4(0.25,1.0,0.5,0.0);
```

Swizzling also allows to write shorter versions of the variables
`fragCoord.xy <=> vec2(fragCoord.x,fragCoord.y);`

When the vectors have the same length writing the calculations between the vectors can be shortened
`vec2(v1.x/v2.x,v1.y/v2.y) <=> v1/v2`

# Preprocessor Macros
With preprocessor macros you can define values like constants for example.

They get evaluated in the first step before the compiling of the shader.

`#define float TWO_PI = 3.1415926535`

You also can define conditional definitions with
```
#ifdef

#enddef
```

## Float defintion
In shader float values and their accuracy play a big role. If the accuracy the values are less acurate but the shader is faster.

We define the accuracy of these in a preprocessor macro
```
#ifdef
precision mediump float
#enddef
```

# Uniforms
The GPU of a computer is executing a big amount of parallel tasks - called *threads*. Every thread calculates the color value for one pixel.

GLSL uses `uniform` to pass Data from the control framework like *P5.js, TouchDesigner, Three.js, etc.* into the shader and the single *threads* so the data is available and can be processed by the shader. 

`uniform` is the same for all threads and can just be read by the shader -> so the shader can't change the value of the uniform.

*Uniforms* can have all possible GLSL datatypes.

*So uniforms save values from outside the shader so they can used in the shader* 

There are some standard *uniforms*:
- `u_mouse` Coordinates of the mouse on the screen
- `u_time` passed time in seconds since the program start
- `u_resolution` size of canvas/window in pixels 

We define uniforms like `uniform datatype name`.

# Debugging
In shader there aren't many possibilities to debug. One option is to assign the currently calculated pixel extreme color values.