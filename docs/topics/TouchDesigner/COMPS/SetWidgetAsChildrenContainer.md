---
comments: true
tags:
 - TD/COMP
 - TD/UI
 - TouchDesigner
---

![alt text](./img/SetWidgedChildContainer.png)
# Set Widget as Child of Container
If you want to group widgets and UI elements in container there are two ways how you can make them a child of a container.
You can put the elements *inside* the `Container` or you drag a connection from the upper docker of the UI elements into the bottom docker of the parent.
In the `children` tab of the `Container` you can set `Align` to decide their order in the parent.

Another way to change the order of the child elements is to set each `Align order` parameter to the oder index of each child. 
```
First order element -> 0
Second order element -> 1
...
```