---
comments: true
tags:
  - Unity
  - Unity/AR
  - Unity/Foto
---

# Save Screenshot in device gallery

We can create a screenshot from the screen of the device and then use the `NativeGallery` Asset
from the asset store to save the Image in the local gallery.

```C#
                    NativeGallery.SaveImageToGallery(screenShot, "MyGameName", "Foto Tour: " + FotoEmailManager.I.startTime,
(success, path) => {
    Debug.Log(success ?
        "Screenshot saved to: " + path :
        "Screenshot could not be saved");
});
```
