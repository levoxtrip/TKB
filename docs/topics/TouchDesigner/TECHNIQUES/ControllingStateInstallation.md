---
comments: true
tags:
 - TD/TECHNIQUE
 - TouchDesigner
 - TD/STATE
---
![FaceTracking Img](../img/ControllingStateInstallation.png)
# Controlling State Of Installation
To execute certain logic if the state of your installation changes, you first create a STATE `BaseCOMP` which has custom `State` parameter. Right click the Base and go to `Customize Component` there you can create your own parameters for the COMP. Then add a `ParameterExecuteDAT` and write the logic you want to execute on certain values of your *State* parameter.
