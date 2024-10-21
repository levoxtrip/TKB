---
comments: true
tags:
 - TD/COMP
 - TD/Slider
 - TD/Scripting
 - TouchDesigner
---
![Set Value of Slider via a Noise and CHOPExecuteDAT](./img/SetValueSliderScript.png)
# Set Value of Slider via Script

Sometimes you want to overwrite the values of a slider via script for example when you want to reset it to a specific value when another `executeDAT` gets triggered.

For that we can use `op('slider1').panel.u.val = 0.5`
