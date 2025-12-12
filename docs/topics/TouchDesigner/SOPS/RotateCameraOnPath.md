---
comments: true
tags:
 - TD/SOPS
 - TD/CHOPS
 - TD/INTERACTIVE
 - TouchDesigner

---

![Delete Copied Group Img1](../img/RotateCameraOnPath.png)

# Rotate Camera On Path
If we want that the camera rotates around the geometry and always looks at it we can assign a `PathSOP` to the `Pathsop` parameter of the camera and also let the camera `LookAt` a `NullComp`. Set the `translatex` of the camera to 0 and scale down the geometry so it fits the view of the camera.

[Download Example File](../files/RotateCameraOnPath.tox)