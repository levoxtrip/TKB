---
comments: true
tags:
 - TD/SOP
 - TouchDesigner

---

![BoolSOP allows to create different Shapes](./img/CreatingCutoutBoolSop.png)
# Creating Cutout Shapes with BoolSOP
When we want to create Cutout Shapes in TouchDesigner we can use a `BoolSOP` to decide how the input Shapes get combined. 
We have multiple Options for the combination of the shapes:
- `Union`: Combining two 3D objects into one
- `Intersect`: Keeping only the overlapping parts of objects
- `A minus B` : Second shapes gets cutout of teh first shape
- `B minus A`: Only the parts that aren't overlapping create the geometry
- `A/B Edge`: Where the edges of both geos greate geometry


[Download](./files/CreatingCutoutShapesBoolSOP.tox)    

