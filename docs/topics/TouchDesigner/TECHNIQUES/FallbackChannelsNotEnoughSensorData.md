---
comments: true
tags:
 - TD/TECHNIQUE
 - TouchDesigner
---

# Fallback Channels If Not Enough Sensor Data
When you are working with sensors and you have a situation where sometimes the sensor might not detect anything and you want to avoid that the following processing of the sensor data doesn't get an error because it hasn't any data we can create template channels with values of 0.

Take the CHOP for your sensor data and add a `MathCHOP` where yo multiply everything with 0. Then connect it into a `NullCHOP` and *lock* that null. We then connect it into the first input of a `ReplaceCHOP` and your actual data as the second input.
