# Own reflections
Multiplying a color with a value makes the color brighter or darker.

Adding a color with a value makes the color brighter.

Subtracting a color with a value makes the color darker.

`fract(u_time)` gives back a values that moves from 0.0 -> 1.0 and starts again at 0.0

To specify to which value it modulates you can use
`float m = mod(u_time,.5)`.

## Mirror effect
If you move the `uv` by `0.5` into the center and then use `abs()` you can create a kaleido/mirror effect.
```glsl
vec2 uv = gl_FragCoord.xy/u_resolution;
uv -= vec2(0.5);
uv = abs(uv)
```

## Invert colors/values
If you want to invert the colors that you have you can substract your color/value from 1.0
`float invertValue = 1.0 - value`
`vec3 invColor = vec3(1.0) - color`

If you want to test if a value is smaller than a threshold value you can subtract the value from 1.0
```
val = step(0.2,0.5) returns 1.0 -> true
1.0 - val = 0 -> false

val2 = step(0.8,0.5) = 0 -> false
1.0 - val = 1 -> true
