---
comments: true
tags:
 - TD/DAT
 - TD/TableDAT
 - TD/CHOP
 - TouchDesigner
---
![Conversion TableDAT Into CHOP Graph](./img/ConvertingDATIntoGraph.png)
# Converting DAT into CHOP Graph

Often we want to convert table data into a graph which makes the data more accessible or to convert it to visuals. 

Basic idea is we convert the `null1` with `datto` into a CHOP.
In the `dattoCHOP` we select if the first row of the data is already a value or the name of the data channel. 
As the output we set `Single Channel`.


[Download](./files/ConvertingDATIntoGraph.tox)    