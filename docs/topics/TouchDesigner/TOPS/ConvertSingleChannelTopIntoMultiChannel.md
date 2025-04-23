---
comments: true
tags:
 - TD/TOPS
 - TD/CHOPS
---
![alt text](./img/ConvertSingleChannelTopToMultiple.png)


# Convert Single Channel TOP into RGBA TOP

When we convert a `NoiseCHOP` into a `TOP` we just get a mono image. To convert it into a rgba image we can connect `chopTo` with a `constantCHOP` and set `Color` to *black*, `Output/Operation` to *Add* and set `Pixel Format` to *RGBA*.

[DownloadFile](./files/ConvertSingleChannelToMultipleChannel.tox)