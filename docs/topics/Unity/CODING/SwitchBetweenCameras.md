---
comments: true
tags:
 - Unity/Coding
 - Unity
---

# Switch Between Cameras
```c#
public Camera camera1;
public Camera camera2;

if(Input.GetKeyDown(KeyCode.C)){
//Swap enabled state between Cameras
camera1.enabled = !camera1.enabled;
camera2.enabled = !camera2.enabled;
}
```
