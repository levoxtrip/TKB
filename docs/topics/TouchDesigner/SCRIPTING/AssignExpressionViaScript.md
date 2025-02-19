---
comments: true
tags:
 - TD/CHOP
 - Scripting
 - TD/DAT
 - TD/Conversion
 - Python
 - TouchDesigner
---
# Assign an Expression via Script

When you want to assign an expression to a parameter via script you can use the `.expr` extention.
`op(...).par.color.expr = 'absTime.seconds%255'`
