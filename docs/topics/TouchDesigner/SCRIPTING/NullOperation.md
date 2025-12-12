---
comments: true
tags:
 - TD/DATS
 - TD/SCRIPTING
 - TouchDesigner
 - Python
 

---

![Null Operation](../img/NullOperation.png)

# Null Operation
If you want to have a *null operation* so nothing happens when a certain case is met we can use `pass`

```py
def onValueChange(channel, sampleIndex, val, prev):
	if val < 0.8:
		pass
	else:
		op('constant1').par.value0 = val
	return
	
```
