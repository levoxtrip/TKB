---
comments: true
tags:
  - VVVV
  - VVVV/Data
---
# Channel Data
Here is a collection of information about channel data

## Create value always ascending value
`Stopwatch` creates a global runtime value of the passed time.

We also can use `Playhead` which also allows to loop to value at a certain range.

The `Integrator` node let's us create something similar but we can decide how much we want to add every frame.

![PlayHeadIntegrator](./img/PlayHeadAndIntegrator.png)

## Create ascending values from 1 to one
`LFO` node lets us create ascending values from zero to one. *Period* defines how much time it takes to go from zero to one.

## Create Sin Wave values
To create a value that moves along a sine wave we use the `SinWave` node and plug a `LFO` node into it.

## Create SawTooth values
 `SawToothWave` node

## Mirror negative values to positive
The `abs` node allows us to map negative values to the *absolute* of the value.