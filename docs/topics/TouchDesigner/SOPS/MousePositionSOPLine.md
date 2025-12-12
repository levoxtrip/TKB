---
comments: true
tags:
 - TD/SOPS
 - TD/CHOPS
 - TD/INTERACTIVE
 - TouchDesigner

---

![Mouse Position To SOP Line](../img/MousePositionToSopLine.png)

# Mouse Position To SOP Line

If we want to create an interactive drawing project where we convert the mouse position into a *SOP* line we can convert the `MouseInCHOP` data into a `TrailCHOP` and then set that as the *X/Y Channel* in a `LimitSOP`. This converts the data into SOP land. Under the *Output* tab of the `LimitSOP` we can set how we want our line to be displayed.

[Download Example File](../files/MousePositionSOPLine.tox)