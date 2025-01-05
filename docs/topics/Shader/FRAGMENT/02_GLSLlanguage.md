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
