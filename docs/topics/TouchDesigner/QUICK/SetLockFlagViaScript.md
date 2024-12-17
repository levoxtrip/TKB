---
comments: true
tags:
 - TD/QuickTips
 - TD/UI
 - TD/COMP
---

![Set Lock Flag viaScript](./img/SetLockFlagViaSCript.png)

# Set Lock Flag via Script

We can set the Lock Flag of an Operator with a script. This script is alternating the the lock variable between true and false every time the `beatCHOP` pulses.
```py
lock = False
def onOffToOn(channel, sampleIndex, val, prev):
	global lock
	lock = not lock
	myop = op('null2')
	myop.lock = lock
	return

```

[Download](./files/LockFlag.tox)