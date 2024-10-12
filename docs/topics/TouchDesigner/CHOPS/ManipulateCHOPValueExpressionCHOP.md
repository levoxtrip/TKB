---
tags:
 - TD/CHOPS
 - TD/Scripting
 - TouchDesigner

comments: true
---

![Manipulate CHOP Values with ExpressionCHOP](./img/ManipulateCHOPValueWithExpression.png)

# Manipulate CHOP Values with ExpressionCHOP

The ExpressionCHOP is a great tool to manipulate CHOP values with the power of scripting. 

Another application is to filter the input value with for example `me.inputVal > 0.5` which returns 1 when the input values is over 0.5. 
Or we test against the value of another CHOP with e.g. 
`1 if me.inputVal > op('nullThresh')[0] else 0`.
*Set value to 1 if my inputvalue is bigger than the threshold value * which could be controller by a UI element like slider. 

If we wanted to filter out for example all values below 0 we could also use the expression `me.inputVal if(me.inputVal>0.) else 0`. *So set the values of my input only when they are bigger than 0.*

This post will be continued with further explorations and functionalities!



[DownloadFile](./files/ManipulateInputWithExpressionCHOP.tox)