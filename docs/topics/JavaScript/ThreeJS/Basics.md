---
comments: true
tags:
  - Three.JS
  - Javascript
---

# Basics

Three.JS is build on top of WebGL.
You can download the examples from the Three.JS site here
[Github Examples](https://github.com/mrdoob/three.js/)

![Structure of Three.JS](./img/BasicStructureThree.JS.png)

We create out of the single elements groups.

We have the `Scene` which holds all the information about the actual experience and the objects in a hierarchal way.
The `Camera` views the scene and tells the renderer what we looking at.
The `Renderer` responsible to give the user the images we want to see.

# Hierarchal structure of scene

We have a parent-child relationship in our scene and between the meshes. Children of a parent will inherit
properties from the parent mesh.
So if we group elements the children of the group will be transformed relatively from the parents values.

# Setup

To install three js in your project `npm install three`

To import the entire t3js library to our file
`import * as THREE from 'three'`

## Add a Scene

The scene is like a container for objects, lights and particles etc.

In THREE.JS you can have one or multiple scenes. You add the meshes that you create to the Scenes you want.

```js
const scene = new THREE.Scene();
```

## Add a Mesh

A mesh is composed out of geometry(shape) and a material(surface color). We need to add both to the `Mesh` object. We then add the
mesh to the scene.

```js
const cubeGeo = new THREE.BoxGeometry(1, 1, 1);
//We pass an object into the material containing all the options for that material
const cubeMaterial = new THREE.MeshBasicMaterial({ color: "red" });

const cubeMesh = new THREE.Mesh(cubeGeo, cubeMat);

scene.add(cubeMesh);
```

## Create a group

```JS
const group = new THREE.Group();
group.add(cubeMesh)
group.add(cubeMesh);
```

By changing the transformations of the group we apply it to all the children of the group.

## Add a Camera

To see the elements in our scene we need to add a Camera

```js
const camera = new THREE.PerspectiveCamera(
  fieldOfView,
  aspectRatio,/*window.innerWidth/window.innerHeight,*/
  near /* everything closer thant this you wont see */
  further /*anything further than this you wont see*/

);
const camera = new THREE.PerspectiveCamera(
  75,
  window.innerWidth/window.innerHeight,
  0.1,
  30
)
// We need to move the camera back otherwise camera and object are both at (0,0,0)
camera.position.z = 5;

scene.add(camera);
```

We need to pass a canvas html element to our website that shows our Three.JS scene.
`canvas class="canvasClass"></canvas>`
In the JS file we then grab that element and reference it to the renderer because it takes the canvas as an object as input.
`const canvas = document.querySelector('canvas.canvasClass)`

## Add renderer

The renderer renders the scene from the camera point of view and draws it onto a canvas.
We need to specify the `canvas` property corresponding to the HTML `<canvas>` element that we add to the page.
For that we can use`document.querySelector(...)`

```JS
//Because we gonna use the canvas often for multiple operations it makes sense to assign it to a variablle
const canvas = document.querySelector('canvasClassName')
const renderer = new THREE.WebGLRenderer({
  canvas:canvas
})
//To specify how big it should be rendered
renderer.setSize(window.innerWidth,window.innerHeight)
renderer.render(scene,camera);
```

If we would just call `renderer.render(...)` it would just render the scene one time.

In order to render the scene on every frame we create a function that executes at the speed of
the browsers framerate. We then call the renderer in that function. At the end we need to call
the function one time so it goes into the loop.

```JS
function animate() => {
  renderer.render(scene,camera);
  window.requestAnimationFrame(animate)
}
animate();
```

So anytime we want to make changes to the scene we need to set it before we call the animate loop because
renderer basically takes a snapshot of the current scene and shows it for that frame.

# Change background of Scene

We can change the background of our scene with
`scene.background = new THREE.Color(0xffffff)`

## Make the Background of our Scene transparent / Fox elastic scroll

To make the background of our scene not black but transparent
we can set `alpha:true` in the renderer

```JS
const renderer = new THREE.Renderer({
  canvas:canvas,
  alpha: true
})
```

or you can use the `.setClearColor()` method to set a specific color or `.setClearAlpha(0)`
for the clear Alpha.

# Resizing Scene/Canvas depending on screen size

To make the canvas fit our viewport we use `window.innerWidth/.innerHeight`

We also need to get rid of the default margins of the browsers

```css
* {
  margin: 0;
  padding: 0;
}
```

To fix the canvas at the top

```css
.canvas {
  position: fixed;
  top: 0;
  left: 0;
  outline: none; /*blue outline when drag and dropping*/
}
```

To remove any kind of scrolling we can use

```css
html,
body {
  overflow: hidden;
}
```

To handle resizing the canvas we need to know when the window gets resized.
For that we listen to the `resize` event of the window.
`window.addEventListener("resize", () => {})`

When we do changes to the camera and the `camera.aspect` we need to call `camera.updateProjectionMatrix()`.

```JS
//(eventName, callback function)
window.addEventListener('resize', () => {
  camera.aspect = window.innerWidth/window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize(window.innerWidth/window.innerHeight);

})
```

# Handling pixel ratio

Because different devices can have different pixel ratios we should
adapt the `pixelRatio` of the renderer to the pixel ratio to the
screen of our device.
To avoid performance issues on devices with higher pixel ratios we
set the maximum pixel ratio to 2 with the `Math.min()`.

`renderer.setPixelRatio(Math.min(window.devicePixelRatio,2))`

We add this to the `window.addEventListener("resize",()=>{})`

# Fullscreen

You first need to decide what interaction will trigger the fullscreen.
You could use a HTML button or a double click for example.
To toggle between fullscreen and no fullscreen every time we
execute the action we check if window is already in fullscreen.
The fullscreen method is linked with the html-element. So we need
to define which element we want to show in fullscreen.

```JS
window.addEventListener("dblclick",()=> {
  if(!document.fullscreenElement){
    canvas.requestFullscreen()
  } else {
    document.exitFullscreen()
  }
})

```

To make sure this also works in other browser like _Safari_
we need to extend this with `document.webkitFullscreen`

```JS
window.addEventListener("dblclick",()=>{
  const fullscreenElement = document.fullscreenElement || document.webkitFullscreenElement
  if(!fullscreenElement){
    if(canvas.requestFullscreen){
      canvas.requestFullscreen()
    } else if(canvas.webkitRequestFullscreen){
      canvas.webkitRequestFullscreen();
    }
  } else {
    if(document.exitFullscreen){
      document.exitFullscreen();
    } else if(document.webkitExitFullscreen){
      document.webkitExitFullscreen();
    }
  }

})
```

# Antialiasing

## Get the device pixel ration we can use

`window.devicePixelRatio`

## Set the pixel ration

`renderer.setPixelRatio(window.devicePixelRatio)`

Because of different devices and ultra high pixel ratios we want to limit the max pixel ratio so
the code stays performant

```JS
const maxPixelRatio = Math.min(window.devicePixelRatio,2);
renderer.setPixelRatio(maxPixelRatio);
```

## Add antialisaing to renderer

```JS
const renderer = new THREE.renderer({
  canvas:canvas,
  antialias:true;
})
```

# Transforming Objects

When we set the different parameters and transformations to our meshes we set the _local_ rotation, scale, and transform.

All classes that inherit from the `Object3D` class possess `position, scale, rotate, quaternion` properties.

All these properties will internally be compiled to Matrices by Three.JS.

## To see the axes in our scene

```JS
const axesHelper = new THREE.AxesHelper(2);
scene.add(axesHelper);
```

red = x
green = y
blue = z

## Set Positions

To set the position we can set the single axes

```JS
cubeMesh.position.x = 1 //x right,left
cubeMesh.position.z = 1 // backward/forward
cueMesh.position.y = 1 // up and down
```

The unity of 1 is up to you. It can be 1 centimeter, 1 meter or even 1 kilometer. It makes sense to adapt the unit to the size of what you want to build.

We also can use a `Vector3`

```JS
cubeMesh.position = new Vector3(0.1,0.0,0.3);
```

or even copy a vector to set the position

```JS
const tempPosition = new Vector3(0.4,0.1,0.8);
cubeMesh.position.copy(tempPosition);

```

## Set Scale

To set scale of single axis
`cubeMesh.scale.y = 2`

or use `.set()` to set all three values at once
`cubeMesh.scale.set(1,2,3)`

or
`group.scale.setScalar(2)`

## Set Rotation

There are two ways of handling rotations in Three.JS. You can use the `rotation` properties, which are expressed in _Euler_ angles in radians.
To create like half a rotation you can use `Math.PI`.

```JS
const a = new THREE.Euler(0,1,1.57, 'XYZ');
//Convert Vector 3 to euler
const b = new THREE.Vector3(1,0,1);
b.applyEuler(a);
```

Rotate 90°
`cubeMesh.rotation.y = Math.PI/2`

There is also a Three.JS utility we can use to convert radians to degree
`cubeMesh.rotation.y = THREE.MathUtils.degToRad(45)`

We also can use the `.quaternion` to set the rotation of an element. It is another way to express rotation.

Three.JS by default will always apply the rotation by the order XYZ even when in the code the Y rotation comes
before the x rotation.

If you want to change the order how it applies the rotation we can use
`cubeMesh.rotation.reorder('YXZ')`. this needs to be called before we are calling the rotations

## Look at object

The `.lookAt(new THREE.Vector3(0,-1,0))` method allows us to let an object look at a certain point,object or position. The object will automatically rote its `-z` axis towards the target.

# Animations

We want to execute a function that moves the objects and renders each frame regardless of the frame rate.

For that we can use the JS function `window.requestAnimationFrame()`.
It executes the function you provide it _on the next frame_.

To get reference of the time we can initialize a clock.

`const clock = new THREE.Clock()`

With `clock.getElapsedTime()` we get the difference between when the method got called and when we first initialized the clock.

## Get delta time

```JS
const clock = new THREE.Clock();
let previousTime = 0;
const renderLoop = () => {
  const currentTime = clock.getElapsedTime();
  const delta = currentTime - previousTime;

  previousTime = currentTime;
}
```

```JS
let time = Date.now()
const renderLoop = () => {
  const currentTime = Date.now()
  const deltaTime = currentTime-time;
  time = currentTime;

  mesh.rotation.y += 0.01 *deltaTime
}
```

With that `delta` we can create experiences that are independent of the speed of your device.

```JS
const clock = new THREE.Clock();
let previousTime = 0;

const renderLoop = () => {
  let currenTime = clock.getElapsedTime();
  const delta = currentTime-previousTime;

  previousTime = currenTime;

  cubeMesh.rotation.y += THREE.MathUtils.degToRad(1) * delta * 20;
  renderer.render(scene,camera);
  window.requestAnimationFrame(renderLoop)
}
renderLoop()
```

## Rotate object in circle

```JS
const time = new THREE.Clock();
const renderLoop = () => {
  const elapsedTime = time.getElapsedTime();

  mesh.position.x = Math.cos(elapsedTime);
  mesh.position.y = Math.sin(elapsedTime);
}
renderLoop();
```

## Let object/camera follow path

```JS
const points = [
  new THREE.Vector3(1,0,2),
  new THREE.Vector3(0,0,2),
  new THREE.Vector3(1,0,3),
  new THREE.Vector3(1,2,2),

]

//To close the path add true as second parameter to function
const path = new THREE.CatmullRowCurve3(points);
const animate = () => {
  const time = Date.now()
  const t = (time/2000%6) /6;
  const position = path.getPointAt(t);
  cam.position.copy(position)
  renderer.render()
  requestAnimationFrame();
}
```

To orient the object we need the normalised tanged vector of the position.

```JS
const tangent = path.getTangentAt(t).normalize();
cam.lookAt(position.clone().add(tangent));
```

It gets interesting to use mouseScroll to move the animation.

[Scroll Interaction](#scrolling)

## Animate with a Library

To get specific animations it can make sense to use specific JS animation libraries like [GSAP](https://gsap.com/)

### GSAP

To add `GSAP` we need to at it to our project
`npm install --save gsap@latest`

`import gsap from 'gsap'`

In `GSAP` we can create a `Tween` which is an animation from A to B
with `gsap.to(...)`
Because `GSAP` has a built-in `requestAnimationFrame` you don't need to update the animation.

```JS
gsap.to(mesh.position,{duration:1,delay:1,x:2})
const renderLoop = () => {
  renderer.render(scene,camera);
  window.requestAnimationFrame(renderLoop)
}
renderLoop()
```

# Geometries

In Three.js geometries are composed out of vertices - which are point coordinates in 3D space - and
facets - which are triangles that join the vertices into surfaces.

Geometries are used to create Meshes but also for particles.

Three.js own geometries are called _primitives_.

## Create own Geometry

If you want to create Geometry that is complex or with a precise shape it makes sense to create it in a 3D software. But for not to complex geometry we can use `new THREE.BufferGeometry();`

We start with instantiating a BufferGeometry
`const buffGeo  = new THREE.BufferGeometry()`

To add vertices to the geometry we save them in a JS `Float32Array`

```JS
const positionsArray = new Float32Array([
    0, 0, 0, // First vertex
    0, 1, 0, // Second vertex
    1, 0, 0  // Third vertex
])
```

Before you can pass the Array data into the _BufferGeometry_ we need to transform it into a _BufferAttribute_.

`const positionAttribute = new THREE.BufferAttribute(positionsArray,3)`
The `3` defines how many values define one vertex attribute.

Finally we can this attribute to the _BufferGeometry_ by using `.setAttribute(nameAttribute,value)`
`geometry.setAttribute('position',positionAttribute)`
The Three.js shader will look for the `position` name to assign the values to the position of the vertices.
Then the faces will created depending of the order of the vertices in the array.

Another example:

```JS
//Create geometry
const geometry = new THREE.BufferGeometry()
// Create Array with vertices points
//Float32 Array only allows to store Floats and the length of the array is fixed
//you also can set the length of the array with new Float32Array(9)
const vertices = new Float32Array([
  -1.0, -1.0, 1.0,//First vertex
  1.0, -1.0, 1.0,//second vertex
  1.0, 1.0, 1.0,//third vertex

    1.0, 1.0, 1.0,
  -1.0, 1.0, 1.0,
  -1.0, -1.0, 1.0,
]);
// pass array into BufferAttribute to store information about the position of the vertices
geometry.setAttribute('position',new THREE.BufferAttribute(vertices,3));

```

in `.setAttribute()` we also can manipulate the `uv`position of the vertices, `normals` etc.

The THREE.JS _primitives_ also use `BufferGeometry` under the hood.

### Create random triangles

```JS
const geo = new THREE.BufferGeometry();
//create 50 triangles = 450 values
const count = 50;
//50 *3 *3 = 50 triangle with 3 vertex points which need 3 values
const ranTrianglePoints = new Float32Array(50*3*3);

for(let i = 0; i< count*3*3;i++){
  ranTrianglePoints[i] = (Math.random()-0.5) *4
}
const positionAttribute = new THREE.BufferAttribute(ranTrianglePoints,3);
geo.setAttribute('position',positionAttribute);

```

<iframe height="300" style="width: 100%;" scrolling="no" title="T3.JS - Random Triangles BuffferGeometry" src="https://codepen.io/levoxtrip/embed/ogNpWGw?default-tab=js%2Cresult" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/levoxtrip/pen/ogNpWGw">
  T3.JS - Random Triangles BuffferGeometry</a> by levoxtrip (<a href="https://codepen.io/levoxtrip">@levoxtrip</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>

## Three.js Primitives

All Three.js inherit from the `ButterGeometry` class.
You can find all the primitive geometries from Three.JS in the documentation.

### BoxGeometry

```JS
const box = new THREE.BoxGeometry({
  width,
  height,
  depth,
  widthSegments,
  heightSegments,
  depthSegments
})
```

### PlaneGeometry

```JS
const plane = new THREE.PlaneGeometry({
  width,height,widthSegments,heightSegments
})
```

### CircleGeometry

`const geometry = new THREE.CircleGeometry(radius,segments)`

### SphereGeometry

```JS
const sphereGeo = new THREE.SphereGeometry(0.5,32,32)
```

### ConeGeometry

`const geometry = new THREE.ConeGeometry(radius,height,radialSegments)`

### CylinderGeometry

```JS
const cylinderGeometry = new THREE.CylinderGeometry(0.5,0.5,1,32);
```

### RingGeometry

To create a flat ring or a portion of a flat ring
`const ring = new THREE.RingGeometry(innerRadius,outerRadius,numSegments)`

### TorusGeometry

To create a ring with thickness - like a donut
`const torus = new THREE.TorusGeometry(radius,radiusTube,radialSegments,tubularSegments,arc)`

Other geometries are
`DodecahedronGeometry` - 12 faces sphere
`OctahedronGeometry` - 8 faces sphere
`TetrahedronGeometry` - 4 faces sphere

### ShapeGeometry

To create your own shapes

```JS
const x = 0, y = 0;

const heartShape = new THREE.Shape();

heartShape.moveTo( x + 5, y + 5 );
heartShape.bezierCurveTo( x + 5, y + 5, x + 4, y, x, y );
heartShape.bezierCurveTo( x - 6, y, x - 6, y + 7,x - 6, y + 7 );
heartShape.bezierCurveTo( x - 6, y + 11, x - 3, y + 15.4, x + 5, y + 19 );
heartShape.bezierCurveTo( x + 12, y + 15.4, x + 16, y + 11, x + 16, y + 7 );
heartShape.bezierCurveTo( x + 16, y + 7, x + 16, y, x + 10, y );
heartShape.bezierCurveTo( x + 7, y, x + 5, y + 5, x + 5, y + 5 );
```

### TubeGeometry

Creates a tube that extrudes a long a 3d curve

`const geometry = new THREE.TubeGeometry( path, 20, 2, 8, false );`

### ExtrudeGeometry

Creates extrudes geometry from a path shape.

```JS
const length = 12, width = 8;

const shape = new THREE.Shape();
shape.moveTo( 0,0 );
shape.lineTo( 0, width );
shape.lineTo( length, width );
shape.lineTo( length, 0 );
shape.lineTo( 0, 0 );

const extrudeSettings = {
	steps: 2,
	depth: 16,
	bevelEnabled: true,
	bevelThickness: 1,
	bevelSize: 1,
	bevelOffset: 0,
	bevelSegments: 1
};

const geometry = new THREE.ExtrudeGeometry( shape, extrudeSettings );
```

### LatheGeometry

Creates meshes with axial symmetry like vases. The lathe rotates around the Y Axis

```JS
const points = [];
for ( let i = 0; i < 10; i ++ ) {
	points.push( new THREE.Vector2( Math.sin( i * 0.2 ) * 10 + 5, ( i - 5 ) * 2 ) );
}
const geometry = new THREE.LatheGeometry( points );
```

### TextGeometry

Because it is an add-on we need to import it
`import {TextGeometry} from 'three/addons/geometries/TextGeometry.js'`

Three.js needs the font in a json format called typeface.
We can convert a font [here](https://gero3.github.io/facetype.js/)
There are also fonts in the `/node_modules/three/examples/fonts/` which we can put in the `/static/` folder.
Another way is to directly import the json file in your script
`import typefaceFont from 'three/examples/fonts/helvetiker_regular.typeface.json`

To load a font we need the Three.js class `FontLoader`

```JS
import {TextGeometry} from 'three/addons/geometries/TextGeometry.js'
...
const loader = new FontLoader();

loader.load( 'fonts/helvetiker_regular.typeface.json',  ( font ) => {

	const geometry = new TextGeometry( 'Hello three.js!', {
		font: font,
		size: 80,
		depth: 5,
		curveSegments: 12,
		bevelEnabled: true,
		bevelThickness: 10,
		bevelSize: 8,
		bevelOffset: 0,
		bevelSegments: 5
	} );
} );
```

To create 3D fonts is quite some work for Three.js because of the amount of segments and vertices. Try to reduce the `curveSegments` and `bevelSegments` as much as you can.

#### Center the text

In Three.js geometry has a _bounding_ which gives how much space the geometry takes in the scene. It can be a _sphere_(Default) or a _ box_.

We can use these boundings to position our text.
For text it makes sense to use a box as the bounding so we have to tell three.js to calculate the box
`textGeo.computeBoundingBox()`
`console.log(textGeometry.boundingBox)`

We then look for the `.max` properties and move the geometry inside the mesh - so the mesh stays centered in the scene.

```JS
textGeo.translate(
  -textGeo.boundingBox.max.x * 0.5,
  -textGeo.boundingBox.max.y *0.5,
  -textGeo.boundingBox.max.z * 0.5
)
```

The bounding box has a bevel which we would need to subtract as well to be more precise.

```JS
textGeo.translate(
  -textGeo.boundingBox.max.x * 0.5-0.02,
  -textGeo.boundingBox.max.y *0.5-0.02,
  -textGeo.boundingBox.max.z * 0.5-0.02
)
```

Three.js has a function for this to make it easier `.center()`
`textGeo.center()`

### Add multiple Meshes with one call

`scene.add(plane,sphere,box)`

## Importing geometries

_GLTF_ is the popular standard for importing models into Three.js.
It is very flexible and allows to have different sets of data. Not just for geometry and materials but also camera, light, animations etc.
It also supports different file formats like binary, json and embed textures.

If you just need a Geometry it also can make sense just to use a _OBJ_, _FBX_

### GLTF

GLTF can have different file formats and the most important are:

- [glTF](#gltf-1)
- [glTF-Binary](#gltf-binary)
- [glTF-Draco](#gltf-draco)
- [glTF-Embedded](#gltf-embedded)

To decide which format you gonna take depends on the use case how you want to handle the assets and its data.

If you want to be able to change the data it makes sense to use the `glTF-default`. It also makes loading faster because the files get loaded separately.
If you don't modify anything and you just want one file to handle it makes sense to use `glTF-binary`.

#### glTF

The .gltf, the default format, is a json file that contains information about the scene like lights, cameras, objects transformations materials. It doesn't contain information about the geometries or the textures. These are stored in the a binary file `.bin`. This file also stores information like uvs, vertex colors and more. The textures are stored associated `.png` files.

When we want to load our model from a `.gltf` we only load that file and it links to all the other corresponding files.

#### glTF-Binary

This format contains all the information in just one file. This makes it a bit lighter and easier to load.
But also less flexible because you can't change it's data. For example you can't just change the compression of the texture because it is implemented in the binary.

#### glTF-Draco

Similar to the `gltf` default format but the _buffer data_ is compressed with a different algorithm - the `Draco alogrithm`.
It is also lighter as the default `gltf`

#### glTF-Embedded

Like the `glTF-Binary` just one file but it is _JSON_ data. The benefit of this format is that you have one file which is easily editable.

### Load in gltf files into THREE.JS

```JS
import {GLTFLoader} from 'three/examples/jsm/loaders/GLTFLoader.js'

const loader = new GLTFLoader();
loader.load('path',
  (gltf) => {
    console.log("success")
    console.log(gltf);
  },
  (progress) => {
    console.log("progress")
    console.log(progress)
  },
  (error) => {
    console.log("error")
    console.log(error)
  }
)
```

```JS
import { GLTFLoader } from "three/examples/jsm/loaders/GLTFLoader";
const hand = null;
const loader = new GLTFLoader();
loader.load("src/assets/hand.glb",(gltf)=> {
  console.log(gltf.scene);
  gltf.scene.rotation.y = ...
  gltf.scene.position.y =
  //When scaling it makes sense to scale the whole scene not just the single object
  hand = gltf.scene
  scene.add(gltf.scene);
})
```

If you _gltf_ contains of a whole scene with multiple objects or elements we can access the single children with

```JS
gltfLoader.load(
  'path',
  (gltf) => {
    //find the right index of child with console.log
    scene.add(gltf.scene.children[indexChild])
  }
)
```

When you move an object from one scene to another using:
`scene.add(gltf.scene.children[0]);`
you are simultaneously:

- Adding the first child of `gltf.scene` to `scene`
- Removing that child from `gltf.scene`

This causes the `gltf.scene.children` array to change dynamically as we move the objects.
If you loop through the array using a standard for loop or similar, you end up skipping elements because the array length and order change while iterating.

To avoid this we can ether use a `while` loop:

```JS
while(gltf.scene.children.length){
  scene.add(gltf.scene.children[0])
}
```

or instead of adding the elements from the gltf.scene we clone the children and add the clones to our Three.js scene.

```JS
const children = [...gltf.scene.children]
for(const child of children){
  scene.add(child);
}
```

This way, you are iterating over a static list and moving each child without affecting the original array during the process.

And another way is to add the whole `gltf.scene`
`scene.add(gltf.scene)`

### Load Draco gltf

To load gltf-draco files we need a special `DRACOLoader`. We also need to add the worker code into the our three.js project by copying the _Draco decoder folder_(folder is located in `/node_modules/three/examples/jsm/libs/`) into our `static` folder.

We then add the path to our _draco static folder_
`dracoLoader.setDecoderPath('/draco/')`

```JS
import { DRACOLoader } from 'three/examples/jsm/loaders/DRACOLoader.js'
const dracoLoader = new DracoLoader()
dracoLoader.setDecoderPath('/draco/')

gltfLoader.setDRACOLoader(dracoLoader)
```

To decide if you use Draco or not depends of the size of your project. If you just have a small geometry file we don't need Draco. But if you want to load bigger models and you can accept can freezes at the beginning you should consider Draco.

### Access Childs of element

```JS

      firstFrameRoom = paintingG3.getObjectByName("firstFrameRoom");
      secondFrameRoom = paintingG3.getObjectByName("SecondFrameRoom");
      thirdFrameRoom = paintingG3.getObjectByName("ThirdFrameRoom");

      if (firstFrameRoom) {
        console.log("First Frame Room Mesh:", firstFrameRoom);
        // You can manipulate the mesh here
        firstFrameRoom.material.color.set(0xff0000); // Change color to red
      }

      if (secondFrameRoom) {
        console.log("Second Frame Room Mesh:", secondFrameRoom);
        // Example of moving the mesh
        secondFrameRoom.position.set(1, 0, 0);
      }

      if (thirdFrameRoom) {
        console.log("Third Frame Room Mesh:", thirdFrameRoom);
        // Example of changing visibility
        thirdFrameRoom.visible = false;
      }

      paintingG3.traverse((child) => {
        console.log(child.name); // Log the name of each child
        if (child.isMesh) {
          console.log("Found a mesh:", child);
        }
      });

      // Accessing a specific child by name or index
      const firstChild = paintingG3.children[0];
      console.log("First child:", firstChild);
```

### Access Animations of gltf

GLTF supports animations.
The `gltf` object has an `animation` property which contains `AnimationClip`
To play an `AnimationClip` we need to create an `AnimationMixer`.
Each object that gets animated needs its own `AnimationClip`.

```JS
const mixer = null;
const loader = new GLTFLoader();
loader.load("path",(gltf)=> {
  ...
  mixer = new THREE.AnimationMixer(gltf.scene);
  //adding AnimationClips to mixer
  const animationAction = mixer.clipAction(gltf.animations[0])
  animationAction.play();
})

//mixer must update each frame
const tick = () => {
  ...
  if(mixer){
    mixer.update(deltaTime);
  }
}

```

## Particles

With particles we can do dust, rain, snow, stars etc.
Each particle is one plane build out of two triangles which is always facing the camera.

### Geometry

For the `Geometry` in Particles we use `BufferGeometry` which exists for all the standard mesh geometries like `SphereBufferGeometry` etc. `BufferGeometry` is more performant so it is better to use for Particles.
For every vertex on the `BufferGeometry` we gonna get one particle.

`const particleBaseShape = new THREE.SphereBufferMaterial(radius,widthSubdivision,heightSubdivision)`

### Material

For the `Material` we can use the `PointsMaterial` which is optimized for particles and has also specific properties like
`size` and `sizeAttenuation`for particles.
`size` control the size of all particles
`sizeAttenuation` - should particles that are farther away be smaller than closer ones.

To change the color of the particle you can use the `color` property. We need to use the `THREE.Color` class for that after we created already the material.
`pointsMaterial.color = new THREE.Color('#ff88cc')`

Similar to the other materials we also can load and assign a Texture to the particles.
`pointsMaterial.transparent = true`

If you only want to keep the alpha values of the texture you can use the `.alphaMap`
`pointsMaterial.alphaMap = partTexture`

If you want to have the whole texture assign it to `.map`

The `color` property will affect the `Texture`.

#### Different Colors for each particle

To create varying colors for each of the particles we need to add a new `BufferAttribute` `color`. Then
we can use the same for-loop to assign for example random colors and set the Attribute at the end.

```JS
//Again here 3 because we have r,g,b values
const positions = new Float32Array(count*3);
const colors = new Float32Array(count*3);

for(let i = 0; i<count;i++){
  colors[i] = Math.random();
  positions[i] = (Math.random()-0.5)*10
}
particles.setAttribute('position',new THREE.BufferAttribute(positions,3));
particles.setAttribute('color',new THREE.BufferAttribute(colors,3));

//At the end we need to active vertex colors in the material
particlesMaterial.vertexColor = true

//Deactivate particlesMaterial.color = new THREE.Color...
```

#### Improving order of displaying particles

WebGL is drawing in the same order how the particles got created and it doesn't know which particle is front of the other.This can cause some render artifacts. We can use different ways to improve this.

##### Alpha Test

With the alpha test we test if a pixel gets rendered or not depending on it's transparency.
The alpha test defines that every pixel under a threshold value is not gonna be rendered.
The default threshold is 0 so every pixel will be rendered. By changing it to like 0.001
we exclude all the pixel from being rendered that have an alpha value from 0.

`pointMaterial.alphaTest = 0.001`

##### DepthTest

When rendering Three.js test if that object that gets drawn is closer than other already drawn object.
This is called `Depth testing`.
`particlesMaterial.depthTest = false` to disable.

Turning depthtesting of can create problems with other non particle objects in the scene.

##### DepthWrite

Three.js stores the depth of what is being drawn in a depth buffer. We can tell Three.js not to write the particles in the depth buffer.
`particlesMaterial.depthWrite = false`
Deactivating the `depthWrite` often can fix your problems.

#### Blending

To create a nice effect when your praticles overlap we can use `Blending`.
`particlesMaterial.depthWrite = false`
`particlesMaterial.blending = THREE.AdditiveBlending`

The downside of this is that it can affect the performance of you scene.

You can find some particle textures [here](https://www.kenney.nl/assets/particle-pack);

Instead of creating an instance of `Mesh` we use `Points` instance.
`const particles = new THREE.Points(particleGeo,particleMat)`

### Custom Geometry

To create our own geometry we start with a `BufferGeometry`, set the positions in an `Float32Array` and then assign
the values to the `position` attribute of the `BufferGeometry`

```JS
const partGeo = new THREE.BufferGeometry();

const count = 500;
const positions = new Float32Array(count*3);

for(let i = 0; i< count;i++){
  positions[i] = (Math.random()-0.5) * 10;
}

partGeo.setAttribute('position',new THREE.BufferAttribute(positions,3));


```

### Animation

There are multiple ways to animate particles.

#### Using Points as an object

You can move, scale, rotate the `Points` class like the other geometry.

```JS
const tick = () => {
  const elapsedTime = clock.getElapsedTime()

  particles.rotation.y = elapsedTime * 0.3;
}
```

This will animate all the particles as a whole.

#### Changing Attributes of Particles

To move the individual particles/ update the vertex positions, we have to change the `position` attribute of the Particle system.

The positions in the `Float32Array` are stored in an one dimensional array
`[p0.x,p0.y,p0.z,p1.x,p1.y,p1.z,...]`. If you for example only want to change all the y positions of the vertex
you need to loop through the array in certain steps.

```JS

const tick = () => {
  // ... elapsed time
  for(let i = 0; i< count;i++){
    const i3 = i*3;
    //Move all the particles y position on Math.sin()
    particlesGeometry.attributes.position.array[i3+1] = Math.sin(elapsedTime);

  }
    //We need to notify Three.js that the vertices changes
    particlesGeometry.attributes.position.needsUpdate = true;
}>
```

To get now the individual y positions depending on the x positions on the sin wave we need to get
the x position of the particle and add it to the `elapsedTime` in the `Math.sin`

```JS
const tick = () => {
  const elapsedTime = clock.elapsedTime()
for(let i = 0;i<count;i++){
  const i3 = count*3;
  const x = particlesGeometry.attributes.position[i3];
  particlesGeometry.attributes.positions[i3+1] = Math.sin(elapsedTime+x);

}
particlesGeometry.attributes.position.needsUpdate = true;
}
```

==The problem with this technique is that is super costly on the performance because on every frame we are looping through the entire array==

It is more performant to create custom shaders.

### Optimization

# Fog

To create fog around the center
`scene.fog = new THREE.Fog(0x000000,15,25);`

You then should also set the renderer clear color to the fog color
`renderer.setClearColor('0x000000');`

# Calculate distance camera and a certain mesh

We can use the distanceTo function to calculate it.

```JS
cubeMesh.position.distanceTo(camera.position)
```

So we actually can trigger something if the camera reaches an object. If the distance is < than show something

# Delete Margin of Three.JS scene

Deletes the margin and the scrollbar

```css
body {
  margin: 0;
  overflow: hidden;
}
```

# Controls

## Controls

Three.JS has a lot of different already pre-build controls integrated which you can use for interactions.
![Three.JS Controls](https://Three.JS.org/docs/index.html?q=controls#api/en/extras/Controls)

_DeviceOrientationControls:_ Retrieves the device orientation of your device allows it and it rotates the camera accordingly.

_FlyControls:_ Enables you to move the camera like if you were on a spaceship. You can rotate on all 3 axes, go forward and backward.

_FirstPersonControls:_ Like the _FlyControls_ but just with a fixed up axis. Like a flying bird that can't do a barrel roll.

_PointerLockControls:_ Its a JS API that hides the cursor, centers it, keeps sending the movement in the `mousemove` event callback. It allows you to create FPS games. But it just handles the camera rotation. Your have to do the camera position yourself.

_OrbitControls:_ Allows you to rotate around a point with the left mouse btn and translate with the right mouse btn, and zoom in with the mouse wheel.

_TrackballControls:_ They are similar to _OrbitControls_ but without any limits for the vertical angle which allows upside down rotations.

## Orbit Controls

To import _OrbitCamera_ we need to import it into our sketch
`import {OrbitControls} from 'three/addons/controls/OrbitControls.js'`

Then set it in the code

```JS
import {OrbitControls} from 'three/addons/controls/OrbitControls.js'

const controls = new OrbitControls(camera,canvas);

//update controls in animate
function animate () {
  //required if controls.enableDamping or controls.autoRotate set to true
  controls.update();
}
```

By default the _OrbitControls_ is looking at the center of the scene.
With the `target` property we can change where it is looking.
`controls.target.y = -2`

To smooth the animation of the `OrbitControls` we can use `.enableDamping` property and set it to `true`
`controls.enableDamping = true`

## Map controls

[Map Controls](https://Three.JS.org/examples/misc_controls_map.html)

## Fly controls

[Fly Controls](https://Three.JS.org/examples/misc_controls_fly.html)
The camera follows where the mouse is without clicking thing mouse

## First Person controls

It goes under _pointerlock_ in the examples.

```JS
const controls = new PointerLockControls(camera, document.body);

controls.addEventListener('lock', function () {
  menu.style.display = 'none';
});

controls.addEventListener('unlock', function () {
  menu.style.display = 'block'
}
```

## Drag controls

Drag elements
[Trackball Controls](https://Three.JS.org/examples/?q=controls#misc_controls_drag)

## Trackball controls

[Trackball Controls](https://Three.JS.org/examples/misc_controls_trackball.html)

# Camera

By default, in Three.js the field of view is vertical meaning if you put objects at the top and bottom and then
rescale your window you still see them at the top and bottom part - they don't disappear.

## PerspectiveCamera

_FOV_: The field of view is how large your vision angle is.
The bigger that angle the more you can see from the scene/experience but also the elements in that scene get smaller and more distorted.
The smaller the angle the less you can see from the scene but the elements are gonna appear larger.
![Field of View](https://github.com/PineappleBeer/Three.JS-journey/raw/master/03-basic-scene/files/video-1.gif)

In conventional photography a lot of people use 50° or 35° field of view. Play with values between `45` and `75`

`const camera = new THREE.PerspectiveCamera()`

_Aspect Ratio_- In most cases the width of the canvas divided by the height.

_Near_ - Anything within the distance between your camera and the near property you won't be able to see. Stick with numbers like 0.1 or 0.3. Values can be imagined in meters
_Far_ - Anything after the distance between your camera and the far property you won'T be able to see. Stick numbers like 200.

### Define how far/close orbin camera can move

```JS
const controls = new OrbitControls(camera,renderer,domElement);
controls.minDistance = 5;
controls.maxDistance=15;
```

### Look at specific target with orbit camera

`controls.targer.set(0,0,0)`

## Orthographic camera

For orthographic renders without perspective. Elements will have the same size on the screen regardless of their distance from the camera.
All the lines are parallel. The values that the camera asks are the distance between the center of the camera
and the outer edges of the box.
The orthografic camera requires:
_left_:left edge
_right_:right edge
_top_:top edge
_bottom_:bottom edge
_near_:
_far_:

To not get a distortion of your elements we need to multiple the _left_ and _right_ values with the aspect `aspectRatio`

```JS
const aspectRatio = window.innerWidth/window.innerHeight

const orthoCamera = new THREE.OrthographicCamera(
  -1*aspectRatio,
  1 * aspectRatio,
  1,
  -1,
  0.1,
  200
)
camera.position.z = 5
```

## Change the aspect of the camera

`camera.aspect = 4`

## Render Multiple Camera

### ArrayCamera

To render multiple cameras performant for example for VR we can use
`ArrayCamera`

Each camera will render a specific area o the canvas.

### StereoCamera

The `StereoCamera` is used to render the scene through two camera that mimic the eyes in order to create a parallax effect. You need a VR headset or red and blue glasses to see the result.

### CubeCamera

The `CubeCamera` is used to get a render facing each direction(forward, backward, leftward, rightward, upward, and downward) to create a render of the surrounding. You can use it to create an environmentmap for reflection or a shadow map.

# Materials

Materials are used to put color on each visible pixel of the geometry.
We write the algorithms that decide which color gets displaced at which pixel in shaders.

![Material Overview](./img/Three.JSMaterialOverview.png)

We can use one material for multiple meshes.

## Mesh Basic Material

`THREE.MeshBasicMaterial` is a material that doesn't react to light.

```JS
const material = new THREE.MeshBasicMaterial({
  //We ether can assign colors by name or by hexadecimal color: 0xff0000, or even by an instance off the Color class
  color: 'red',
  transparent:true,
  opacity:0.5,
})

// We also can change the properties after creating the Material
const material = new THREE.MeshBasicMaterial({
  color:'red'
})
material.transparent =false;
material.color = new THREE.Color(0xff00ff);
```

There are multiple ways to set the color:

```JS
material.color = new THREE.Color('#ff0000')
material.color = new THREE.Color('#ff00')
material.color = new THREE.Color('red')
material.color = new THREE.Color('rgb(255,0,0)')
material.color = new THREE.Color('0xff0000')
```

## Set transparency of material

```JS
material.transparency = true;
material.opacity = 0.5;

```

## Control transparency with texture

To be able to use an alpha mat on an object we need to enable transparency of the material

```JS
material.transparency = true
material.alphaMat = alphaTexture
```

## Changing sites of material

Three.JS by default has one side materials. So with a plane if you Rotate
it 180° you wouldn't see the backside of the shape.

For that we can use `THREE.DoubleSide`
`material.side = THREE.DoubleSide`

`THREE.DoubleSide` is a Three.JS constant so we don't need to use `new`
If not necessary try to avoid _DoubleSide_ because it raises the number of triangles to render.

`THREE.BackSide` when you want to show the _Backside_ instead.

## Turn of/on if material reacts to fog

Materials react by default to fog. We can change that with
`material.fog = false`

## Wireframe Material

We set a property inside the Material `wireframe: true`

```JS
const mat = new THREE.MeshBasicMaterial({color: "red", wireframe:true})

```

## MeshLambert Material

The `MeshLambert` material is a really performant material but also has less realism and options.
It requires information from light.

## MeshPhong Material

With a MeshPong Material we get a light reflection/shininess property. The higher the value the more shiny is the material.
`material.shininess = 90`

To change the color of the reflection we can use the `.specular` property.
`material.specular = new THREE.Color("0xff0000")`

## MeshStandardMaterial

The `MeshStandardMaterial` is based on Physically based rendering(PBR) and gets used a lot in Three.js.
The material gets effected my light and allows to use properties like `roughness` and `metalness`.

```JS
const material = new THREE.MEshStandartMaterial();
material.color = new THREE.Color("blue");
material.map = colorTexture;
material.roughness = 0.3;
material.metalness = 0.6;
```

The `MeshStandardMaterial` also allows to add _ambient oclussion_ maps. These add shadows where the texture of the map is dark. So we create more contrast around the dark parts of the texture.
The `aoMap` requires a second set of uvs.

```JS
myGeo.geometry.setAttribute('uv2',new THREE.BufferAttribute(myGeo.geometry.attributes.uv.array,2))

material.aoMap = ambientOcclusionTexture
material.aoMapIntensity = 1

```

In a `MeshStandardMaterial` we also can add a _displacementMap_ to displace the vertices of the geometry. It is important that the geometry has enough vertices to work with otherwise it is gonna look weardly distorded.

`material.displacementMap = displaceTex`
`material.displaementScale = 0.05`

For the `metalness` and the `roughness` we can assign maps
`material.metallnessMap = metalNessTexture`
`material.roughnessMap = roughnessTexture`

If the result doesn't look as expected reset the `metalness` and `roughness` properties
`material.metalness = 0`
`material.roughness = 1`

We also can add the material specific normal map to add details without having a high subdivision of the geometry
`material.normalMap = normalTexture`
`material.normalScale.set(0.2,0.2)`

## MeshPhysicalMaterial

The `MeshPhysical` material has same properties like the `MeshStandard` but
has more properties like `reflectivity` and `clearcoat`

`reflectivity` allows you to have a reflective material which has a low `metalness` value.

```JS
const material = new THREE.PhysicalMaterial();
material.color = new THREE.Color(0xff33ff);
material.reflectivity = 0.3;
```

`clearcoat` is like a reflective gloss or like a wax on the car.

`material.clearcoat = 0.9`

![PhysicalMaterial Properties](https://Three.JS.org/examples/?q=clear#webgl_materials_physical_clearcoat)

## MeshNormalMaterial

This materials shows the normals of the object.
`const normalMat = new THREE.MeshNormalMaterial()`

`MeshNormalMaterial` has also the property `.flatShading` which allows us to flatten the faces of the geometry - normals won't be interpolated between the vertices.

## MeshToonMaterial

The `MeshToonMaterial` is similar to the `MeshLambertMaterial` but creates a more toon style.
`material = new THREE.MeshToonMaterial()`
It creates a coloration with two steps - one for light and one for shadow.
With a gradient texture we can get more color steps.
`material.gradientMap = gradientTexture`

When the gradient texture is small Three.JS is not automatically picking the nearest pixel on the texture but is interpolating the pixel colors. In the case of `MeshToonMaterial` we want to prevent that.
To make it work we need to set `.minFilter`, `.magFilter` and deactivate the generation of mipmaps

```JS
gradientTexture.minFilter = THREE.NearestFilter
gradientTexture.maxFilter = THREE.NearestFilter
gradientTexture.generateMipMaps = false
```

## MeshMatcapMaterial

The `MeshMatcapMaterial` can create a nice look while being very performant. It needs a texture that looks like a sphere

<iframe src="https://github.com/PineappleBeer/threejs-journey/raw/master/12-materials/files/1.jpg"></iframe>
The normal orientation relative to the camera decides which color the material is gonna pick for the vertex.

## MeshDepthMaterial

The `MeshDepthMaterial` will color the parts of a material according to the closeness of the pixel to the camera.

If can be useful if you want to create effects where you need to know how far the pixel is from the camera.

## PointsMaterial

When you work with particles it makes sense to use the `PointsMaterial`

## ShaderMaterial

To create material for your geometries from shaders you can use `ShaderMaterial` and `RawShaderMaterial`

## Environment map

With environment maps we can add images of the surrounding scene. They create more realistic reflection or refraction for your materials and lighting.
We can use environment maps as a background or on the objects as reflection and lightning.

To add the environment map to our material we use the `.envMap` property.

Three.js only supports cube environment maps. They contain 6 images each for one side of a environment.

To load a cube environment map we use `CubeTextureLoader`

```JS
const cubeTextureLoader = new THREE.CubeTextureLoader()
const environmentMapTexture = cubeTextureLoader.load([
    '/textures/environmentMaps/px.jpg',
    '/textures/environmentMaps/nx.jpg',
    '/textures/environmentMaps/py.jpg',
    '/textures/environmentMaps/ny.jpg',
    '/textures/environmentMaps/pz.jpg',
    '/textures/environmentMaps/nz.jpg'
])
material.envMap = environmentMapTexture
```

You can find environment maps on [Poly Haven](https://polyhaven.com/)
But you need to convert the HDRI into a cubemap with [HRDI to Cubemap](https://matheowis.github.io/HDRI-to-CubeMap/).
Maybe convert the `png` into `jpg`

To apply an environment map to the whole scene as a background we can assign the map to the `scene` itself
`scene.background = envMap`
`scene.environment = envMap`

To get a more realistic render it is essential to add an environment map to lighten the model itself.

### Intensity

When the objects look to dark we can increase the `environmentintensity` property
`scene.environmentIntensity = 3`

### Bluriness

To blur the background we can change `backgroundBlurriness` property.

`scene.backgroundBlurriness = 0.2`

### Brightness

To alter the _intensity_ of the background we can change `backgroundIntensity`
`scene.backgroundIntensity = 4`

### Rotation

If you want to change the rotation of your environment map you can change the `backgroundRotation` and the `environmentRotation` properties.

`scene.backgroundRotation.y = 2`
`scene.backgroundRotation.y = 3`

Be aware of changing the `x` and `z` axis because normally you want the floor stay on the bottom

### HDR

"High Dynamic Range Image"(HDRI) have a higher range of color values stored in the image - for example luminosity.

They are often `equirectangular` but don't have to be.

To load HDRI we neet to import the `RGBELoader`
`import { RGBELoader } from 'three/examples/jsm/loaders/RGBELoader.js'`

`RGBE` is the encoding for the HDRI images.
The E stands for exponent which stores the brightness.

```JS
const rgbeLoader = new RGBELoader();
rgbeloader.load('/environmentMaps/../name.hdr',(envMap) => {
  console.log(envMap)
  envtMap.mapping = THREE.EquirectangularReflectionMapping

  scene.background = envMap;
  scene.environment = envMap;
})
```

The only problem with hrds is that they are more costly for the performance. Using lower resolutions and blurring the background can help to reduce the performance impact.

To import `exr`files we need a different loader

```JS
import { EXRLoader } from 'three/addons/loaders/EXRLoader.js'

const exrLoader = new EXRLoader()

exrLoader.load("path",(envMap) => {
  envMap.mapping = THREE.EquirectangularReflectionMapping
  scene.background = environmentMap
  scene.environment = environmentMap
})
```

For `jpg` environment maps set the `colorSpace` for the environment map to `THREE.SRGBColorSpace` and
maybe increase the `environmentIntensity` of the scene.
`envMap.colorSpace = THREE.SRGBColorSpace`
`scene.environmentIntensity = 2`

Also we need to load the texture with `THREE.TextureLoader()`

### Grounded environment map

The problem with environment maps is that when we have an object in the center and we want to use the environment actually as a background texture than the object always seem to fly - the object is too far away from the floor.
For that we can use `ground projected skybox`

`import {GroundedSkybox} from 'three/addons/objects/GroundedSkybox.js'`
We then initiate a `GroundedSkybox(envMap,15,70)` in the callback of the environmentmap loader.

```JS
rgbeLoader.load('path',(envMap)=> {
  //...
  const skybox = new GroundedSkybox(envMap,15,70)
  scene.add(skybox);
})
```

This creates a sphere that is squished at the bottom so the center of the scene is closer to the bottom of the `GroundedSkybox`
We then adapt the `y-position` of the sphere to match with the scener of the scene
Setting the `skybox.material.wireframe` `true` makes the positioning easier.

### Real-time environment map

We also can render every frame of the scene, store the render in a `render target` and then apply it as a environmentmap to the scene. This allows us to have a real-time environmentmap.

So we render the scene to a `THREE.WebGLCubeRenderTarget()` and assign that `texture` to the `scene.environment`
```JS
const cubeRenderTarget = new THREE.WebGLCubeRenderTarget(
  256,//Resolution of each side
  {
    //Properties to set the render Target
    type:THREE.FloatType//32 bits to save information
    //type:THREE.HalfFloatType //16 bits to store information
  }
)
scene.environment = cubeRenderTarget.texture
```
Because of performance reasons try to set the smallest possible resolution.


We then create a `CubeCamera` to render all 6 sides of the scene.
`THREE.CubeCamera(near,far,WebGLCubeRenderTarget)`
`const cubeCam = new THREE.CubeCamera(0.1,100,cubeRenderTarget)`

Then on every frame we render the camera with
`cubeCamera.update(renderer,scene)`

```JS
//loading base environmentmap
...

const cubeRenderTarget = new THREE.WEbGLCubeRenderTarget(
  256,
  {
    type:THREE.FloatType
  }
)
scene.environment = cubeRenderTarget.texture

//Creating a light donut
const lightDonut = new THREE.Mesh(
  new THREE.TorusGeometry(8,0.5),
  new THREE.MeshBasicMaterial({color: new THREE.Color(10,4,2)})//When you have a high-range texture you can use color values beyond 1
)
scene.add(lightDonut)

const clock = new THREE.Clock();
const tick = () => {
  const elapsedTime = clock.getElapsedTime()

  lightDonut.rotation.x = elapsedTime;
  lightDonut.rotation.y = elapsedTime;
  lightDonut.rotation.z = elapsedTime;

}
```

To decide which objects get included in the rendering of the camera and which get's ignored we can create `Layers`.
So by setting layers on a camera it will only show the objects that have the same Layer. By default all camera and object layers are set to `0`. 

To add a layer `object.layers.enable()`
To remove a layer `object.layers.disable()`
To only enable one layer and disable all others `object.layers.set()`

So if you want an real-time environmentmap with moving lightning you would `set` the lighning source and ignore all other objects.
`cubeCamera.layers.set(1)`
`lightDonut.layers.set(1)`




## Normals

Normals contain information about the direction of the outside of the face on each vertex of the mesh.
You can image normals as arrows coming out of the vertex of the geometry and pointing into a direction.

<iframe src="https://github.com/PineappleBeer/threejs-journey/raw/master/12-materials/files/normals.png"></iframe>

The material will then pick colors on the texture according to the normal orientation relative to the camera.
`material.matcap = matcapTexture`

You can find a big list of matcaps [here](https://github.com/nidorx/matcaps?tab=readme-ov-file)

To create your own matcap material you can render a sphere in front of a camera into a squared image.

## Textures

### What are Textures?

Textures are images that will cover the surface of your geometry.
There are different textures that create certain effects on the appearance of the object.

<iframe src="https://github.com/PineappleBeer/threejs-journey/raw/master/11-textures/files/color.jpg"></iframe>
_Color/Albedo:_ It takes the pixel of the texture and applies it to the geometry
<iframe src="https://github.com/PineappleBeer/threejs-journey/raw/master/11-textures/files/alpha.jpg"></iframe>
_Alpha:_ A grayscale image where the white parts define that the texture will be shown and the black parts won't.
<iframe src="https://github.com/PineappleBeer/threejs-journey/raw/master/11-textures/files/height.png"></iframe>
_Height:_ A grayscale image that moves the vertices of the geometry to create a relief effect. For that your geometry needs certain subdivision to be able to create the relief.
<iframe src="https://github.com/PineappleBeer/threejs-journey/raw/master/11-textures/files/normal.jpg"></iframe>
_Normal:_ Adds details but doesn't actually changes the geometry. It basically fakes to the light source that some faces of the geometry are oriented in a certain direction. Good way to add details without subdividing your geometry.
<iframe src="https://github.com/PineappleBeer/threejs-journey/raw/master/11-textures/files/ambientOcclusion.jpg"></iframe>
_Ambient Occlusion:_ Grayscale image that fakes shadow on the surface of the geometry.
<iframe src="https://github.com/PineappleBeer/threejs-journey/raw/master/11-textures/files/metalness.jpg"></iframe>
_Metalness:_ Grayscale image that specifies which parts of the geometry are metallic(white) and which parts are not(black)
<iframe src="https://github.com/PineappleBeer/threejs-journey/raw/master/11-textures/files/roughness.jpg"></iframe>
_Roughness:_ Grayscale image that defines which parts of the surface are rough(white) or smooth(black)

These textures we use to apply _Physically Based Rendering(PBR)_ to our scene to create realistic renders.

We can get good free materials at
[FreePBR.com](https://www.freepbr.com)

To load the textures into THREE.JS we need to first initialize a loader that loads the textures.

More information about [PBR here](https://marmoset.co/posts/basic-theory-of-physically-based-rendering/) [and here](https://marmoset.co/posts/physically-based-rendering-and-you-can-too/)

### Loading Textures

There are different ways to load textures.

#### Loading with native JS

With JS we need to create an `Image` instance, listen to the `load` event and the assign it to the `src` of the Image.

```JS
const Image = new Image()
const texture = new THREE.Texture(image)
Image.addEventListener('load',()=> {
  texture.needsUpdate = true
})
image.src = 'textures/.../filename.png'
// we then assign the texture to the map property of the material
const material = new THREE.MeshBasicMaterial({texture})

```

#### Using Texture Loader

```JS
//Only create this once - even if you use the loader more often - its a utility class
const texLoader = new THREE.TextureLoader();

// initialize the texture
const texture = textureLoader.load('path/to/file')

// assign texture to map property of a material
const material = new THREE.MeshStandardMaterial();
material.map = texture;
material.roughnessMap = textureRoughness;
material.roughnessMap = 0.1 // won't effect parts of the texture that aren't rough we only apply this value to the parts that are specifies as roughness
material.metalnessMap = textureMetall;
material.normalMap = normal; // normalmap holds information about how to fake the way light bounces of of this material.
material.displacementMap = heightMap; //The heightmap actually displaces the vertices of the Mesh
material.displacementScale = 0.1;
/*ambient occlusion is technique to add more depth and realism to the scene. it simulates how light is occluded or blocked where elements are close together or one elements throws shadows on another.
the ao map requires a second set of uvs. We can pass them from the actual geometry*/

const uv2 = new THREE.BufferAttribute(geometry.attribute.uv.array,2)//2 is for the item size x and y
geometry.setAttribute('uv2',uv2);
)
material.aoMap = grassAo;
material.aoMapIntensity = 1
```

We also can call this directly in the material initiation

```JS
const loader = new THREE.TextureLoader();
const material = new THREE.MeshStandardMaterial({
  map = loader.load("path")
})
```

If the loading of your functions not worked as you expected, in the `.load` function we can call three functions to control if the loading of the function worked properly.

```JS
textureLoader.load("path",
  () => {
    console.log('loading finished')
  },
  () => {
    console.log('loading progressing')
  },
  () => {
    console.log('loading error')
  }
)
```

#### Using Loading Manager

When you want to load multiple textures and be notified after the successful load we can also use the `LoadingManager`class and pass it into the `TextureLoader`

```JS
const loadingManager = new THREE.LoadingManager();
const textureLoader = new THREE.TextureLoader(loadingManager)
// you the can listen to the different events of the Loading manager
loadingManager.onStart = () => {
  console.log('loading started')
}
loadingManger.onLoaded = () => {
  console.log('loading finished');
}
loadingManager.onProgress = () => {
  console.log('loading progressing')
}
loadingManger.onError = () => {
  console.log('loading error');
}
```

### UV unwrapping

_UV Unwrapping_ defines how the texture is wrapped around the surface of the geometry. Each vertex has a 2D coordinate on a flat square plane that defines which part of the texture will displaces at that vertex position.

<iframe src="https://github.com/PineappleBeer/threejs-journey/raw/master/11-textures/files/uvUnwrapping1.png"></iframe>

To see the uv coordinates you can use the
`geometry.attributes.uv` property.

Three.js creates these uv properties for it's primitives. But if you create your own geometry in a 3D software or you import geometry you need specify the uv coordinates and need to to the uv unwrapping yourself.

#### UV Maps

A _UV Map_ tells THREE.js how to map a texture on an object.
By default THREE.js maps textures differently than blender. Blender wraps a texture over all sides of an object.
Three.js maps the whole texture on one _face_.

### Transforming the texture

#### Repeat

Especially if you use texture on bigger surfaces it can make sense to change the repeat of the texture otherwise it gets streched a lot.

_Lets repeat this texture 10 times x and 10 times y_
`texture.repeat.x = 10`
`texture.repeat.y = 10`
`texture.repeat.set(10,10)`
To make this work we need to set the `wrapS` and `wrapT` property of the texture.

```JS
grassTexture.wrapT = grassTexture.wrapS = THREE.RepeatWrapping
```

Another type of wrapping is `THREE.MirrorRepeatWrapping`

#### Offset

We can offset the texture with the `offset` property.
`texture.offset.x = 0.5`
`texture.offset.y = 0.5`

#### Rotation

To rotate the texture we use the `rotation` property.
`texture.rotation = Math.PI *0.25`
The rotation occurs around the bottom left corner which is the `0,0` uv coordinate.
To change the pivot point of the rotation you can use the `center` property

```JS
texture.rotation = Math.PI 0.25
texture.center.x = 0.5
texture.center.y = 0.5
```

#### Filtering and Mipmapping

_Mipmapping_ creates smaller versions of the texture - always halfed in size till 1x1. The GPU the picks the right texture for the render.
Three.js and the GPU handle this and we can decide which algorithm to use for that.
There are two types of filter alogrithms:

##### Minification

The _minification_ filter happens when pixels of the texture are smaller than the pixels of the render or the texture is to big for the surface it covers.
Different filter:

```JS
THREE.NearestFilter
THREE.LinearFilter
THREE.NearestMipmapNearestFilter
THREE.NearestMipmapLinearFilter
THREE.LinearMipmapNearestFilter
THREE.LinearMipmapLinearFilter//Default filter
```

To set the filter
`texture.minFilter = THREE.NearestFilter`

##### Magnification Filter

_Magnification_ filter works when the pixels of the texture are bigger thant the renders pixel - the texture is too small for the surface.
The texture gets then blurry because it gets stretched on the large surface.
Filter:
`THREE.NearestFilter`
`THREE.LinearFilter//Default`
`texture.magFilter = THREE.NearestFilter`

Generally `THREE.NearestFiler` is computationally cheaper than the other filter.
Also only mipmaps for the `minFilter` property. If you are using `THREE.NearestFilter` you don't need mipmaps and you can deactivate them with
`texture.generateMipmaps = false`
`texture.minFilter = THREE.NearestFilter`
This will creates less load for the GPU.

#### Texture Format and optimisation

Be aware of 3 factors when you prepare your textures:
_Weight_
_Size/Resolution_
_Data_

##### Weight

The users that are going to your website are going to download the textures. Use `.jpg`(lossy compression but lighter) or `.png`(lossless compression but heavier) for your files.

_Try to get an acceptable image but as light as possible_
[TinyPNG](https://tinypng.com/) can help.

##### Size

Try to reduce the size of the images as much as possible because every pixel of the image needs to get stored on the GPU - and with mipmapping even more pixel.

The size of your texture must have a power of 2
`512x512` `1024x1024` `512x2048`

or otherwise Three.js have to stretch the texture to the next power of two.

##### Data

For normal textures it makes sense to use `png` so you get a lossless compression.

##### Sources

To get good textures you can go to
[Poliigon](https://www.poliigon.com/)
[3Dtextures.me](https://3dtextures.me/)

## GLSL as Material

```JS
function createBackMaterial() {
   let m = new THREE.MeshBasicMaterial({
     color: 0x66775f,
     side: THREE.BackSide,
     onBeforeCompile: (shader) => {
       shader.fragmentShader = `
         ${shader.fragmentShader}
       `.replace(
         `vec4 diffuseColor = vec4( diffuse, opacity );`,
         `
         vec3 col = mix(diffuse, diffuse + vec3(0.75), smoothstep(0.5, 0.7, vUv.y));
         vec4 diffuseColor = vec4( col, opacity );
         `
       );
     console.log(shader.fragmentShader);
     },
   });
   m.defines = { USE_UV: "" };
   return m;
 };
```

## Displace material via displacement map

```JS
const textureLoader = new THREE.TextureLoader();
const displacementMap = textureLoader.load(`src/assets/img/height.png`)
displacementMap.wrapS = displacementMap.wrapT = THREE.RepeatWrapping;
```

# Scene

The `scene` object has `.children` property which allows us to access the children of the scene and more importantly
loop through all the children of the scene.

```JS
scene.children.forEach((child) => {
  //Test if child is actually a mesh
  if(child instanceof THREE.Mesh){
  child.rotation.x += 0.01;
  }
})
```

To be more performant because you don't want to loop through all the children on every frame you create a group
add that to the scene and then loop through the children of the group. Now we only loop through the elements that
we really want to.

```JS
...
const group = new THREE.Group();
group.add(plane,sphere,cylinder);
scene.add(group);

group.children.forEach((child)=> {
  if(child instance of THREE.mesh){
    child.rotation.x +=0.2;
  }
})
```

## Group

If you have multiple objects that belong together and maybe need to be transformed together it can make sense to group them together with the `Group` class which inherits also from `Object3D`.

```JS
const group = new THREE.Group()
group.scale.y = 2
scene.add(group)
```

You then can add objects to the group

```JS
const boxGeo = new THREE.BoxGeometry(1,1,1);
const boxMat = new THREE.MeshBasicMaterial({color:0xff0000})
const mesh = new THREE.Mesh(boxGeo,boxMat);
group.add(mesh)
```

## Frustum Culling

Three.js calculates if the geometry is on the screen and if not the object won't be rendered.

# Light

## AmbientLight

In reality light reflects of all the surface.
To create some light even behind our objects we want to add an `AmbientLight` to the scene.

```JS
const ambLight = new THREE.AmbientLight(0xffffff,0.2);
ambLight.intensity = 0.5;
scene.add(ambLight);
```

## Point Light

A `Point Light` has a small light source and spreads uniformly in every direction
`const pointLight = new THREE.PointLight(color,intensity)`

```JS
const pointLight = new THREE.PointLight(0xffffff,1);
pointLight.position.set(5,5,5);
scene.add(pointLight);
```

We also can control how the intensity of the light fades and how fast it is fading
`const pointLight = new THREE.PointLight(color,intensity,distance,decay)`
`const pointLight = new THREE.PointLight(0xff0000,0.5,8,5)`

## DirectionalLight

If you want a light like the sun you can use a `THREE.DirectionalLight('color',intensity)`

To have it shine more from the side we move it
`directionalLight.position.set(1,0.2,0.);`

We also can set the target of the directional light with the `target` property
`directionalLight.target.position.set(0,5,0)`
`directionalLight.target.updateWorldMatrix()`


## HemisphereLight

The `HemisphereLight` is similar to the `AmbientLight` but it emits a different color from the ground than from the sky.
`const hemLight = new THREE.HemisphereLight('colorSky','colorGround',intensity)`

## RectAreaLight

Works like a rectangle light. It mixes directional light with diffuse light.
`const rectAreaLight = new THREE.ReactAreaLight(color,intensity,widthRect,height)`
`const rectAreaLight = new THREE.RectAreaLight(0x0000ff, 2, 1, 1)`

This light only works with MeshStandardMaterial and MeshPhysicalMaterial

```JS
rectAreaLight.position.set(-2,0,1)
// to look at center of the scene
rectAreaLight.lookAt(new THREE.Vector3())
```

## SpotLight

Works like a flashlight with a cone of light starting at a point and oriented in one direction.
`distance` - At which distance drops intensity to 0
`angle` - How big is the beam
`penumbra`- How diffused is contour of the beam
`decay` - how fast does the light dim
`const spotLight = new THREE.SpotLight(color,intensity,distance,angle,penumbra,decay)`
`const spotLight = new THREE.SpotLight(0xff0022,0.5,10,Math.PI * 0.1,0.25,1)`

To rotate the `SpotLight` we have to add its `.target` to the scene

```JS
const spotLight = new THREE.SpotLight(0xff0022,0.5,10,Math.PI*0.1,0.25,1);
spotLight.position.set(0,3,2);
spotLight.target.position.x = -0.5;
scene.add(spotLight.target);

```

## Performance optimizations

Try to add as few lights as possible and use the light that has the lowest performance cost because lights are intensive to compute.

_Minimal Cost:_

- AmbientLight
- HemisphereLight
  _Moderate cost:_
- DirectionalLight
- PointLight
  _High Cost_
- SpotLight
- RectAreaLight

### Baking lights

Baking is a technique where we already can bake in the lightings of the scene into the material texture so we don't need
real time lighting.

### Light Helpers

We can use Three.js helpers to see how the lights are positioned

```JS
const hemisphereLightHelper = new THREE.HemisphereLightHelper(hemisphereLight,0.2);
scene.add(hemisphereLight);

const directionalLightHelper = new THREE.DirectionalLightHelper(diretionalLight,0.2);
scene.add(directionalLight);

const pointLightHelper = new THREE.PointLightHelper(pointLight,0.2);
scene.add(pointLightHelper)

const spotLightHelper = new THREE.SpotLightHelper(spotLight);
scene.add(spotLightHelper);
//needs to be updated
window.requestAnimationFrame(()=> {
  spotLightHelper.update();
})
```

```JS
import { RectAreaLightHelper } from 'three/examples/jsm/helpers/RectAreaLightHelper.js'

const rectAreaLightHelper = new RectAreaLightHelper(reactAreaLight)
scene.add(rectAreaLightHelper)
//needs to be updated
window.requestAnimationFrame(() =>
{
    rectAreaLightHelper.position.copy(rectAreaLight.position)
    rectAreaLightHelper.quaternion.copy(rectAreaLight.quaternion)
    rectAreaLightHelper.update()
})


```

## Shadows

The goal with shadows is to draw realistic shadows with keeping a reasonable frame rate.
How Three.js creates shadows is it first does a render for each light that is suppose to create shadows. These renders simulate what the light sees - similar to what a camera sees. It then creates a MeshDepthMaterial that replaces all meshes materials.
The result is stored as a shadow maps texture. These are used on every material that is supposed to receive shadows.

![Shadow Map Visualisation](https://threejs.org/examples/webgl_shadowmap_viewer.html)

To activate shadows we set them in the renderer
`renderer.shadowMap.enabled = true`

We then decide for each object in the scene if it can cast shadows or not and set the property `castShadow` to true.
`geo.castShadow = true`

At the end we also have to activate the shadows on the light sources.
`directionalLight.castShadow = true`

`PointLight,DirectionalLight,SpotLight` allow to activate shadows.

## Optimization of shadow maps

Generally one problem with shadow maps in Three.js is that it handles every shadow map for every object by itself so if you have multiple objects it doesn't merge the shadows of different objects.

Beware of settings to many `PointLights` with shadows in your scene. Three.js creates a cube shadow map and has to render 6 shadow map textures for each side of the directions.

### Size of Render

To improve the shadows we can access the `shadowMap` property to change the size of the shadowmap
`directionalLight.shadowMap.mapSize.width = 1024`
`directionalLight.shadowMap.mapSize.height = 1024`

### Near and far

If you have a situation where your shadow is cropped or you can't see the shadow at all it can be a problem of `near` and `far`. Three.js uses Cameras to render the shadow map so the `near` and `far` values of these cameras can cut off the shadow.

We can access the camera that is used for a shadow map with `light.shadow.camera`
To see the `near` and `far` values it can be useful to use a
`CameraHelper`
`const lightCameraHelper = new THREE.CameraHelper(light.shadow.camera)`
`scene.add(lightCameraHelper)`

We then can adjust the `near` and `far` values
`light.shadow.camera.near = 1`
`light.shadow.camera.far = 6`

### Amplitude

For [DirectionalLight](#directionallight) Three.js uses a [OrthographicCamera](#orthographic-camera). We can adjust and reduce the field of view to create more accurate shadows - the smaller the values the more accurate the shadows - but only reduce the values till you cut off your shadows.

```JS
directionalLight.shadow.camera.top = 2
directionalLight.shadow.camera.right = 2
directionalLight.shadow.camera.bottom = -2
directionalLight.shadow.camera.left = -2
```

For [SpotLight](#spotlight) Three.js uses a [Perspective Camera](#perspectivecamera) so have to set the field of view `.fov` property.
`spotLight.shadow.camera.fov = 20`

### Blur

To reduce the sharp edges of your shadow if can make sense to add some `blur` to your shadows.
`light.shadow.radius = 5`

### Shadow map algorithm

Three.js has different types of shadow map algorithms that we can use:

- `THREE.BasicShadowMap` - Very performant but low quality
- `THREE.PCFShadowMap` - Less performant with smoother edges
- `THREE.PCFSoftShadowMap` - Less performant but edges are even smoother
- `THREE.VSMShadowMap` - Less performant

We can set the shadow map algorithm with `renderer.shadowMap.type = THREE.PCFSoftShadowMap`
Three.js uses `PCFShadowMap` as the default.

### Baking shadows

A good alternative to using Three.js shadows is to bake the shadows similar to [baking the lights](#baking-lights).
The problem is that they only work for non dynamic scenes where the objects don't change there position or rotation.

Another more dynamic way is to bake a shadow and then set it as a material for a plane that lies a little bit over the
ground plane. If the object then comes close to the ground we set the opacity of that material to high and if it far from ground we set it to low

```JS
const sphereShadow = new THREE.Mesh(
    new THREE.PlaneGeometry(1.5, 1.5),
    new THREE.MeshBasicMaterial({
        color: 0x000000,
        transparent: true,
        alphaMap: simpleShadow
    })
)
...
sphereShadow.position.y = plane.position.y + 0.01
sphereShadow.material.opacity = (1 - sphere.position.y) * 0.3
```

See more at the end of this [Site](https://github.com/PineappleBeer/threejs-journey/tree/master/15-shadows)

# Optimizations

## One Instance of material and geometry

Use one material and one geometry for multiple meshes.
If you create a loop to create multiple meshes set the material and the geometry outside

```JS
const material = new THREE.MeshMatcapMaterial({matcap:matcapTexture});

const geo = new THREE.BoxGeometry(1,1,1);

for(let i = 0; i<100;i++){
  const mesh = new THREE.Mesh(geo,material);
}

```

## Disposing unused instances

To improve the performance and avoid memory leaks we should dispose unused Three.js library entities.
Whenever we create an instance of a three.js type, certain amount of memory gets allocated.

Free up our memory of unused instances of three.js types we can use the `.dispose()` method.

`myMaterial.dispose()`
`myGeo.dispose()`
`scene.remove(Mesh/Points)`

# Realistic Render
The goal is to render as realistic as possible.

For environmentmap try to use the smallest possible texture - especially if you don't use it as a background.

## Tone mapping
Tone mapping is a technique where Three.js fakes the process of converting low dynamic range(LDR) values to high dynamic range(HDR) values.
`renderer.toneMapping = THREE.NoToneMapping`(default)
Possible values that we can use are:
`THREE.LinearToneMapping`
`THREE.ReinhardToneMapping` - settings similar to a camera with improper settings.
`THREE.CineonToneMapping`
`THREE.ACESFilmicToneMapping`

To influence the amount of light that we want to allow in the scene we can adjust the expose of the tone mapping.
`renderer.toneMappingExposure = 3`

## Antialiasing
Aliasing happens because the renderer tests what geometry is being rendered in that currently rendered pixel. Because the edges of the geometry are not aligned with the vertical and horizontal particle grid the geometry seems to be pixelated because every pixel just can have one color.

One solution is to increase the resolution of the renderer and render the scene at a much higher resolution than needed and then shrinking it down. This is called *Super Sampling Anti-Aliasing(SSAA)*.
- Render everything at 2x the size
- Resize it back down to normal size
- Final image is smoother because each pixel is average of 4 higher-resolution pixels

This leads to a better quality but also is heavy on the performance.

Another way is *Multi Sampling Anti-Alisaing* which just applies the anti-aliasing to the edges of the object, where jaggedness is most visible.
- Only samples multiple points on the geometry edges
- Blends samples to produce smoother edges.
Like only smoothing out the lines of a drawing without touching the inside or the background.

This is much faster than SSAA but doesn't work well with certain effects like post-processing shaders or transparent objects.

We can activate *MSAA* by setting `renderer.antialias:true` in the `WebGLRenderer.

Because screens with a pixel ratio above 1 don't need antialiasing it can make sense to only allow antialiasing when the screen pixel ratio is below 2.

## Shadow
To create realistic shadows when we are using environmentmap we need to add a light in the scene that is similar to the lighting of the environmentmap.
Then activate shows in the renderer
`renderer.shadowMap.enabled=true`
`renderer.shadowMap.type = THREE.PCFSoftShadowMap`
`directionalLight.castShadow = true`

When we enable shadows for a `directionalLight` Three.js uses an orthographic camera to render the shadow map - a black and white picture of what the light sees. 
For that camera we also can set the `near` and `far` values - they define how close or far objects can be form the light to cast shadows.
So we can reduce the default value of `far` 
`directionalLight.shadow.camera.far = 20`

So only object between 1 and 20 units away from the light should cast shadows.

To increase the quality of the shadows we also can increase the shadow map to something like `1024x1024`.
`directionalLight.shadow.mapSize.set(1024,1024)`
Also play with smaller resolutions if you get good enough results and can improve your performance.

To activate shadows in all materials of the loaded object we can create a function `updateAllMaterials` that activates the shadows in each material and call it when the model got loaded.
```JS
const updateAllMaterials = () => {
  //
  scene.traverse((child) => {
    if(child.isMesh){
      child.castShadow = true
      child.receiveShadow = true
    }
  })
}
```
`traverse()` is a build in Three.js function that loops through the entire hierachy of the scene and all objects in scene graph - including children, grandchildren etc.

Especially when you use your own created models it can happen that you get `shadow acne`. It means the shape is casting a shadow on its own surface. It can happen when calculating if the surface is in the shadow or not. 

To fix that we have to change the `bias` and `normalBias` of the shadow.
`bias` - helps for flat the surfaces
`normalBias` - helps for rounded surfaces
Play with the values and debug.ui to find the right values.

## Textures and color space
You can get good textures at [Polyhaven](https://polyhaven.com/textures)
Here are some exemplary settings:
![alt text](./img/ExemplaryPolyhavenSettings.png)

`Color space` defines how color values are intepreted - especially brighness.
But humans don't see brighness linearly - because we are more sensitive to darker tones than lighter ones. Often images are stored in a `non-linear color space` called `sRGB`.

Three.js uses two color spaces:
- `THREE.LinearSRGBColorSpace` - Default color space used for math,lighting,shaders etc
- `THREE.SRGBColorSpace` - used for textures meant to be seen(albedo/diffuse/color maps)

So we can split textures into two categories:
- Visual textures
  - Color textures -> `texture.colorSpace = THREE.SRGBColorSpace`
- Data textures -
  - Non color information
  - normal textures
  - roughness texture -> should stay in linear space
  - ambientocculusion texture
  

# Add Gizmo to object

With _TransformControls_ you can add a gizmo to an object so you can move an object.

_DragControls_ allows you to move an object ona plane facing the camera by drag and drop them.

# Interactions

## Raycaster

A Raycaster shoots a ray in a specific direction and checks if it hits any objects or any object intersects with it.
This allows us for example to detect if the camera/player is facing a specific object or something is currently under the mouse and more.

Raycaster work on Meshes and on Groups because the raycaster checks by default the children and the children of children of the object.

To create a raycaster we call
`const raycaster = new THREE.Raycaster();`

With the `.set(postion,direction)` method we can set the position and direction of the Raycaster

```JS
const rayCaster = new THREE.Raycaster();

const rayOrigin = new THREE.Vector3(-3,0,0);
const rayDirection = new THREE.Vector3(10,0,0);
rayDirection.normalize()
rayCaster.set(rayOrigin,rayDirection);
```

To detect the objects that lay in the ray we can use`intersectObject()` and `intersectObjects()`.

```JS

const intersectObject = rayCaster.intersectObject(objectX)
const intersectObjects = rayCaster.intersectObjects([objectX,objectY,objectZ]);
```

By setting the second parameter to false we can set that the raycaster doesn't check for collisions with the children of the object.
`const intersectObject = rayCaster.intersectObject(objectX,false)`

We always get back an Array as the result of the `intersectObject/s` functions because a ray can go through an object mulitple times.
The information that we get returned are:

- `distance` - distance between origin of ray and collision point
- `face` - what face of the geometry got hit by the ray
- `faceIndex` - index of face
- `object` - what is object of the collision
- `point` - `Vector3` of exact position in 3D space of the collision
- `uv` - UV coordinates in the geometry

To test if there is an object in front of the player we can use `distance`.
To change the color of an object we can manipulate the `object`.
To trigger an explosion at the impact point of the ray we can use `point`.

To test if moving objects hit a raycast we need to execute the test every frame.

```JS
...
const clock = new THREE.Clock()
const tick = () => {
  const elapsedTime = clock.getElapsedTime();

  const rayOrigin = new THREE.Vector3(-3,0,0);
  const rayDirection = new THREE.Vector(1,0,0);
  rayDirection.normalize();
  rayCaster.set(rayOrigin,rayDirection);
  const objectsToTest = [object1,object2,object3]
  const intersects = rayCaster.intersectObjects(objectsToTest);

  for(const object of objectsToTest){
    object.material.color.set('#00ff00')
  }

  for(const intersect of intersects){
    intersect.object.material.color.set('#ff0022')
  }

  object1.position.y = Math.sin(elapsedTime *0.3) * 1.5;
  object2.position.y = Math.sin(elapsedTime *0.6) * 1.5;
  object3.position.y = Math.sin(elapsedTime *0.4) * 1.5;
}
```

### Raycaster with mouse

#### Hovering

To evaluate if the mouse is hovering an object we need to get the position of the mouse.
We want the value range from `-1 to 1` on the vertical and the horizontal with the vertical value being postivie when the mouse is up.

```
(-1|1)                (1|1)

            (0|0)

(-1|-1)               (1|-1)
```

```JS
const cursor = new THREE.Vector2();

window.addEventListener("mousemove",(event)=> {
  cursor.x = event.clientX/sizes.width * 2 -1;
  cursor.y = -(event.clientY/sizes.height) * 2 +1;
});

// Recommended to cast the ray in the tick because in some browser casting in the eventlistener could trigger it multiple times

const tick = () => {
  //To point the ray in the right direction
  rayCaster.setFromCamera(mouse,camera);
 const objectsToIntersect = [object1,object2,object]

  const intersects = rayCaster.intersectObjects(objectsToIntersect);

  //Set object to blue
  for(const intersect of intersects){
    intersect.object.material.color.set('#0000ff')
  }
  //Set to red
  for(const object of objectsToIntersect){

    if(!intersects.find(intersect=>intersect.object === object)){
      object.material.color.set('#00ff00')
    }
  }

}
```

#### Mouse Enter Mouse Leave

To see if the mouse enters or leaves an area or an object we can create a variable that tracks if the object still intersects or not. We then set and reset it in `tick()`

```JS
let currIntersect = null;

const tick = () => {
  raycaster.setFromCamera(mouse,camera);

  const objectsToIntersect = [object1,object2,object3]
  const intersects = raycaster.intersectObjects(objectsToIntersect)
  //if intersects.length = 0 -> false
  if(intersects.length){
    if(!currentIntersect){
      console.log('mouse enter');
    }
    currIntersect = intersect[0]

  } else {
    if(currIntersect){
      console.log('mouse leave')
    }
    currIntersect = null
  }
}

window.addEventListener('click', () => {
  if(currIntersect){
    console.log("click")
    switch(currIntersect.object){
      case object1:
        console.log("obj 1");
        break;
      case object2:
        console.log("obj 2");
        break;
      case object3:
        console.log("obj 3");
        break;
    }
  }
})
```

## Mouse Movement

We can use the mouse to set the position of our camera and let the camera always look at the object.

To get the mouse position we listen to the JS event `mousemove` with the `addEventListener`

```JS
const camera = new THREE.PerspectiveCamera(75,window.innerWidth/window.innerHeight,1,100);

camera.position.z = 10
camera.lookAt(mesh.position);
scene.add(camera);

```

<iframe height="300" style="width: 100%;" scrolling="no" title="T3.JS Look at Object Move Camera with Mouse" src="https://codepen.io/levoxtrip/embed/jEOGYxd?default-tab=html%2Cresult" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/levoxtrip/pen/jEOGYxd">
  T3.JS Look at Object Move Camera with Mouse</a> by levoxtrip (<a href="https://codepen.io/levoxtrip">@levoxtrip</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>

### Doing full rotation around object

By using `Math.PI` we can map the mouse position onto a specific angle on the circle. So we translate the camera on a circle shape around the object and let it look at the object.

```JS
const radius = 2;
camera.position.x = Math.sin(Math.PI * 2 *cursor.x)*radius;
camera.position.z = Math.cos(Math.PI *2 * cursor.x)*radius;
camera.position.y = cursor.x * 2;
camera.lookAt(mesh.position)
```

<iframe height="300" style="width: 100%;" scrolling="no" title="T3JS Camera rotate around obj" src="https://codepen.io/levoxtrip/embed/raNYKxV?default-tab=html%2Cresult" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/levoxtrip/pen/raNYKxV">
  T3JS Camera rotate around obj</a> by levoxtrip (<a href="https://codepen.io/levoxtrip">@levoxtrip</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>

## Scrolling

### Scroll Along a Path

```JS
    // First define your variables
    let scrollTotal = 0;
    const scrollSpeed = 0.1;
    const scrollMin = 0;
    const scrollMax = 500;
    let scrollPathPos = 0;

    // Define the function first
    const handleWheel = (event) => {
      event.preventDefault();
      const deltaY = event.deltaY || event.detail || -event.wheelDelta;

      // Update total scroll
      scrollTotal += deltaY * scrollSpeed;
      if (scrollTotal < 0) scrollTotal = 0;
      // Clamp the TOTAL scroll value
      const clampedScroll = Math.max(
        scrollMin,
        Math.min(scrollMax, scrollTotal)
      );

      // Map from scroll range to 0-1 range
      scrollPathPos = (clampedScroll - scrollMin) / (scrollMax - scrollMin);

      const pathT = Math.min(1, Math.max(0, scrollPathPos));
      console.log(pathT);

      const camPos = path.getPointAt(pathT);
      camera.position.copy(camPos);
      const tangent = path.getTangentAt(pathT).normalize();
      camera.lookAt(camPos.clone().add(tangent));
    };

    // Then add the event listener
    const domElement = renderer.domElement;
    domElement.addEventListener("wheel", handleWheel, { passive: false });
```

### Scroll Elements top to bottom

The idea is that we position of objects on different y axis in the scene and then make the camera scroll with the
scroll event.
For the html elements you need to wrap them in `<section>`

```JS
//Position objects
const objectDistance = 4
mesh1.position.y = - objectsDistance * 0
mesh2.position.y = - objectsDistance * 1
mesh3.position.y = - objectsDistance * 2
```

To get the scroll value we can get `window.scrollY`. This value contains the amount of pixels that have been scrolled. This number can get quite big. To show only one element per viewport section we can divide the scrolling value with the height of the viewport.
`window.innerHeight`

```JS
let scrollY = window.scrollY

window.addEventListener('scroll',()=> {
  scrollY = window.scrollY
})

const tick = () => {
  // Scroll Y is positive when scrolling down so we need to invert it.
  //If the user scrolls down one section, the camera moves down to the next object
  camera.position.y = - scrollY/window.innerHeight * objectDistance
}
```

#### Parallax

To make the experience more immersive and intresting we can add a parallax effect by additionally moving the objects
according to the mouse.

```JS
const cursor = {}
cursor.x = 0;
cursor.y = 0;

window.addEventListener("mousemove",()=>{
  //Pixel position of the mouse
  // Normalise these values so users with different viewports have the same experience
  cursor.x = event.clientX/window.innerWidth - 0.5;
  cursor.y = event.clientY/window.innerHeight - 0.5 ;
})

const tick = ()=> {
  const paralaxX = cursor.x;
  const paralaxY = - cursor.y;
  camera.position.x = parallaxX;
  camera.position.y = parallaxY;
}
```

The problem is when we apply the mouse position to the camera the scroll effect doesn't work anymore. Because
the scroll gets overwritten.
To solve the problem we add the camera to a group and then apply the parallax effect to the group not the camera itself.

```JS
const camGroup = new THREE.Group();
scene.add(camGroup)
const camera = new THREE.PerspectiveCamera(35,window.innerWidth/window.innerHeight,0.1,100);
camera.position.z = 6;
cameraGroup.add(camera);
...

const tick = () => {
  // Animate camera
    camera.position.y = - scrollY / sizes.height * objectsDistance

  const paralaxX = cursor.x;
  const paralaxY = -cursor.y;
  camGroup.position.x = parallaxX;
  camGroup.position.y = parallaxY;
}
```

#### Easing

To make the experience even smoother we should apply some easing.
The idea is that on each frame instead of lineally moving straight to the target we move a fraction of the total distance like 1/20th closer to the target. So every frame the camera gets closer to the target and the fraction of the distance smaller so - so first the camera moves faster and the closer it gets to the target the slower it moves.

To again assure this works on every device the same way we need to multiply it with the time between the current frame and the previous frame

```JS

const clock = new THREE.Clock();
let previousTime = 0;
const tick = () => {
  const elapsedTimes = clock.getElapsedTime();
  const deltaTime = elapsedTime - previousTime;
  previousTime = elapsedTime;
}

//parallaxX -cameraGroup.postion calculates the distance
cameraGroup.position.x += (parallaxX-cameraGroup.position.x)*deltaTime*5;
cameraGroup.position.y += (parallaxY-cameraGroup.postion.y)*deltaTime*5;
```

#### Trigger animations

To trigger animations when we reach a section we can create a `currentSection` variable and set it to the `scrollY/window.innerHeight`. This create an index value with `Math.round()`

```JS
let scrollY = window.scrollY
let currentSection = 0;

window.addEventListener('scroll',()=>{
  scrollY = window.scrollY;
  const newSection = Math.round(scrollY/window.innerHeight);
  if(newsection != currentSection){
    currentSection = newSection;

    gsap.to(
      sectionMeshes[currentSection].rotation,
      {
        duration:1.5,
        ease:'power2.inOut',
        x: '+=6',
        y: '+=3'
        z: '+=1.5'
      }
    )
  }

})

const tick = () => {
  ...
  for(const mesh of sectionMeshes){
    mesh.rotation.x += deltaTime*0.1
    mesh.rotation.y += deltaTime*0.12
  }
}


```

# Physics

Physics help to make the experience of your website more playful.
To get realistic physics with tension, friction, bouncing etc it makes sense to use a library instead of writing all your own physics.

## Theory

To have physics in our Three.js scene we need to create a physics world where the laws of physics rule. But we can't see it. It is theoretical.
We create our mesh in the Three.js scene and also create a version of that mesh in the physics world. On each frame before the rendering happens we tell the physics world to update itself. We then take the values from the objects in the phyics world and assign them to the Three.js objects.

## Libraries

### 3D

#### Ammo.js

[Website](http://schteppe.github.io/ammo.js-demos/)
A can be quite heavy
Still updated by community
Mostly used.
Three.js examples.

#### Cannon.js

[Website](https://github.com/schteppe/cannon.js)
Lighter than Ammo.js and easier to implement.

To install cannon.js `npm install cannon` and then `import CANNON from 'cannon'`

There is also a library that is based on cannon but actually still get's updated. It is called `Cannon-es`
`npm install cannon-es`

To create a physics world we use `new CANNON.Wolrd()`
`const world = new CANNON.World()`

To add gravity we set a `Vec3`
`cannon.gravity.set(0,-9.82,0)`

When we want to add shapes the the physics world we need to add `Body`. It is a an object that will fall and collide with other bodies. But before that we decide which shape the body should take

```JS
...
const sphreShape = new CANNON.Sphere(0.5)

const sphereBody = new CANNON.Body({
  mass:1,
  position: new CANNON.Vec3(0,3,0),
  shape: sphereShape
})
//Adding body to the world
world.addBody(sphereBody)

```

To update the physics world we need to use the `step()`function. How it works gets described here:[Timesteps](https://gafferongames.com/post/fix_your_timestep/).
The `.step()` function expects a fixed time step. For 60 FPS we give it a value of `1/60`.
For the number of iterations we can use a value like `3`.
For delta time we use the clock and calculate the delta time with elapsedTime

```JS
const clock = new THREE.Clock();
let oldElapsedTime = 0

const tick = () => {
  const elapsedTime = clock.getElapsedTime();
  const deltaTime = elapsedTime-oldElapsedTime;
  oldElapsedTime = elapsedTime;

  world.setp(1/60,deltaTime,3);
}
```

What is missing now is that we need to assign the values from the `sphereBody` to the shape in three.js

```JS
sphere.position.x = sphereBody.position.x
sphere.position.y = sphereBody.position.y
sphere.position.z = sphereBody.position.z
```

OR
`sphere.position.copy(sphereBody.position);`

To make objects interact/react to each other all the object need to bodies in the physics world.

##### Adding Box

A Box Body in Cannon has a different messure than in Three.js.
It needs a `halfExtents` which is a `Vec3` and represents a segment from the center of the box to the box corners.

```JS
const boxShape = new CANNON.Box(new CANNON.Vec3(width*0.5,height*0.5,depth*0.5));
const boxBody = new CANNON.Body({
  mass:1,
  position:new CANNON.Vec3(0,1,0);
  shape:boxShape,
  material:defaultMaterial
})
world.addBody(boxBody)
```

##### Static Body

If you want an object to be static, so not affected by gravity we can set `mass =  0`
You also can first create your `shape` and `body` and then assign the properties

```JS
const plane = CANNON.Plane()
const planeBody = CANNON.Body();
planeBody.mass = 0
planeBody.addShape(plane);
world.add(planeBody);
// To rotate we use quaternion in CANNON
planeBody.quaternion.setFromAxisAngle(new CANNON.Vec3(-1,0,0),Math.PI*0.5);
```

In `Cannon` we can also create a `Body` and add multiple `Shapes` for example for complex but solid shapes.

##### Contact Material

To affect how different bodies react with each other we can set a `Cannon` `ContactMaterial` and `Material`. So we create a material for each type of material we have in our scene.
The `default` material is `plastic`. We can write both `default` or `plastic` for that material.
`const plasticMat = new CANNON.Material('plastic')`

For the interaction between the materials in the scene we also have to create a `ContactMaterial` that defines how these two materials react to each other.

```JS
const plasticMaterial = new CANNON.Material('plastic');
const concreteMaterial = new CANNON.Material('concrete');

const plasticConcreteContactMaterial = new CANNON.ContactMaterial(
  concreteMaterial,
  plasticMaterial,
  {
    friction:0.1,//How much does it rub - default value 0.3
    restitution:0.7// how much does it bounce - default value 0.3
  }
)
world.addContactMaterial(plasticConcreteContactMaterial);
```

We also then have to assign these physics materials to the bodies

```JS
const sphereBody = new CANNON.Body({
  ...
  material:plasticMaterial
})

planeBody.material = concreteMaterial;
```

or delete the assigning for each material and just set the contact material for the world
`world.defaultContactMaterial = defaultContactMaterial`

##### Applying forces

There are multiple ways to apply different forces in CANNON:

- `applyForce` to apply a force from specific point in space:
  - [wind](#applying-wind)
  - small sudden push on domino
  - greate sudden force like a jump
- `applyImpulse` similar to `applyForce`applies directly to the velocity
- `applyLocalForce` same as `applyForce` but coordinates are local to the body `(0,0,0) center of the body`

  - to apply a small impulse
    `sphereBody.applyLocalForce(new CANNON.Vec3(150,0,0), new CANNON.Vec3(0,0,0))`

- `applyLocalImpulse` is the same as `applyImpulse` but the coordinates are local to the Body.

###### Applying wind

Because the wind force is happening every frame we apply these force in `tick()`

```JS

const tick = () => {
  ...
  sphereBodey.applyForce(new CANNON.Vec3(-0.5,0,0), sphereBody.position);
  ...
  world.step(1/60,deltaTime,3);
  ...
}
```

##### Multiple Objects

When we handle multiple objects first it makes sense to create functions that handle the `THREE.js` mesh and the `CANNON.Body` creation in one function. Second we create an array where we add the created objects so we can change them later

```JS
const objectsToUpdate = [];
const createSphere = (position,radius) => {
  const sphereMesh = new THREE.Mesh()
  const sphereGeo = new THREE.SphereGeometry(radius,20,20);
  const sphereMat = new THREE.MeshStandardMaterial({
    metalness:0.3,
    roughness:0.4,
    envMap:environmentMapTexture,
    envMapIntensity:0.5
  })
  sphereMesh.add(sphereGeo,sphereMat);
  sphereMesh.castShadow = true;
  sphereMesh.position.set(position);
  scene.add(sphereMesh);


  const sphereShape = new CANNON.Sphere(radius);
  const sphereBody = new CANNON.Body({
    mass:1,
    position: position,
    shape:sphreShape,
    material:defaultMaterial
    }
  )
   world.addBody(body);
   objectsToUpdate.push({
    mesh:sphereMesh,
    body:sphereBody
   })
}


const tick = () => {
  ...
  world.step(1/60,deltaTime,3);
  for(const obj in objectsToUpdate){
    //Assign position of physics body to the threejs mesh
    obj.mesh.position.copy(obj.body.position);
    //Copy the rotation
    obj.mesh.quaternion.copy(obj.body.quaternion);
  }
}
```

##### Events

We can listen and use events to execute some logic for our scene.
Event we can listen to are `colide`, `sleep`,`wakeup`

```JS
body.addEventListener('collide', playSound)

const playSound = (collision) => {
  //Resetting time of sound so if another sound is playing it starts again from the start.
  sound.currentTime = 0;
  sound.play()
}
```

We also get from the event the strength of the `collision` with `collision.contact.getImpactVelocityAlongNormal()` which we then can use to determine some logic.

When you remove bodies from the scene don't forget to remove also the eventlistener
`body.removeEventListener('collide',playSound)`

##### Constrains

CANNON has different constrains to create certain behavior:

- `HingeConstraint` Doorhinge behaviour
- `DistanceConstraint` Bodies are forced to keep distance between each other
- `LockContraint` mergin bodies
- `PointToPointConstraint` gluying body to specifc point

##### Performance

###### Removing Elements

To remove `Bodies` from the world we can use `world.removeBody(obj.body)`

###### Broadphase

To assure a good performance of your scene you don't want to calculcate every `Body` against all other `Bodies`.
The goal is to just process the bodies that are actually close to each other and react with each other.
For that CANNON has `Broadphase` with different algorithms to presorts the `Bodies` before it processes the calculations:

- `NaiveBroadphase`: Actually tests all the `Bodies` against each other(default).
- `GridBroadphase`: Splits up the world into girdcells and only tests the `Bodies` that are in the same or the neighbors gridcell.
- `SAPBroadphase`: Test `Bodies` on arbitrary axes during multiple steps(recommendet).

`world.broadphase = new CANNON.SAPBroadphase(world);`

###### Sleep

Even if the `Body` stays still it gets tested by `Broadphase`. To avoid that we can put the object into `sleep` if the
`Body's` velocity is really low until a force is applied to it or a collision happens.
`world.allowSleep = true`

With `sleepSpeedLimit` and `sleepTimeLimit`we can define thresholds to the sleep behaviour

###### Workers

Workes allow you to put part of your code on a different thread to improve performance. But that code has to be seperated
as you can see here [Worker Example](https://github.com/schteppe/cannon.js/blob/master/examples/worker.html);

Further information [here](https://schteppe.github.io/cannon.js/)

#### Oimo.js

[Website](https://lo-th.github.io/Oimo.js/)
Lighter than Ammo.js and also easier

#### Rapier

[Website](https://rapier.rs)
Good performance
Currently maintained

### 2D

#### Matter.js

[Website](https://brm.io/matter-js/)
Still kind of updated

#### P2.js

[Website:] (https://schteppe.github.io/p2.js/)
Hasn't been update for 2 years

#### Planck.js

[Website:](https://piqnt.com/planck.js/)

#### Box2D.js

[Website:] (http://kripken.github.io/box2d.js/demo/webgl/box2d.html)

# Color class

## Set color of a material

`object.material.color.set('#ff0000')`

## Mix Colors

We can use the `color1.lerp(color2,alpha)` function to mix two colors

# Vector3 class

### Set Vector

`mesh.position.set(0.2,0.7,0.3)`3

### Get the length of the position vector

`mesh.position.length()`

### Get the distance from another Vector

`mesh.position.distanceTo(camera.position)`

### Normalize Length of Vector

`mesh.position.normalize()`

# Debug UI

There are multiple libraries to create some Debug UIs.
The most popular like [dat.GUI](https://github.com/dataarts/dat.gui)
or
[control-panel](https://github.com/freeman-lab/control-panel)
[controlkit](https://github.com/automat/controlkit.js)
[guify](https://github.com/colejd/guify)
[oui](https://github.com/wearekuva/oui)

## Dat.GUI

### Implementation

Installation
`npm install --save dat.gui`
Import
`import * as dat from 'dat.gui'`
Instantiation
`const gui = new dat.GUI`

### Elements

`Range` - numbeers with minimum and maximum value
`Color` - for various color formats
`Text` - Simple Text
`Checkbox` - for booleans
`Select` - Choice from list of values
`Button` - to trigger functions
`Folder` - to organize panel with lot of elements

### Add Elements

We add elements with `gui.add(object,property of object)` to add elements to the GUI.

`gui.add(mesh.position, 'y')`

Specifying ranges and steps
`gui.add(mesh.position,'y',-3,3,0.01)`
or use methods from _dat.GUI_.
`gui.add(mesh.position,'y').min(-3).max(3).step(0.01).name('elevation')`

### Set Element visible via GUI

`gui.add(mesh,'visible')`
### Drop-down 
To create a drop down we add an object with key value pairs to it
```JS
gui.add(renderer,'toneMapping'){
  key1:value1,
  key2:value2,
  key3:value3,
  key4:value4,

}
```

### Colors

Define object with color as its property
`const parameters = { color: 0xff0000}`
Add object
`gui.addColor(parameters,'color')`

Signaling changes of property in Dat.GUI properts and setting property in three.js

```JS
const parameters = {
  color:0xff0000
}
gui.addColor(parameters,'color')
.onChange(()=> {
  material.color.set(parameters.color)
})

const material = new THREE.MeshBasicMaterial({color:parameters.color})
```

### Update Values

If we want to show and update the values in our scene we have to call `.onChange()`

```JS

gui.add(parameters,'materialColor')
  .onChange(()=>{
    material.color.set(parameters.materialColor)
  })
```

### Trigger a function

To trigger a function we have to add the function again like with colors to an object.

```Js
import gsap from 'gsap'
...
const parameters = {
  color,0xff0000,
  spin: () => {
    gsap.to(mesh.rotation,{duration:1, y:mesh.rotation.y +Math.PI*2})
  }
}

gui.add(parameters, 'spin')

```

If you want to trigger a function which also needs parameters we can create an object for that

```JS
const gui = new GUI();
const debugObject = {}
debugObject.createSphere = () => {
  createSphere(0.5,{x:0,y:2,x:1})
}
gui.add(debugObject,'createSphere')
```

### Hide Panel

We can press `H` to hide the panel
or set it hidden from beginning
`gui.hide()`

### Close Panel

To have your GUI closed at the beginning
`const gui = new dat.GUI({closed:true})`

### Set Width of Panel

`const gui = new dat.GUI({width:400})`

More infos under [dat.GUI API](https://github.com/dataarts/dat.gui/blob/HEAD/API.md)

# Show window to control and change properties of the objects

```JS
const pane = new Pane()
pane.addInput(material, 'shininess',{
  min:0,
  max:100,
  step:1
})

// passing two objects
pane.addInput(grassTexture, 'offset', {
  x: {
    min:0,
    max:1,
    step:0.001
  },
  y: {
    min:0,
    max:1,
    step:0.001
  }
})

```

# Vite Config file

```JS
export default {
    root: 'src/',//Where are we serving up our experience
    publicDir: '../static/',//We are hosting our static assets in the static folder
    base: './',
}
```

# Math functions

_PI_: `Math.PI`
_SINE_: `Math.sin()`

## create random angles

`const angle = Math.Random() * Math.PI *2;`

# Code Structure for bigger projects

== TO JAVASCRIPT BASICS LATER ==
## Modules
Modules allow us to seperate our code into multiple files and then import them when needed
`import test from './test.js'`

Modules can export one or multiple things.
`export default 'Hello World, this is my first module'`

In the other script 
```JS
import test from './test.js'
console.log(test)
//Hello World, this is my first module
```

It's important that for our own modules we need to add `./` before the file otherwise JS tries to find it in the `node_modules`

*Export a function*
To export a function
```JS
export default () => {
  console.log("Hallo")
}
```
*Export object*
```JS
const object = {
  me:"Hallo world"
}

const printMe = ()=> {
  console.log("me")
}
//Export one object
export default object;
//Or export multiple
export default {object,printMe}

import {object,printMe} from './test.js'
console.log(object)
printMe()

```

## Classes
Classes in JS allow to use *Object-oriented Programming*

To create a class
`class MyClass{}`
By convention classes are written in *PascalCase* starting with a capital letter.

Classes are blueprints to create an object. We then can use that blueprint to create multiple objects.

To create an *instance*  of the the class
`const classInstance = new MyClass()`

Functions inside a class
```JS
class MyClass{
  doThis(){
    console.log("I'm doing this")
  }
}

classInstance.doThis();
```

Classes have a `constructor` method that get's called when the class got instantiated
```JS
class MyClass{
  constructor(name,age){
    this.name = name
    this.age = age
    console.log(`I'm ${this.name} and I'm alive`)
    this.doThis();
  }
  doThis(){
    console.log(`And now ${this.name} do this`)
  }
}

const classInstance = new MyClass("MyName")
console.log(classInstance.age)

```

### Inheritance
Classes allow us to let a class inherit from a parent class. So we can create a `Parent` class and then let a `Child` class inherit behaviour and values from the `Parent`

```JS
import ParentClass from './ParentClass.js'
class ChildClass extends ParentClass
{
  childBehaviour1(){
    console.log(`${this.name} is hungry but can't make dinner on his own`)
  }

  //Methods in the Childclass with the same name like the parent will overwrite the parent class

  doThis(){
    console.log(`now a child does this`)
  }

}
```

If you want the `Child` class to have a different constructor or you want to extent the `Parent` constructor in the `Child` class we need to call`super()`
```JS
import ParentClass from './ParentClass.js'
class ChildClass extends ParentClass{
  constructor(name,age){
    //super basically calls the constructor of the parent class
    super(name,age);

    this.canEat = false

    //you could even call the method from the parent class but this can make the code complicated
    super.doThis()
  }
}
```



## Structuring Code
So the idea is to seperate the code into different files and export in each file a class .

A good practise is to put the whole three.js experience into its own `Experience` class.
```JS
export default class Experience{
  constructor(){
    console.log("Welcome to my experience")
  }
}

import Experience from './Experience.js'
const experience = new Experience();
```

It makes sense to send the canvas as a parameter into the class

```Js
export default class Experience {
  constructor(canvas){
    this.canvas = canvas;
  }
}
...
const experience = new Experience(document.getSelector('canvas'))
```




# Own hacks

## Tile effect

```JS
const tex = textureLoader.load(...)
tex.repeat.set(2,2)
tex.wrapS = tex.wrapT = THREE.MirroredRepeatWrapping
```

# Interesting Tools

## Blender

### Path conversion

<iframe src="https://github.com/ClassOutside/Export_Vertices_To_JSON">
https://github.com/ClassOutside/Blender_Path_To_Three.JS

# Ideas

Animate the field of view of the camera from long small to big field of view
![Idea](https://github.com/PineappleBeer/Three.JS-journey/raw/master/07-cameras/files/video-1.gif)

Create a scene where you only see the baked shadows. Use that to tell a story

Physics - on collision switch materials

Animate elements and have a model with black texture on black background so it negates the animated objects

Let shapes unrotated and rotate environment map or background of scene to create intresting effects
