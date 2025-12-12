---
comments: true
tags:
 - TD/TOPS
 - TD/SCRIPTING
 - TouchDesigner

---

# Get Current Value Of Parameter, Channel, Expression
To get current values of *parameter*,*channel* or *expressions* we can use `.eval()` after the reference to the parameter and operator.

`op('noise1')['chan1'].eval()` - evaluate channel at current frame.
`op('noise1')['chan3'].eval(5)` - get sample 5 of channel 3
