---
comments: true
tags:
 - TD/CHOP
 - TD/Samples
 - Conversion
 - TouchDesigner
---

![Map the CHOP Values to new Range](./img/MapCHOPValuesNewInterval.png)
# Map CHOP Values to New Intervall

In many cases you want to remap the range of the chop. For example if you want to reduce the amount of samples from an audiofile to a specific number so you can use it for instancing you can map the Chop values with a `resampleCHOP`. First you need to `Deactivate Time Slice` in the *Common* tab. Then you set *method* `new Rate, new Interval`, *Unit Values* `Absolute`. Then you can set the *End* parameter to the amount of samples you want. Don't forget to set `Samples` as the parameter measure.
