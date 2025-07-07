---
comments: true
tags:
 - TD
 - TD/POPS
 - Particle System
---
# POP Particle System

To create a *Particle System* we can use a `ParticlePOP` which contains the usual particle parameters from *ParticleGPU* or `ParticleSOP`

When we connect a `TopToPOP` we get the *Color* attribute from the TOP. But we will loose this attribute when connecting to the `ParticlePOP`. Under *Attributes* in the `ParticlePOP` parameter window we can add the *Color* attribute.

## Move Particles
To Move the particles in a *POP particle system* we create kind of like a feedback loop in TOP world. We add a `Null` after the `ParticlePOP` and then assign it to the *Target Particles Update POP* parameter of the `ParticlePOP`.

In between we then can add a `NoisePOP` or a `TransformPOP` to create the change in the particle system.

## Apply Noise only on specific color values
Be default the `noisePOP` adds the noise values to each point of the POP.

But if you only want to apply noise to a certain color range

`MathCombinePOP`allows us to combine certain attributes or even create new Attributes. So we can choose A*B *operation* and then choose the attributes *Color* and *Noise*

## Limit Particles in a direction
We can use a `LimitPOP` to limit it's movement in an direction.
For that we set *parameter size* to 3 and then activate *Positive Only* for the axis we want to limit.

## Add trails to particles
Be careful before you connect the `TrailPop`. It can crash your TD when you use the *experimental build* . Set it up first.
First deactivate `Active`. Then you can connect and activate *Math by Attribute* and pick `PartId`. This will tell the POP which points to connect.
So set *Connectivity* to `Point Prim`.

`TrailPOP` also has a *Transform* tab to create interesting transformation and rotation behavior.

## Color particles with noise applied to them differently
We can use a `LookupTexturePOP` to give the particles that have noise applied a different color.

We can calculate the length a vector with `MathCombinePOP` and `length(A)` operation.