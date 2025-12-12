---
comments: true
tags:
 - TD/DAT
 - TD/SCRIPTING
 - TouchDesigner
 

---

# Combine String To Operator Name
When we want to set values for multiple instances of the same operator type and we want to combine the operator names with variables and strings there are multiple ways to achieve this.

One is
```py
for i in range(1,6):
    op('button'+str(i)).par.x = op('table1')['button'+str(i),'posX']
    op('button'+str(i)).par.y = op('table1')['button'+str(i),'posY']
```
