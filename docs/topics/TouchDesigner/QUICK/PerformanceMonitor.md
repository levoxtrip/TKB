---
comments: true
tags:
 - TD/QuickTips
 - TD/Performance
 - TD/COMP
---

![View of Performance Window Monitor](./img/CheckingPerformance1.png)

# Checking Performance 

When your TD Sketch is slow and you want to know which process is likely causing it, we have two options in TouchDesigner that can help quite fast. The first option is the `Performance Monitor` which is showing the single Processes. In the UI go to top to *Dialog/Performance Monitor*. On the Popup window click on *Analyse* at the bottom. Look for the process with the highes *ms* Value/ Process Time. This can be a good indicator to find your bottle neck. 


Another option is the the `Probe` from the Palette. Open it by clicking the `Pulse` Btn in the Parameter Window of the COMP.
You can find it under *Tools* . With the `Probe` you can monitor the GPU,CPU times as well as Memory. The more red the color of the area the higher the effects on your performance. If you put your mouse over one of the colored areas and hit `F10` it navigates you to the area of the sketch. 

![View of Probe Window](./img/CheckingPerformance2.png)

