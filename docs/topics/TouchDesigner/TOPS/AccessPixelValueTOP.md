---
comments: true
tags:
 - TD/TOPS
 - TD/Effects
---

![Accessing Color Values of first Pixel](./img/AccessPixelValueTOP.png)

# Access Pixel Colors of TOP via Script

If we want to access the Color Values of a Pixel in a TOP we can use Scripting.
To access the complete RGBA Value of the first pixel we can use `op('noise1').sample(x=0,y=0)`.
To only access a specific color for example Red we can add the index behind the example above. `op('noise1').sample(x=0,y=0)[0]`


[DownloadFile](./files/AccessColorValueTOPScript.tox)