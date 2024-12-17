---
comments: true
tags:
 - TD/SOP
 - TD/GroupSOP
 - TD/Displace
 - TouchDesigner

---

![Displace SOP Only in XY](./img/DisplaceSOPOnlyXY.png)
# Displace SOP Only in XY directions

When we apply a `noiseSOP` to a Shape the `noiseSOP` displaces the vertex of the shape in the X,Y and Z direction.
In some cases we just want to displace the Vertex Points for example only in the XY direction. To achieve that we 
can convert the SOP into a CHOP and then reassign the channels of the SOP in the `chopToSop` to the Normals `N`.


[Download](./files/DisplaceSOPOnlyInXYNoise.tox)    

