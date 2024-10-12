---
comments:true
tags:
 - TD/BASE
 - TD/Framerate
 - TouchDesigner
---

![Set custom Framerate in Base](./img/SetCustomFrameRate1.png)

# Set custom Framerate for process in BaseCOMP
When you have certain processes that for example doesn't need to be run with 60 Frames per Second (FPS) you can set
for this specific process your own framerate. 

First click on the I field to `Run Component Time Independently`.
![Click I field Run Component Time Independently](./img/SetCustomFrameRate2.png)

For that create a new Base. Make a left click on that base and click `add component time`. 
![Set rate in local](./img/SetCustomFrameRate0.png)
Then navigate inside of the base and into  the `local` OP.
There in the `time` OP you can set the value `rate` to the framerate you need.


[DownloadFile](./files/setCustomFramerate.tox)