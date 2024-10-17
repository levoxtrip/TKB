---
comments: true
tags:
 - TouchDesigner
 - TD/Scripting
 - Python
---
# Python in Touch
Here is a collection of python commands that can be util learning and applying: 

`#` comment text out

## Variables

``` py
//Basic variables
var1 = 10.0
var2 = 20
var3 = "String"

//Converting Variables
str(var1) // float into string
```

## Grab values from operator

``` py
op('opname')['nameChannel']
op('opname')[0]

//Always useful to assign operator to variable
op = op('lfo1')

```

## Conditions
``` py
if var1 >=0:
    # Do something
else:
    # Do something else


if var1 == 0 && var3 < 3:
```

## Loops
For-Loop

``` py
for x in range(0,10):
    print(x)
``` 

While loop

!!! Python will stop touchdesigner while the while loop runs.
``` py
while var <=0:
    print(x)
``` 

## Access Parameter
``` py
op = op('lfo1')
op.par.parameterName
``` 

