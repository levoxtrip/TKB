---
comments: true
tags:
 - TD/DAT
 - TD/Storage
 - Scripting
 - Python
 - TouchDesigner
---
![Get all values of CHOP as List](./img/SetVariablesOperator.png)
# Set Variables in OPs

This is an older approach but can be useful if you working with older files or someone gives you a non updated file.

We set the variables with `setVar()`
```py
me.parent().setVar('Height',720)

me.parent().setVar('Width',1280)
```
With `me.var('Height') can we retrieve the value from the variable.



[Download](./files/SetVariableOperator.tox)  
