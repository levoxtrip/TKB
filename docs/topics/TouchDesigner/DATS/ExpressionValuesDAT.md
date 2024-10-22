---
comments: true
tags:
 - TD/DAT
 - TD/TableDAT
 - TD/Evaluate
 - TouchDesigner
---
![ExecuteDAT when new selection from table](./img/ApplyExpressionToDAT.png)
# Apply Expression to all DAT Values

If you want to manipulate your data you can use an `evaluateDAT` and then use an expression to manipulate that data.

Here we apply the modulo to the input value with `me.inputCell % 2`. This defines if input value is even or not.
