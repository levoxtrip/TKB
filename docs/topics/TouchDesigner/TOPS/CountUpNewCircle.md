---
comments: true
tags:
 - TD/TOPS
 - TD/CHOPS
 - TD/INTERACTIVE
 - TD/SENSOR
 - TouchDesigner

---

![Count Up When New Circle Appears](../img/CountUpWhenNewCircleAppears.png)

# Count Up When New Circle Appears

When we work for example with sensors like lidar, we often want to check if a new object is inside a specific area - and then count up. 
The lidar sensor gives us ..., which we then instance with circle. If an object or person is inside our desired area we have a circle inside the top. We can analyse the TOP with an `AnalyseTOP`. We use *Operation* `Sum` and set *Scope* to `Full Image`.
This gives us a full white image if circle is visible and a transparent image if no circle is inside the TOP. We can convert this with `TopTo` Chop into a trigger for the `CountCHOP`. In the `TopTo` we set *Crop* also to `Full Image`.![alt text](image.png)


[Download Example File](../files/CountUpWhenNewCircleAppears.tox)