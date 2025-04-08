---
comments: true
tags:
  - TD/CHOP
  - TD/Animation
  - TouchDesigner
---

# Animate over timeline length

If you want to animate something over the length of the timeline
you take a `TimelineCHOP` and divide `rangeEnd` with `currentFrame`.
Then you get a value moving from 0 to 1.
