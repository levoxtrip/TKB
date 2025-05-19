---
comments: true
tags:
  - VVVV
  - VVVV/ControllingPatches
---
# Controlling Patches

# LFO
A LFO generates a continuos value which is rising from 0 to 1. 
It also outputs a *Bang* signal every time a new cycle starts and the amount of cycles it ran since it got reseted last time. We can use that signal to trigger events in our patch at cyclic intervals.

# Toggle
We can use a `LFO` and a `Toggle` node to toggle a value every time the LFO starts a new circle. The *Reset* input also allows to hold the value *false*. So we can switch the toggle on and off over the `Reset` pin.

# Sample and Hold
`S+H` node keeps the value of the input node as long as *Sample* input is true. It ignores the input values as long as the *Sample* input is false.

It is useful to hold the output of a `random` node at a specific moment.

![alt text](./img/shrandomValue.png)

# Switch
`Switch` node allows us to decide which of the inputs of the node we want to show. In the first pin we can set the *index* of the element that we want.

![alt text](./img/SwitchBetweenValuesString.png)
If the index is bigger than the amount of inputs, it starts again at the beginning. Add more inputs with *+/-*

The `Switch` node will evaluate all inputs - even when there aren't the currently selected. This can be important performance wise. Maybe consider an `if` region instead.

## Switch with LFO
A common technique to switch between two values with the same switching time is to use a `LFO` and plug it's *Cycles* output into the *index* input of the `Switch`. 

![Switch With LFO](./img/SwitchWithLFO.png)

## Switch with FlipFlop
We can switch between two values using a `FlipFlop` node as the deciding factor for which output to set. With the `FlipFlop` we can detect if ether state 1 or state 2 is true and depending on that switch between values.

# Swap
The `Swap` nodes exchanges its both inputs when the *Condition* input is set to true.

# FlipFlop
The `FlipFlop` sets out to *true* if it is *triggered on the left input* and resets it to *false* when it is *triggered on the right*.
So we can control the state of true of false with two bang inputs.


# MultiFlipFlop
The `MultiFlop` allows multiple inputs and returns the index of the triggered input. 

![MultiFlow](./img/Multiflop.png)

# If
The `if` region only get's executed when a condition is true. It also won't evaluate the nodes inside of the region while the condition is true.
So if a condition is met, it takes what is coming in and does the operation on it. If the condition not true, the data gets passed to the output without doing operation inside.

## Toggle between two values
To toggle between two values we simply set a `Toggle` node as the *index* input of a `switch` node and then plug two values into the `switch` 

# Logital primitives
`OR,AND,NOT,XOR`

# Register off to on and on to off behavior
If we want to register if a boolean value went from *off to on* or from *on to off* we can use a `TogEdge`. If the input goes from *off to on* output 1 `UpEdge* gets triggered. 
If input goes from *on to off* then `Down Edge` gets triggered.


# Change State With Two Input Bang
With a `FlipFlop` we can change a *State* by two input *Bang* signals one for *Set* and the other for *Reset*.
So `FlipFlop` stays true when it got set by the *Set* input and stays true till *Reset* get set to true.


# Detect If Value got True in certain time
`CounterFlop` allows to check if a value got *true certain times in specific time interval*
![Detect If Value got True in certain time](./img/DetectIfValueTrueInCertainTime.png)


# Only execute when Input changes
A `Cache` region allows to execute logic only when the input into the `Cache` changes.

# Trigger events

## Trigger
The `Trigger` node repeats randomly a bang signal in between the *minimal* and *maximum* interval.

## Changed
A `Changed` node let's use register if a value has changed. It shows if the value is different from the value before(from the last frame) and creates a boolean that  we then can use to trigger logic like *only if something changes the logic gets triggered*

## MonoFlop
When the `MonoFlop` get triggered it sets the output to true for a defined time.

## TogEdge
The `TodEdge` detects if there was a change from false to true or the other way around. When the input changed from *false to true* it bangs the *Up Edge* output. When the change was from *true to false* it bangs the *Down Edge*.

Especially when we want to use input devices to trigger something `TogEdge` is super useful.

## OnOpen
If you wan't to trigger some logic when you open your patch or the application you can use the `OnOpen` node.



# Send and Receive
We also can send data inside a patch with `Send`and `Receive` Nodes. They need custom channel name and a type. This works without a frame delay.