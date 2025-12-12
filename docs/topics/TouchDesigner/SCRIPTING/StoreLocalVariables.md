---
comments: true
tags:
 - TD/SCRIPTING
 - TouchDesigner
---

# Store Local Variables
We can store local variables in a script with
```py
me.parent().setVar('Height',720)
me.parent().setVar('Width',720)
me.parent().setVar('VariableName',20)
```
inside a `textDAT` for example.

If we then right click the `textDAT` and click `Run Script` we get a *local* `Base` with the variables.

If we then want to reference the variables in an operator we can use `me.var('VariableName')`

If we want even more flexible variables like when we want to store the `SliderCOMP` and then get it's variable.