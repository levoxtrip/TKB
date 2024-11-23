---
comments: true
tags:
 - TD/DAT
 - TD/TableDAT
 - TD/Execute
 - TouchDesigner
---
![Replace Values of Row with MergeDAT](./img/ReplaceSpecifValueTable.png)
# Replace Specific Data in Table with MergeDAT

To replace specific values in a `TableDAT`, you can use a `MergeDAT` to efficiently swap data. By selecting the *Replace Cells by Column* option, you can replace values in the original `TableDAT` with those from a secondary `TableDAT`. The same method can be applied to replace data by row.

Important Note: Ensure that the headers (typically in the first row) of both TableDATs match exactly, as the merge process relies on these headers to align the data correctly.


[Download](./files/ReplaceValuesTableMergeDAT.tox)    