---
comments: true
tags:
    - Javascript
    - React
---
# Setup Three.JS in React
`npm install three`

# Basic Scene

All we need to show a three.js scene is a `<canvas id="threeJSCanvas"></canvas>` element.

You want to run and setup your Three js once the canvas has loaded fully.
For that we use `useEffect()`

```JS
import * as THREE from 'three'

useEffect(() => {
    //1. setup scene
    const scene = new THREE.Scene();

    //2. setup camera
    const camera = new THREE.PerspectiveCamera(
        50,
        window.innerWidth/window,innerHeight,
        1,
        1000
    )
    camera.position.z = 96;

    //3. initialise Renderer
    const canvas = document.getElementByID('myThreeJSCanvas');
    const renderer = new THREE.WEBGLRenderer({
        canvas,
        antialias:true,
    })
    renderer.setSize(window.innerWidth,window.innerHeight);
    document.body.appendChild(renderer.domElement);
    //4. Lighting - color, intensity
    const ambientLight = new THREE.AmbientLight(0xfffffdf,0.5);
    ambientLight.castShadow = true;
    scene.add(ambientLight);

    const spotLight = new Three.SpotLight(0xffffff,1);
    spotLight.castShadow = true;
    spotLight.position.set(0,64,32);
    scene.add(spotLight);


    //5. Animation
    const animate = () => {
        //Run this every frame
        renderer.render(scene,camera);
        window.requestAnimationFrame(animate);
    };
    animate();
}
```

# Add basic cube
```JS
...
const boxGeo = new THREE.BoxGeometry(16,16,16);
const boxMaterial = new THREE.MeshNormalMaterial();
const boxMesh = new THREE.Mesh(boxGeometry,boxMaterial);
scene.add(boxMesh);
```
# Animate Shape
```JS
const animate = () => {
    boxMesh.rotation.x += 0.01;
    boxMesh.rotation.y += 0.01;

}
```
# Orbit control 
```JS
import {OrbitControls} from 'three/examples/jsm/controls/OrbitControls';
...
const controls = new OrbitControls(camera,renderer.domElement);

...
const animate = () => {
    controls.update();
}
```
# Stats
```JS
import Stats from 'three/examples/jsm/libs/stats.module'

...
const stats = Stats();
document.body.appendChild(stats.dom);


const animate = () => {
    stats.update()
}
```

# Refactor Code into Class 


# Resize canvas when window size changes
`window.addEventListener('resize', ()=> onWindowResize(),false)`