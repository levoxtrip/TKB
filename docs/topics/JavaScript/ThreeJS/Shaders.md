---
comments: true
tags:
  - Three.js
  - Javascript
  - Shader
---
# Three.js Shader

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

We also can pass color and textures from Three.js as a uniform into the *fragment shader*.
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

# Animation Particles
Shaders are also a good tool to animate the particles in the GPU instead of animating each vertex in the CPU.

When we work with Particles in our shader we need to define `gl_PointSize` in the shader.

Instead of a `PointMaterial` we use a `ShaderMaterial` with the *fragment-* and *vertex-shader*.


## Randomize Size
If you want to create random sizes for each particle we need to create a `BufferAttribute` then reference it in the shader.

```JS

const scales = new Float32Array(parameters.count);

for(let i = 0; i<parameters.count;i++){
    ...
    scales[i] = Math.random()
}
...
geometry.setAttribute('aScale', new THREE.BufferAttribute(scales,1));
```

```glsl

attribute float aScale;

void main(){
    ...
    gl_PointSize = uSize * aScale;
}
```

To get the same particle sizes on each screen we should multiple the `gl_PointSize` with the pixel ratio.
```JS

const material = new THREE.ShaderMaterial({
    ...
    uniforms:{
        uSize: {value:8 * renderer.getPixelRatio()}
    }

})
```
Just be aware that `renderer` has to be initialized before.

## Size attenuation
To avoid that all particles have the same size and the ones that are further away are smaller than the ones closer
we have to do the *size attenuation* in the vertex shader
```glsl
void main(){
    ...
    gl_PointSize = uSize * aScale;
    gl_PointSize *= (1.0 /viewPosition.z);
}
```

## UVs in Fragment Shader
```glsl
void main(){
    gl_FragColor = vec4(gl_PointCoord,1.0,1.0);
}
```

## Bring Time into shader
```js
const material = new THREE.ShaderMaterial({
    ...
    uniforms:{
        uTime: {value:0}
    }
})
....
const clock = new THREE.Clock();
const tick = () => {
    const elapsedTime = clock.getElapsedTime();
    material.uniforms.uTime.value = elapsedTime;
}
```

## Manipulate Three.js Build-in Materials
Sometimes you want to start from a build-in Three.js Material like `MeshStandardMaterial` and just adapt a specific part of the vertex shader but don't want to rewrite the whole fragment shader. Or the other way around where you only want to displace the colors but keep the vertex shader intact. 

We can use a Three.js hook that get's triggered before the shader is compiled. To modify a material we need access to it's shaders.
```JS
material.onBeforeCompile = (shader) => {
    console.log(shader)
    console.log(shader.vertexShader)
}
//All the #include will inject code located specific in the Three.js dependency to not repeat writing to much code through the library
/*
#define STANDARD
varying vec3 vViewPosition;
#ifdef USE_TRANSMISSION
	varying vec3 vWorldPosition;
#endif
#include <common>
#include <batching_pars_vertex>
#include <uv_pars_vertex>
#include <displacementmap_pars_vertex>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <normal_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <shadowmap_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>
void main() {
	#include <uv_vertex>
	#include <color_vertex>
	#include <morphinstance_vertex>
	#include <morphcolor_vertex>
	#include <batching_vertex>
	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinbase_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>
	#include <normal_vertex>
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	vViewPosition = - mvPosition.xyz;
	#include <worldpos_vertex>
	#include <shadowmap_vertex>
	#include <fog_vertex>
#ifdef USE_TRANSMISSION
	vWorldPosition = worldPosition.xyz;
#endif
}
*/
```

What we then can do is replace the parts that we want to change with a JS `.replace()` function. But to understand what the build in shader does it is useful to check it at `/node_modules/three/src/renderers/shaders/` and you can find the `#include` in *ShaderChunk*. In the *Chunk* you can see how it basically works. We then replace it with out own definition.

```JS

material.onBeforeCompile = (shader) => {
    shader.vertexShader = shader.vertexShader.replace(
        '#include <begin_vertex>',
        ` 
            #include <begin_vertex>
            transformed.y += 3.0
        `
    )
}
```

In shader you would normally define your own functions or mathematical calculations before the `main()` function. Because we don't have direct access to that area we can use the `#include <common>` which lies outside of the `main()` function. It is also available in all shaders.

```JS
material.onBeforeCompile = (shader) => {
    shader.vertexShader = shader.vertexShader.replace(
        `#include <common>`,
        `#include <common> 

        mat2 get2dRotateMatrix(float _angle){
        return mat2(cos(_angle),-sin(_angle),sin(_angle),cos(_angle));
        }
`
    )

     shader.vertexShader = shader.vertexShader.replace(
        '#include <begin_vertex>',
        ` 
            #include <begin_vertex>
            float angle = 0.2;
            mat2 rotationMatrix = get2dRotateMatrix(angle);
            transformed.xz = rotationMatrix * transformed.xz;
            `
    )
}
```

To use also `uniforms` in the material we also add them in `common` and assign them as usual

```JS
material.onBeforeCompile = (shader) => {
    shader.uniforms.uTime = {value:0}

    ...

}
```
```glsl
#include common

uniform float uTime;
...
```
```glsl
#include <begin_vertex>

float angle = (position.y +u_time)*0.9;
mat2 rotMatrix = get2dRotateMatrix(angle);
transformed.xz = rotMatrix * transformed.xz;
```

We have the problem that we can't access the uniform in the shader in the `tick()` function because we can not just access the uniform of the material.

What we can do is create our own `customUniform` and reference that to the `shader.uniform.uTime`.

```JS
const customUniform = {
    uTime: {value:0}
}
material.onBeforeCompile = (shader) => {
    shader.uniforms.uTime = customUniform.uTime;
    ...
}

const clock = new THREE.Clock();
const tick = () => {
    const elapsedTime = clock.getElapsedTime();

    customUniforms.uTime.value = elapsedTime;
}
```

The problem is now that when we twist our materials the material that Three.js uses to render the shadows doesn't get twist.

The material that is used for the shadows of the scene is a `MeshDepthMaterial`. We can not access that material on an easy way directly but we can overwrite it with `customDepthMaterial` property on the mesh.

```JS
const depthMaterial = new THREE.MeshDepthMaterial({
    depthPacking: THREE.RGBADepthPacking
})
```
`THREE.RGBADepthPacking` allows to efficiently store the depth with r,g,b,a values.

When the model is loaded we apply our custom depth material and change `customDepthMaterial` property with our own depth material.

```JS
gltfLoader.load(
    '/models/LeePerrySmith/LeePerrySmith.glb',
    (gltf) => {
        //...
        mesh.material = material;
        mesh.customDepthMaterial = depthMaterial
    }
)
```
If you have a more complex model with multiple meshes you may need to traverse it and update all materials.
Now we apply the changes that we used for the `MeshStandardMaterial` to the `depthMaterial`

```JS

depthMaterial.onBeforeCompile = (shader) => {
    shader.uniform.uTime = customUniform.uTime;

    depthMaterial.vertexShader = depthMaterial.vertexShader.replace(
        `#include <common>`,
        `#include <common>

        uniform float uTime;
        mat2 get2dRotateMatrix(float _angle){
        return mat2(cos(_angle),-sin(_angle),sin(_angle),cos(_angle))
        }
        `
    )

    depthMaterial.vertexShader = depthMaterial.vertexShader.replace(
        `#include <begin_vertex>`,
        `#include <begin_vertex>
        float angle = (position.y +uTime)*0.9;
        mat2 rotMatrix = get2dRotateMatrix(angle);
        transformed.xz = rotMatrix * transformed.xz;
        `
    )
}
```

Besides the shadows we probably also need to rotate the *normals* of the mesh.
The *chunk* that handles the normals is `beginnormal_vertex`. We then replace that *chunk* for the `MeshStandardMaterial`.
You can find the *chunk* here `/node_modules/three/src/renderers/shaders/ShaderChunks/beginnormal_vertex.glsl.js`

One think to be aware of that all the *chunks* at the end get added into on shader code. So we can't define the same variables in multiple chunks. We have to define the variable in the chunk that get's implemented first and then can use it in the following ones.

Because `beginnormal_vertex` gets included first we define the variables there.
The normal variable name is `objectNormal`

```JS
material.onBeforeCompile = (shader) => {
    shader.vertexShader = shader.vertexShader.replace(
        `#include <beginnormal_vertex>`,
        `#include <beginnormal_vertex>

        float angle = (position.y+uTime) *0.9;
        mat2 rotMatrix = get2dRotateMAtrix(angle);
        objectNormal.xz = rotMatrix * objectNormal.xz;
    `
    )

    shader.vertexShader = shader.vertexShader.replace(
        `#include <begin_vertex>`
        `#include <begin_vertex>

        transformed.xz = rotMatrix * transformed.xz;
        `
    )
}