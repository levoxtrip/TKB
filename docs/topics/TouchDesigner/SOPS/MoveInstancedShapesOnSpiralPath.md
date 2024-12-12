---
comments: true
tags:
 - TD/SOP
 - TD/CHOP
 - TD/Instancing
 - TouchDesigner

---

![Using Pattern CHOPs to create moving path](./img/MoveInstancedShapesOnSpiralPath.png)
# Move Instanced Shapes on Spiral Path with CHOPs

To move instanced shapes on a spiral path we can use three `PatternCHOP` one for each position value. 
With *sine* and *cosine* for the `tx`and `ty` or `tz` values we can create a two dimensional circular shape. By adding a `PatternCHOP` with Type `Ramp` for the 3rd dimension we can stretch it out into a spiral path.

Changing the `amplitude` of the *sine* and *cosine* `PatternCHOP` we can change the *diameter* of the spiral. 
The `Number of Circles` defines the *frequency* / the amount of rounds.

[Download](./files/MoveInstancesOnSpiralShape.tox)    
