---
comments: true
tags:
  - Three.JS
  - Javascript
  - Shader
---
# Three.JS Shader

# Basics
A shader is a program written in GLSL that gets send to the GPU.
Shaders are used to position each vertex of a geometry and to color each pixel of the geometry.
People often use *fragment* because not each point in the render automatically matches each pixel on the screen.

The shader receives a lot of data like vertices coordinates, mesh transformations, camera information like field of view, color information, textures, lights etc. 
In the GPU this data gets processed according to the shader program written.

## Vertex Shader
In the shader flow the vertex shader happens first.
Vertex shader set the position of the vertices of a geometry. They receive information of the vertices coordinates, the camera and of mesh transformations. 
In the shader these information get processes so the 3D shape gets projected onto 2D space - so we can see it as the render and on the canvas.

We write one shader code that gets applied to every vertex of the geometry but also need the shader to behave differently for each vertex, according to the vertex's position.
We have two types of data to achieve that:
- Attributes: This data is different for each vertex
    - position of vertex
    - texture coordinates at vertex 
    - etc.
- Uniforms: This data stays the same for all vertex
    - position of whole object in space
    - lightning information
    - time of the animation

When the vertices are placed the GPU knows what the visible geometry is and can pass that information to the *fragment shader*

## Fragment Shader
The fragment shader assigns a color to each of the geometry's visible fragments. Similar to the vertex shader the fragment shader code get's applied to each fragment.
With `uniforms` we can input data into the *fragment shader*. Furthermore we can pass information from the vertex shader into the fragment shader with uniforms - this data is called `varying`.

More on fragment shader ![here](../../Shader/FRAGMENT/01_BasicIntro.md)

## Summary
- `vertex shader` set's the vertice position of the geometry
- `fragment shader` set's the color value for each visible fragment of the geometry
- `fragment shader` get's executed after the `vertex shader`
- `Attributes` are data that is different for each vertex (just vertex shader)
- `Uniforms` are data that is the same for each vertex and fragment (vertex and fragment shader)
- `Varying` allow to pass data from vertex to fragment shader.

# Material
For shaders we use `ShaderMaterial` or `RawShaderMaterial`
- `ShaderMaterial` - already has code automatically added to code
- `RawShaderMaterial` - empty shader code.

```JS
const shaderMaterial = new THREE.RawShaderMaterial({
    vertexShader:``,
    fragmentShader:``
})
```

Basic shader code is
```JS
const material = new THREE.RawShaderMaterial({
    vertexShader: `
    uniform mat4 projectionMatrix;
    uniform mat4 viewMatrix;
    uniform mat4 modelMatrix;

    attribute vec3 position;

    void main(){
        gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position,1.0);
    }
    `,
    fragmentShader: `
    precision mediump float;

    void main(){
        gl_FragColor = vec4(0.0,1.0,0.0,1.0); 
    }
    `
})
```

For a cleaner file we should put the shader code in it's own files. 
Create a file for the *vertex* and the *fragment* shader `vertex.glsl` `frag.glsl`
When using VSCode make sure you have `Shader langauges support for VSCode` and maybe `GLSL Lint` Plugin installed.

To handle glsl shader in `vite` projects we need to import ether `vite-plugin-glsl` or `vite-plugin-glslify`
`npm install vite-plugin-glsl` and import it to the *fragment* and *vertex shader* files.

```JS
import glsl from 'vite-plugin-glsl'
//...Shadercode

export default {
    plugins:
    [
        restart({restart:['../static/**',]}),
        glsl()
    ]
}



import vertexShader from './shaders/vertex.glsl'
import fragmentShader from './shaders/fragment.glsl'

const shaderMat = new THREE.RawShaderMaterial({
    vertexShader:vertexShader,
    fragmentShader:fragmentShader
})
```

Similar to the *properties* of other materials we also can set properties like `wireframe,side,transparent,flatShading` in shader materials. Different properties like map, color or opacity wouldn't work because we are handling them ourself in the shader itself.

## Vertex Shader

More to [VertexShader](../../Shader/VERTEX/Basics.md)

## Passing Three.js values into shader

### Attributes

```js
const count = geometry.attributes.position.count;
const randoms = new Float32Array(count);

for(let i = 0; i<count;i++){
    randoms[i] = Math.random();
}
geometry.setAttribute('aRanVal', new THREE.BufferAttribute(randoms,1));
```
```glsl
attribute float aRanVal;

void main(){
    //...
    modelPosition.z = aRanVal;
}
```

If we want to use *Attributes* in the fragment shader we have to first send them to the *vertex shader* then pass them with `varying` into the *fragment shader* 

```glsl
//vertex
attribute float aRanVal;
varying float vRandom;

void main(){

    vRandom = aRanVal;
}

//fragment
precision mediump float;
varying float vRandom;
void main(){
    gl_FragColor = vec4(0.5,vRandom,1.0,1.0);
}
```

One thing to have in mind is that values between the vertices are *interpolated*

### Uniforms
If we want to send values from JS into the *fragment* or *vertex* we can use *uniforms*. These allow us for example to use the same shader for multiple objects but set with different parameters.

```JS
const shaderMaterial = new THREE.RawShaderMaterial({
    vertexShader: vertexShader,
    fragmentShader: fragmentShader,
    uniforms:
    {
        uFrequency: { value: new THREE.Vector2(10,5)}
    }
})
```
```glsl
uniform vec2 uFrequency;

void main(){
    modelPosition.z +=sin(uFrequency.x*modelPosition.x)*0.1;
    modelPosition.z +=sin(uFrequency.y*modelPosition.y)*0.1;
}

uniform float uFrequency;

void main(){
    gl_FragColor = vec4(sin(uFrequency),0.0,0.0,1.0);
}
```

Uniforms allow us also to send a time value into the shader and whit that we can drive animations inside the shaders.

```JS
const material = RawShaderMaterial({
    vertexShader: vertexShader,
    fragmentShader: fragmentShader,
    uniforms: {
        uFrequency: {value: new THREE.Vector2(10,5)},
        uTime: {value:0}

}})

const tick = () => {
    const elapsedTime = clock.getElapsedTime();

    material.uniforms.uTime.value = elapsedTime;
}


//Shader
uniform float uTime;
...
void main(){
    modelPosition.z = sin(modelPosition.x * uFrequency.x + uTime)*0.1;
    modelPostionn.z = sin(modelPostion.y*uFrequency.y +uTime) *0.1;
}
```

We also can pass color and textures from Three.JS as a uniform into the *fragment shader*.
To display Texture properly on our geometry the `texture2D` function in the *fragment shader* needs `uv` coordinates to show every color at it's right position.
Three.js is creating these `uv` coordinates for us.
`console.log(geometry.attributes.uv)`
We can get the *attribute* in the *vertex shader* and then pass it over to the *fragment shader*.

```JS

const texture = textureLoader.load('path')

const material = new THREE.RawShaderMaterial({
    vertexShader: vertexShader,
    fragmentShader:fragmentShader,
    uniforms: {
        //...
        uColor: {value: new THREE.Color('green')}
        uTexture: {values: myTexture}
    }
})
//glsl
//vertex
attribute vec2 uv;
varying vec2 vUv;
void main(){
    //...
    vUv = uv;
}

//fragment
varying vec2 vUv;
uniform vec3 uColor;
uniform sampler2D uTexture;
void main(){
    vec4 textureColor = texture2D(uTexture,vUv);
    gl_FragColor = textureColor;
    gl_FragColor = vec4(uColor,1.0);
}
```