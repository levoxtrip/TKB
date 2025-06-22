---
comments: true
tags:
 - TD/Lights
 - DMX
 - TouchDesigner
---
# DMX

Enttec dmx usb pro mk2 device to go from pc to dmx channels.

One dmx channel can support on universe. 

DMX Pro Manager helps to install drivers 

d001 - d512 for the dmx channels

d001 - dmx first channel

One light requires a certain amount of channels - 

Each channel can except values from 0 to 255

So we send 8 channels of information with values from 0 to 255

Some channels for functions
Some channel for dimmer
and some channels for colors

In TouchDesigner we use `DMXOut` with *packet for sample* and select the interface.

You also can convert a channel into a universe and then send only the channel of the universe 

`DMXOut` expects values from 0 to 255. 

DMX Universe only operate to maximum 44 frames per second

DMX is only one way communication