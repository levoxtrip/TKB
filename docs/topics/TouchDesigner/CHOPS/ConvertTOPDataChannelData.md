---
comments: true
tags:
 - TD/CHOP
 - TouchDesigner


---

<!-- ![Let Value Slowly Decrease](../img/LetValueSlowlyDecrease.png) -->

# Convert TOP data to Channel Data
When we want to convert an image that we have in TOP land into channel data we use a `TOPtoCHOP` and under `Crop` tab we select `Full Image`. This gives us a lot of channels. We want to group these channels together with a `ShuffleCHOP` and use the *Method* `Select Channels By Name`