---
comments: true
tags:
  - VVVV
  - Skia
  - 2D
---
# Runtime

VVVV allows us to run different operations in the runtime of the program.
It has the build in operations `Create` and `Update`.

The `Update` operation is the runtime of the patch - it is continuously evaluating and executing the nodes assigned to the `Update` operation. The nodes are by default assigned to the `Update` operation.

![Update Operation](./img/UpdateOperation.png)

The `Create` operation only runs once, when the patch get's initialized. It is useful to setup the values for the start of the patch or to provide default values for pads. We can also have complete calculations assigned and executed in `Create`. The `Create` operation has white links.
![Create Default Value](./img/CreateDefaultValue.png)

With *right click* on a link we can assign the operations to nodes and links.

We also can take advantage of `Create` and `Update` in [Process Nodes](OOP.md#process-node)


## Controlling the Runtime

VVVV has the *Quad Menu* at the top left corner where you can control the runtime of the patch
`Run` - F5
`Step` - F6
`Pause` - F7
`Stop` - F8
`Restart` - F9

So every time the runtime is started, all patches that are open will call `Create`.