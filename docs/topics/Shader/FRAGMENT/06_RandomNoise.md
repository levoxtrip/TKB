---
comments: true
tags:
  - Shader/Fragment
  - GLSL
  - Math
---

# Random


## One dimensional random

We can create pseudo random numbers in GLSL by taking the `fract()` part of a `sin()` value and then scale it with a big number.

<iframe height="300" style="width: 100%;" scrolling="no" title="RandomNumber" src="https://codepen.io/levoxtrip/embed/jEOjOZQ?default-tab=html%2Cresult" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/levoxtrip/pen/jEOjOZQ">
  RandomNumber</a> by levoxtrip (<a href="https://codepen.io/levoxtrip">@levoxtrip</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>
<iframe height="300" style="width: 100%;" scrolling="no" title="RandomNumber" src="https://graphtoy.com/?f1(x,t)=frac(sin(x)*10000)&v1=true&f2(x,t)=&v2=true&f3(x,t)=&v3=true&f4(x,t)=&v4=true&f5(x,t)=&v5=false&f6(x,t)=&v6=true&grid=1&coords=-0.03474786109655306,0.31273074986897753,2.6115496294817864" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
</iframe>


We can manipulate the distribution of the random values by
- multiplying it with itself
```GLSL
float ran = fract(sin(uv.x)*10000.);

//Values lie more towards y = 0 
float y2 = ran *ran;

//Values lie more towards y = 1
float y3 = sqrt(ran);
```
```glsl

float random(vec2 st){
return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123);
}

void main(){
vec2 st = gl_FragCoord.xy/u_resolution.xy;

float c = random(st);

gl_FragColor = vec4(vec3(c),1.0);
}
```
We also can add a seed value to the random
```glsl
float random(vec2 st, float seed){
	const float a = 12.9898;
	cosnt float b = 78.233;
	const float c = 43758.543123;
	return fract(sin(dot(st,vec2(a,b))+seed)*c);
```

## Two dimensional random
To distribute random values over two dimension we have to convert a two dimensional vector of for example the pixel position into a one dimensional value. We can use the `dot()` function for that. 
The `dot()` function returns float number between 0.0 and 1.0, depending on how  two vectors that build the skalar product are positioned to each other.

<iframe height="300" style="width: 100%;" scrolling="no" title="2D Random" src="https://codepen.io/levoxtrip/embed/gbONOqe?default-tab=html%2Cresult" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/levoxtrip/pen/gbONOqe">
  2D Random</a> by levoxtrip (<a href="https://codepen.io/levoxtrip">@levoxtrip</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>


We can use random to draw different shapes or colors for each tile in a grid canvas.
```glsl
float random(vec2 st){
  return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.545312);
}

void main(){
  vec2 st = gl_FragCoord.xy /u_resolution.xy;
  //scale up the canvas
  st*=10.0;
  vec2 ipos = floor(st);//int values of scaled canvas
  vec2 fpos = fract(st);//decimal values of scaled canvas

  vec3 c = vec3(random(ipos));
  vec3 c1 = vec3(random(fpos));
  gl_FragColor = vec4(ipos,fpos,0.0,1.0);

}
```

<iframe height="300" style="width: 100%;" scrolling="no" title="RandomGridTiles" src="https://codepen.io/levoxtrip/embed/PwwYVmV?default-tab=html" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/levoxtrip/pen/PwwYVmV">
  RandomGridTiles</a> by levoxtrip (<a href="https://codepen.io/levoxtrip">@levoxtrip</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>

By isolating the integer part of the coordinates we get the same value for all the Pixels that lie inside a grid tile.
We then use this value to create the random value for the whole tile.

The `fpos` allows us then to position what we want to draw properly.

This allows use to create even more sophisticated pattern and grids.

<iframe height="300" style="width: 100%;" scrolling="no" title="GLSL - TruchetTiles" src="https://codepen.io/levoxtrip/embed/XJJrOxa?default-tab=html" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/levoxtrip/pen/XJJrOxa">
  GLSL - TruchetTiles</a> by levoxtrip (<a href="https://codepen.io/levoxtrip">@levoxtrip</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>


## Random Series Generator
We can use the `random()` function to create a random series that defines if something gets shown or not

```glsl
float random(float x){
  return fract(sin(x)*1e4);
}

float random(vec2 uv){
  return fract(sin(dot(uv,vec2(12.9898,78.233)))*43758.5453123);
}

float ranSerie(float x,float freq,float time){
  //This creates series of random binary(0-1) values that changes depending on space and time
  float divXSegments = floor(x*freq);
  float timeChanges = floor(t);
  return step(0.8,random(divXSegments-timeChanges));
}

void main(){
  vec2 uv = gl_FragCoord.xy/u_resolution.xy;
  uv.x *= u_resolution.x/u_resolution.y;

  vec3 color = vec3(0.0);
  float cols = 3.0;
  float freq = random(floor(u_time))+abs(atan(u_time)*0.1);
  float t = 60.+u_time*(1.0-freq)*30.0;

  //create different frequencies for each band
  if(fract(uv.y*cols*0.5) <0.5){
    t*= -3.0;
  }
  freq += random(floor(uv.y));

  //color + offset
  float offset = 0.025;
  color = vec3(randomSerie(uv.x,freq*100.0,t+offset),
          randomSerie(uv.x,freq*100.0,t),
          randomSerie(uv.x,freq*100.0,t-offset));
  gl_FragColor = vec4(1.0 - color,1.0);
}
```

<iframe height="300" style="width: 100%;" scrolling="no" title="RandomSerie" src="https://codepen.io/levoxtrip/embed/ZYYBpyg?default-tab=html%2Cresult" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/levoxtrip/pen/ZYYBpyg">
  RandomSerie</a> by levoxtrip (<a href="https://codepen.io/levoxtrip">@levoxtrip</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>


https://thebookofshaders.com/edit.php#10/ikeda-03.frag
https://thebookofshaders.com/edit.php#10/ikeda-04.frag

# Noise



















Perlin noise collection
https://gist.github.com/patriciogonzalezvivo/670c22f3966e662d2f83