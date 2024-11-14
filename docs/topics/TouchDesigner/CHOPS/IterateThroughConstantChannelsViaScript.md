---
comments: true
tags:
 - TD/CHOPS
 - TD/Scripting
 - TouchDesigner
---

![Measure how fast the value changes](./img/IterateThroughConstantViaScript.png)

# Iterate Through Channels of ConstantCHOP via Script
If you have a `constantCHOP` with some values and at one point you want to reset them all via a Script we can use the following python code.
It iterates through all the channels and uses f-Strings to set the parameter `val0,val1,...`
``` py
def onValueChange(channel, sampleIndex, val, prev):
	n = op('constant1')
	for channel in n.chans():
		n.par[f"value{channel.index}"]=0
	return
```


[Download](./files/IterateThroughConstantViaScript.tox)