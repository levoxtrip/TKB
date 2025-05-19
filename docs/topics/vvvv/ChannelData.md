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


## Calculate Distance between Points
If you want to calculate the *distance* of for example two Vector2 values you can use a `Distance` node.
![Calculate Distance Points](./img/CalculateDistancePoints.png)


## Smooth interpolation between random values
![Smooth Transition BetweenRandom Values](./img/SmoothTransitionBetweenRandomValues.png)

## Smother Values with Filter
The `Filter` node allows us to create smoother values.

## OneEuroFilter
A good filter is `OneEuroFilter`

## Filter Values
We can use a `Pow` To filter the values.

## Count
VVVV has multiple counter to count a value up and down. They are different in the way how they behave if the *Minimum* and *Maximum* values got reached.

`Counter` - Counts endless up and down

`CounterWrap` - Jumps back to *Minimum* value when *Maximimum* reched and other way around.
`CounterMirror` - When Edges reached the count direction get's inversed - Endless counting between edges.
`CounterClamp` - Stops counting at edge values. 
`CounterFlop` - Returns true if specified number of bangs is detected in time interval.

`Counter` often can create something similar to a `Pad` where on every event the value gets added or subtracted. Here the counter holds the position of the rectangle similar to a `Pad`

![Counter holds position](./img/CounterHoldsPosition.png)

## Limit ascending value with modulo 
We can use a `MOD` to create *modulo* behavior and limiting an increasing value into a range.
![Ascending Value Modulo](./img/AscendingValueModulo.png)

## Delaying data stream by frame
The `FrameDelay` allows to give the input a delay of one frame.

## Map Data

### Convert one range into another
![alt text](./img/ConvertOneRangeIntoAnother.png)
The `Map(Range)` nodes allows us to convert from one range into another.

### Define range by center and width
The `Range(Join Center Width)` allows us to *create a range* by a *center* and *width* values.

## Evaluate value difference between frames
The `FrameDifference` node allows us to see how much the data has changed between this and the last frame.