---
comments: true
tags:
 - TD
 - TD/SOP
---
![Distribute Points Randomly](./img/DistributePointsRandomly.png)
# Create Point For Particle System
To make our Particle System efficient and only render a point per particle we can use an `AddSOP`, activate *Add Points* and convert the point in an `ConvertSOP` to *Particles Per Point*. 

We then can use a `LineMAT` with *Draw Lines* deactivated and *Draw Points* activated. 

![Using Points in LineMat](./img/UsingPointsInLineMat.png)