---
comments: true
tags:
  - VVVV
---

# Model
*Model* is a term in VL for the central place where you have all your information of your app.
It serves to handle the state of your program.
We then feed the handle to different parts of the program.

*Controller* patch can change the state.
*View* patch visualizes the state of the program.

## Immutable model
An *Immutable model* can't change. 
A *immutable structure* when it can't change, then it is like a snapshot.
You can jump between different snapshots or lerp between between them. You can detect changes.

When you see in the tool tip a *filled* clock it means that we get new snapshots over time - the reference is changing all the  time.
When it's not filled it is the same instance all the time - the reference stays the same.