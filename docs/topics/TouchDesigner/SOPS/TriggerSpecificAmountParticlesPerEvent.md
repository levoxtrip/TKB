---
comments: true
tags:
 - TD/SOPS
 - TD/CHOPS
 - TD/INTERACTIVE
 - TouchDesigner

---

![Trigger Specific Amount Per Event Img](../img/TriggerSpecificAmountParticlesEvent.png)

# Trigger Specific Amount Of Particles Per Trigger Event
The `ParticleSOP` emits a certain amount of particles per second. If you want to emit a specific amount of particles every time a trigger event happens you can take `root.time.rate` and use it to multiply the `TriggerCHOP` signal in a `MathCHOP`. The amount of particles that should get emitted we can set in `Peak Level` parameter of the `TriggerCHOP`

[Download Example File](../files/ParticlePerTriggerEvent.tox)