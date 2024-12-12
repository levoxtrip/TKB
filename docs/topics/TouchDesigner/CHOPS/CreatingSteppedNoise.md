---
comments: true
tags:
 - TD/CHOPS
 - TD/NOISES
 - TD/BEAT
 - TouchDesigner
---

![Creating Stepped Noise](./img/HoldLastChangedValue.png)
# Creating Stepped Noise
If we want to create a noise, that is stepped, so it holds its value for a period of time and then on a trigger changes to a new noise value 
we can pulse a `constantCHOP` with for example a `beatCHOP`. The `constantCHOP` will hold the value till the next time the *Snap* parameter gets pulsed. 
A `filterCHOP` lets us manipulate the transition between the pulses.

[Download](./files/SteppedNoise.tox)    