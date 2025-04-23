---
comments: true
tags:
 - Shader/Fragment
 - GLSL
---
# GLSL Language

In GLSL each variable declaration or value assignment must end with a semicolon `;`


GLSL is strictly typed programming language which means you can't combine different data types.

`int myvar = 1.0*3;` is not possible because you can't combine `float` with `int` datatype.

You can combine these with type declaration
`int myvar = int(1.0)*3;`

We can apply mathematical operations like `+,-,*,/*` to the variables
```glsl
float var1 = 0.2 + 0.3;
float var2 = 0.2 * 0.3;
...
```

# Data types

Common data types in GLSL are `bool`,`int` and`float`.

GLSL also has constants `const`. The difference is that these must be initialized and they can't be changed in the code.

Vectors allow us to store multiple values in one variable.
```
float vektoren = vec2(x,y), vec3(x,y,z), vec4(r,g,b,a) 
int vektoren = ivec2(), ivec3(),ivec4()
bool vektoren = bvec2(),bvec3() ...
```

We also can define types inside a line of code
`float a = 0.432 + float(4);`

with `v.x v.y v.z` we can access the components of the vectors. We also can use the array format `v[0]`.
```
vec4 vector;
vector[0] = vector.r = vector.x = vector.s;
vector[1] = vector.g = vector.y = vector.t;
vector[2] = vector.b = vector.z = vector.p;
vector[3] = vector.a = vector.w = vector.q;
```


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



# Varying
A *varying* is a variable that gets passed from the vertex shader to the fragment shader.

In the vertex shader varyings get defined with `out` and in the fragment shader they get defined with `in` 

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
If you have functions that have the same name but they have different input parameters the get considered as different functions.
```glsl
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

# Precision
We can decide how precise a `float` value can be in GLSL. 
`highp` - can be expensive on the performance and also doesn't work on all devices
`mediump` - can use for usual usage.
`lowp` - can create bugs because of reduced precision.

# Debugging
In shader there aren't many possibilities to debug. One option is to assign the currently calculated pixel extreme color values.