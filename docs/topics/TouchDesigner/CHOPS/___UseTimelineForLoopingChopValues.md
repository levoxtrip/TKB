---
comments: true
tags:
 - TD/CHOPS
 - TouchDesigner
---

![Animate Through Data](./img/AnimateThroughData0.png)

# Use Timeline for looping Chopvalues

If you want to output for example looping behaviour that has the length of your timeline we can use the `TimelineCHOP` divide the `frame` by the `endframe` to normalise the value. This 
gives us a value that goes from 0 -> 1.0 from timeline start to timeline end. 


[DownloadFile](./files/TimelineLoopingValues.tox)