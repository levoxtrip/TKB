---
comments: true
tags:
 - TD/TOPS
 - TD/Camera
 - TD/3D
---

![Change Values Locked TOP](./img/AccesCameraDepth.png)

# Access Depth Information from a 3D camera in TOP

To create a focus effect where closer parts of the scene appear sharper and more distant parts are blurred, you can use the `DepthTOP` in combination with a `LumaBlurTOP`.
For the settings in the `DepthTOP` set *Pixel Format* `8-bit fixed texture` , *Depth Space* `Rearrange From Cam Space` and then play with the *Range to* value.

![Settings in DepthTOP](./img/AccesCameraDepth1.png

[DownloadFile](./files/AccessCameraDepthTOP.tox)