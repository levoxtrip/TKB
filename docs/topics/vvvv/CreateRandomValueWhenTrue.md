---
comments: true
tags:
  - VVVV
  - VVVV/Spread
---
![alt text](./CreateRandomValueWhenTrue.md)
# Create Random Value when true
We can use a `LFO` `On New Cycle` Out put and plug it in to the `enabled` of the `Random` node to get a random value every time the lfo cycle ends.  
It is important to first set/create the *data type* you want and then connect it to the *generic* random note.

A `Filter` node allows to create a smooth transition between the random values.
