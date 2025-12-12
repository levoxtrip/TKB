---
comments: true
tags:
 - TD/SCRIPTING
 - TD/UI
 - TouchDesigner
---

# Scripting Cheatsheet

Get width and height from parent
`me.parent().par.w` - width
`me.parent().par.h` - height

Get width/ height of child operator
`op('/out1').width`
`op('/out1').height`

Operator index
`me.digits`

# Channels
Referencing Channels
`op('constant1')[0]` <- First channel 
`op('constant1').chan(0)` <- First channel
`op('constant1')['channelName']`
`op('constant').chan(0).name` - Channelname

# Tables

Get value from input cell
`me.inputCell`

# Inputs
Count inputs of operator
`len(op('switch1').inputs)`

# Manipulate data

Round values `round(val,2)`

Test if value is even or not `val%2`


https://interactiveimmersive.io/blog/python/python-cheat-sheet-for-touchdesigner-developers/
