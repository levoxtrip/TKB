---
comments: true
tags:
  - TD/BASE
  - TD/Framerate
  - TouchDesigner
---

# Mapping

There are multiple tools to do mapping in TouchDesigner. We can find them in the palette.

## Cam Snapper

The `camSchnapper` tries to calculate the position of the projector in relation to the model.
Click on `Open Main Window` in the parameter window..

Rotate the view - `ctrl + l mouse`
Move the view - `ctrl + r mouse`
Home view - `h`

In the window you select points on the virtual model which will match with real physical model..
Then you use the output view and move them according to the real model.

## Kantan Mapper

Let's you map textures on shapes e.g. tape mapping.

Pick quad
Pick freeform
Under `texture` we can drag teh top we want on that shape. Or drag the texture directly on the shape.
Click on x to show it

On `edit texture` you can move around the texture for the shape

Under the `grid` you can create a grit wand warp the grit to your liking.

For bigger projects you can use Kantan uv help comp.
There you take second output of kantan helper.
