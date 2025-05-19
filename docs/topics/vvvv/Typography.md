---
comments: true
tags:
  - VVVV
  - VVVV/Typography
  - Typo

---
# Typography

## Skia Text
With the `Text` node we can set Typography in our sketches.
To manipulate style of the text use `FontAndParagraph` Node into the *Paint* input of the `Text`.
The `FontAndParagraph` node allows us to define font, style, size, color and horizontal and vertical alignment.


### Multiline Text
If you have longer text that you want to keep in an area we can use a `BreakAtRect` node to define where the text should break it's lines. We use a `Rectangle(Join)` to define the area.

![TextInRectangleShape](./img/TextInRectangleShape.png)