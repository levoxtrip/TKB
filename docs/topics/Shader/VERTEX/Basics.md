---
comments: true
tags:
 - Shader/Vertex
 - GLSL
---
# Vertex Shader
The vertex shader job is to position each vertex of the geometry on the 2d render space by 
converting the 3D vertex coordinates into 2d coordinates.

In the vertex shader we get the build-in variable `gl_Position`. It contains the position of the vertex on the screen and get's passed to the fragment shader later.

So the goal in the vertex shader is to assign the desired values to `gl_Position`.

```GLSL
void main(){
    gl_Position = porjectionMatrix * viewMatrix * modelMatrix * vec4(position,1.0);
    //moving now x/y value would move the projected plane on a 2D space
    gl_Position.x = 0.5;
    gl_position.y = 0.5;
}
```
Moving just x and y just moves the already projected geometry on the x and y dimension. It is like moving an already made photo on a desk. The perspective inside of the photo doesn't get changed.

`gl_Position` is a vec4 because it's coordinates are in *clip space* which needs 4 dimensions.
*Clip space*  goes in all 3 directions `x,y,z` within a `-1 to 1`  range. *Clip space* works similar to positioning objects inside a box. Everything that lies outsides of the boxes dimension get's *clipped/cut off*  
The forth value `w` is for the perspective.

```GLSL
//vertex position
attribute vec3 position;
uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat4 modelMatrix;
void main(){
    gl_Position = porjectionMatrix * viewMatrix * modelMatrix * vec4(position,1.0);
}
```
`position` - Position of the vertex
`modelMatrix` - Applies all transformations relative to the `Mesh` - `modelMatrix`contains all the transformations like *scale,rotate,translate*  
`viewMatrix` - Applies all camera transformations - If the camera is closer to the geometry some vertices should be bigger.
`projectionMatrix` - transforms coordinates into final clip space coordinates.

To apply the matrices we multiply them.

More infos [here](https://learnopengl.com/Getting-started/Coordinate-Systems)

GLSL also provides a shorter version where `modelMatrix` and `viewMatrix` are combined in `modelViewMatrix`
```GLSL
attribute vec3 position;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
void main(){
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position,1.0);
}
```

But by splitting up the code we also have more power to manipulate the code
```GLSL
attribute vec3 position;
uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;

void main(){
    vec4 modelPosition = modelMatrix * vec4(position,1.0);
    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;
    gl_Position = projectedPosition;
}
```

For example can we displace the model position by sin
```glsl
...
vec4 modelPosition = modelMatrix * vec4(position,1.0);
modelPosition.z += sin(modelPosition.x * 10.0) * 0.1;
...
```