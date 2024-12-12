---
comments: true
tags:
 - TD/CHOPS
 - TD/Signal
 - TouchDesigner
---

![Take two Input Channels and Combine them to One](./img/CombineChannelsMathSOP1.png)

# Combining Channels with MathCHOP

The `MathCHOP` allows you to combine CHOP Data in different ways. 

If you want to combine for example two channels from one CHOP into just one channel you can plug the CHOP into a `MathCHOP` and select
`Combine Channels`. There you can decide how you want to combine the two channels with each other.j

If you want to combine channels from to CHOPs and into one you plug them both into the `MathCHOP` and select `Combine CHOPs`.

![Take two CHOPs with one Channel and Combine them to One](./img/CombineChannelsMathSOP2.png)

These operations can also get excecuted together by plugging multiple inputs with multiple channels into one `MathCHOP`.

![Combining multiple CHOPs with Multiple Channels](./img/CombineChannelsMathSOP3.png)

 [Download](./files/CombiningChannelsMathCHOP.tox)