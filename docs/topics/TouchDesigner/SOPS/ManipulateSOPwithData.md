---
comments: true
tags:
 - TD/SOP
 - TD/DAT
 - TD/Displace
 - TouchDesigner

---

![Manipulate SOP with Data](./img/ManipulateSOPWithData.png)
# Manipulate SOP with Data

We can use Table Data to dynamically modify manipulate the Shape of a SOP. The basic idea is to convert the SOP into tabular data, manipulate that data and then converting it back into SOP.
For that you convert the `SOP` with `SOP to` into data. To manipulate the data we use an `evaluateDAT` and in the expression DAT we reference a table with the displace values. An idea is to take the already existing data from the sop and *add* displacement value from a "displaceTable".
```
me.inputCell me.inputCell ...
me.inputCell me.inputCell + op('displaceTable')[me.inputRow,0]
```
Then convert the data back into SOP.


[Download](./files/ManipulateSOPwithDATA.tox)    

