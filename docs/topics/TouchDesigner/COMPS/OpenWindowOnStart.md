---
comments: true
tags:
 - TD/COMP
 - TD/WINDOW
 - TouchDesigner
---
![Open Window Automatically On Start Img](../img/OpenWindowAutomaticallyOnStart.png)

# Open Window Automatically On Start
If you want to automatically open the window of your patch when it gets started we can use an `ExecuteDAT`, set `Start` *ON* and write `op('window1').par.winopen.pulse()` in the *onStart* method.

[Download Example File](../files/AutoWindowOnStart.tox)