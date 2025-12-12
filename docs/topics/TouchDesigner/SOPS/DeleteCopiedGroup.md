---
comments: true
tags:
 - TD/SOPS
 - TD/CHOPS
 - TD/INTERACTIVE
 - TouchDesigner

---

![Delete Copied Group Img1](../img/DeleteCopiedGroup.png)

# Delete Group From CopySOP
If we want to delete one of the copies from the `CopySOP` we can set `Create Output Groups` to `On` in the parameter window. This creates for each copy a new group. We then connect the `CopySOP` with a `DeleteSOP` and select the group we want to delete.

![Delete Copied Group Img2](../img/DeleteCopiedGroup2.png)

[Download Example File](../files/DeleteCopiedGroup.tox)