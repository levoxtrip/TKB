---
comments: true
tags:
 - TD/SCRIPTING
 - TouchDesigner
 

---

# Join Values In F-String
If we want to use the data from different operators and want to join them in a string we can use *f-strings*.

```py
def onValueChange(channel, sampleIndex, val, prev):
	clock = op('clock2')
	# Get data from clock
    sek = int(clock[0])
	min = int(clock[1])
	hr = int(clock[2])
	day = int(clock[3])
	month = int(clock[4])

    # construct date
	date = f'25-{month}-{day}-{hr}:{min}:{sek}'
```