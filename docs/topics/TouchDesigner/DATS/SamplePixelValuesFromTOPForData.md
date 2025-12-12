---
comments: true
tags:
 - TD/DAT
 - TD/SCRIPTING

---

![Sample Pixel Values From TOP For Data](../img/ConvertTableDataIntoCHOP.png)

# Sample Pixel Values From TOP to Create Data
We can use an `EvaluateDAT` to sample the pixel values from a TOP. In the `Expressions` Table we define which pixel we sample `op('noise1').sample(x=1,y=me.inputRow)`

[Download Example File](../files/SamplePixelValuesFromTOPForData.tox)