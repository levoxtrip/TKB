---
comments: true
tags:
 - TD/SOPS
 - TD/CHOPS
 - TD/INTERACTIVE
 - TouchDesigner

---

![Delete Copied Group Img1](../img/DisplaceCopiedLineSOPbyForce.png)

# Displace Copied LineSOP by Force
If we want to copied `LineSOP` to be affected by forces we can use the output of the `CopySOP` as the *Spring Source* of the `SpringSOP`. We then use a `SphereSOP` in combination with `MetaballSOP` and `ForceSOP` to create a force-source. In the `ForceSOP` we have to define what kind of force it should be. 

If we want that some points are fixed we create a group with the `GroupSOP` to define which the fixed points gonna be. We then reference in the `SpringSOP` in the *Nodes tab* set `Fixed Points Group` the previously created group.

[Download Example File](../files/DisplaceCopiedLinesSOPForce.tox)