---
comments: true
tags:
  - TD/CHOPS
  - TouchDesigner
---

![AudioInputScalingValue](./img/AudioInputIntoScalingValue.png)

# Audio Input into scaling value

If you want to convert a Audio Input into a value to scale objects or certain elements
we can connect `AudioFileInputCHOP` with `ResampleCHOP` and then you probably want
to add a `LagCHOP` to make it smoother.

[Download File](./files/ConvertAudioInputScalingValue.tox)
