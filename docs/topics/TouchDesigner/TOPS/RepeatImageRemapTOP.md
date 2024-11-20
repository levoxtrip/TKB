---
comments: true
tags:
 - TD/TOPS
 - TouchDesigner
---

![Set Text From TableDAT](./img/PatternWithRemapTOP.png)

# Repeat Image via RemapTOP

We can use a combination of `reorderTOP` and `remapTOP` to create a pattern from a single image input.

The `reorderTOP` allows us to assign input textures or ramps to the color channels (e.g., red, green, blue, and alpha). In this case, the red channel (R) is used to define the X UV coordinates, and the green channel (G) is used for the Y UV coordinates. The blue channel is set to zero.

The `remapTOP` then uses these UV values to reposition the pixels of the original image, effectively mapping the image according to the provided UV pattern.

For example, by connecting a `rampTOP` as the input to the `reorderTOP`, you can control the UV mapping. Adjusting the `rampTOP`'s *period* parameter determines how many repetitions of the image appear along each axis.

This method offers a flexible way to tile or distort an image based on custom UV coordinates.

[DownloadFile](./files/RemapImageWithTOP.tox)
