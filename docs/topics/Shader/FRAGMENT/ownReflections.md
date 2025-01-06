# Own reflections
Multiplying a color with a value makes the color brighter or darker.

Adding a color with a value makes the color brighter.

Subtracting a color with a value makes the color darker.

`fract(u_time)` gives back a values that moves from 0.0 -> 1.0 and starts again at 0.0

## Mirror effect
If you move the `uv` by `0.5` into the center and then use `abs()` you can create a kaleido/mirror effect.
```glsl
vec2 uv = gl_FragCoord.xy/u_resolution;
uv -= vec2(0.5);
uv = abs(uv)
```