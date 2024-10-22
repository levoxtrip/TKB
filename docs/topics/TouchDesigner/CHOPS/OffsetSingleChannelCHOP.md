---
comments: true
tags:
 - TD/CHOPS
 - TouchDesigner
---

![Offsetting Channel by specific value](./img/OffsetSingleChannelCHOP.png)
# Offset a Single Channel in CHOP
When we have a chop that has multiple channels we can use `me.chanIndex` to offset the single channels by a specific value.

It is getting even more interesting when you multiply the single channels by another chop value. It is important to add 1 to `me.chanIndex` so the first channel is not always equals 0.

[Download](./files/OffsetSingleChannel.tox)    