---
comments: true
tags:
 - TD/TOPS
 - TouchDesigner
---

![Set Text From TableDAT](./img/SimpleMovementTracker.png)

# Simple Movement Tracker With TOPs
A simple way to track the movement in a texture we can use a `cacheTOP` to store the last frame and then compare it in a `differenceTOP` with the current texture. It shows the difference between last and this frame. If something is moving the edge of it would be visible. 

## Creative tangent
You can create interesting effects if you play around with bigger numbers than one or two in for the `Output Index` Parameter in the `cacheTOP`. 

[DownloadFile](./files/MovementTracker.tox)
