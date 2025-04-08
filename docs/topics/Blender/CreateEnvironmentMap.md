---
comments: true
tags:
  - Blender
---

# Create Environment map in Blender

For more realistic map we should render in cycles.
In `Render Properties` set `Max Samples` to 256 for `Viewport` and `Render`

In `World Properties` you can set the `Surface` color to black if needed.

In `Output Properties` under `Format` set the Resolution to a power of two like `2048x1024`

Add a camera, set `x rotation` to 90° and under `Object Data Properties` set Type to `Panoramic` and the `Panorama Type` to `Equirectangular`

Check that in the `Object Properties` the `Camera` is checked under the `Visibility` section.

Then render with `F12`
Then save the render with `alt+s` and set `Radiance HDR` as the file format.
