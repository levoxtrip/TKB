---
comments: true
tags:
 - TD/SOP
 - TD/Noise
 - TD/Displace
 - TouchDesigner

---

![Displace SOP Only in XY](./img/SkinnedShapeFromLines.png)
# Skinned Shape From Lines
To create a skinned shape from lines in TouchDesigner, you'll typically use a combination of `LineSOP`, `MergeSOP` and `SkinSOP`.

1. Create Lines SOP
   - Define your base lines that will form the skin
   - Ensure lines are appropriately positioned and oriented

2. Combine Lines
   - Combine your Lines in a `MergeSOP`

3. Create Skin
   - Plug the `MergeSOP` into a `SkinSOP`. This create the surface between the lines.

[Download](./files/SkinnedShapeFromLines.tox)    

