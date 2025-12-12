---
comments: true
tags:
 - TD/UI
 - TD/DAT
 - TD/SCRIPTING

---

![Set UI Position Via Script Img](../img/SetUIPositionViaScript.png)

# Set UI Position Via Script
We can use a `TableDAT` to store the positions of the UI elements and combine it with `DATExecute` which acts `onTableChange`. So every time the values in the table get changed the UI elements get set to the new position.

```py
def onTableChange(dat):

	for i in range(1, 7):
		op('button' +str(i)).par.x = op('table1')['button' +str(i),'posX']
		op('button' +str(i)).par.y = op('table1')['button' +str(i),'posY']
	return
```

[Download Example File](../files/SetUIViaScript.tox)