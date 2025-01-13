---
comments: true
tags:
 - n8n
 - n8n/Function

---
# Aggregate
The aggregate node combines data from all of the items of the previous output. So it helps dealing with multiple items.

For example you collect the email adresse from multiple input items and collect them in one item in a new key:value pair `"email"`.

Aggregate - `Individual Fields`
Field To Aggregate - Input Field Name `email`

To break out one key of an item in to multiple items we can use [Split Out](SplitOutNode.md).