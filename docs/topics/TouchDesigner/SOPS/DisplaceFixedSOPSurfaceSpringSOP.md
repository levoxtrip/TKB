---
comments: true
tags:
 - TD/SOP
 - TD/Noise
 - TD/Displace
 - TouchDesigner

---

![Displace SOP Only in XY](./img/DisplaceFixedSOPSurfaceSpringSOP1.png)
# Displace fixed SOP Surface with SpringSOP
When you want to deform the interior points of a SOP while maintaining the position of its outer edges, we can use GroupSOP and SpringSOP.
Here's a step-by-step approach:

- Create a Point Group
Use the `GroupSOP` to collect the points you want to fix. Set the `Group Entity` to *points*.

- Select Interior Points
Use a *bounding box* to select all points except those on the outer edge of the shape.

- Invert the Group
In the *Combine* category, invert the group by setting `NOT` and assigning a new name like "dontmove".

- Apply Fixed Points in SpringSOP
In the SpringSOP, navigate to the Nodes category and set the newly created group for the `Set Fixed Points` parameter.
![Displace SOP Only in XY](./img/DisplaceFixedSOPSurfaceSpringSOP2.png)

This technique allows you to create controlled deformations while preserving the original boundary of your surface, giving you precise control over geometric transformations.

[Download](./files/DisplaceFixedSOPSurfaceSpringSOP.tox)    

