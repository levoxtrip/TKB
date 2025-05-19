---
comments: true
tags:
  - VVVV
  - OpenCV
  - 2D
---
# OpenCV
OpenCV only works on the CPU
In OpenCV the channel order is not RGB it is BGR.

## Inputs and Outputs
We can find all the possible inputs for OpenCV in the *Sources* folder
`CvImage`
`ImageReader`
`VideoIn`
`VideoPlayer`
`VideoSourceToCVImage`

And all the outputs in the *Sink* folder


## Filters
Filters allow us to manipulate image sources.
- `Blur` - Blur filter
- `Erode` - Washes out an image
- `ApplyColorMap` - Apply different color filters/aps.
- `Invert`
- `Transform` - Apply transformations scale, rotation, translate to image
- `GrayScale` - Three channel data into one channel data
- `LUT`- Create own color map from spread of colors.

## Get specific Channel
To get a specific channel we can use `GetChannel` node.

## Split/Join Image into Channels
The `Split` node allows us to retrieve the single channels of an image.
`Join` nodes brings together a spread of image into one image.

Another way to get a channel is with the `GetChannel` node.
## Convert into one channel image
The `Grayscale` node converts an image with multiple channels into a gray one channel image.

## Get information from image
To get informations like *width*, *height*,*channels* and *format* we can use `Info` node.

## Converting CVImage
To convert a opencv image into skia or stride we first need the *opencv*
`ToImage` and then `FromImage` for Skia. And for Stride `ImageToTexture`.

## Calculate Mean Color of Image
`Mean` node allows us to calculate the *mean* color of the whole image

## Get Color of Pixelposition
