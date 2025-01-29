---
comments: true
tags:
  - JavaScript
  - HydraSynth
  - LiveCoding
---
# Loading Hydra Extention

```
await loadScript('https://hyper-hydra.glitch.me/hydra-glsl.js')
glsl('vec4(sin(((_st.x*54.)+time*2.)*vec3(0.1,0.102,0.101)),1.0)')
  	.diff(o0)
// 	.glslColor('vec4(c0.brg,1.)')
// 	.glslCoord('xy*=(1.0/vec2(i0, i0)); return xy',.25)
	.glslCombine('return c0-c1',o1)
	.glslCombineCoord('uv+(vec2(c0.r,c0.b)*0.1)',o1)
  .out()

noise(3)
	.out(o1)

```
https://github.com/ritchse/hydra-extensions/blob/main/doc/hydra-glsl.md