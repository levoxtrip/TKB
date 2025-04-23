---
comments: true
tags:
 - TD/CHOPS
 - TD/SOP
 - TouchDesigner
---

![Infinite Looping Noise Channel](./img/InfiniteLoopingNoiseChannel.png)
# Create Infinite Looping Noise Channel With SOP
To create a noise channel that infinitely loops and has smooth transitions we can displace a `circleSOP` with a `noiseSOP` and then convert it into *Channel* data.


[Download](./files/InfiniteLoopNoiseChannel.tox)