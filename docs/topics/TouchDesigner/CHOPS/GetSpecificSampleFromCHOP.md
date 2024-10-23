---
comments: true
tags:
 - TD/CHOP
 - TouchDesigner
---
![Get sample 30 from noise](./img/GetSpecificSampleFromCHOP.png)
# Get specific Sample from Chop

Sometimes we want to acces a specific sample/point from a chop. With scripting we can access it by referencing the index of the channel `[0]` and the index of the sample `[30]`.

`op('noise1')[0][30]`

