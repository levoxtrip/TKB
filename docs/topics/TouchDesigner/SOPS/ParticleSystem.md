---
comments: true
tags:
 - TD
 - TD/TECHNIQUES
 - TD/ParticleSystem
 - ParticleSystem
---
# Particle System

In a Particle System(PS) points get spawned and moved to a position over some time till they return to there initial position.
Then this will be repeated over time.

In TouchDesigner we can represent the position of one particle as RGB colors.

## Forces
In a PS we want to apply forces to the particles so they can move from there initial position to a new position.
*Initial Position -> Forces -> New Position*

Added with a Feedback Loop *New Position -> Forces -> New Position -> Forces* we can create a dynamic system.

This can be created in TD by adding a small amount of color added to the image of the previous frame.

If we add the same amount of force every frame we get a *straight* moving of the position. 

If we add some noise we can create more random movement of each single particle.

## Lifetime
To assure that your particle is not moving outside of the view it makes sense to add some lifetime to the particle so it dies after a time and a new particle at the initial position gets emitted.
We can achieve that by setting a *switch* pixel that basically says: As long as I have the color white forces get applied. If I'm black the particle *"dies"* or rather *goes back to initial position*

If you want the particles to die and reset all at the same time this switch is enough. But to create more random lifetime for all particles we can use a lifetime texture in which every pixel defines the length of the lifetime of the particle.
Then on each frame the particle gets older and the lifetime smaller. When the lifetime is zero the particle dies and the lifetime get set back to the life duration time.


## Masking
Instead of applying forces and effects to all particles we also can mask the effect and apply them only to specific particles or apply different forces to different particles.


## Data
To make the PS as efficient as possible it makes sense to use TOPs for the information of particle system


### Convert Shape into TOP data
To convert a shape into TOP data we first have to convert it from SOP to CHOP and then from CHOP to TOP. In the `ChopToTop` for *Image Layout* we have to set *Fit to Square*.

![Sop to Top](./img/SOPtoTOP.png)


## Rotation
If you want to orient your particles along the path they are moving, we can compare current position with the position of the last frame and then subtract these. This gives us the vector size/magnitude of the vector which is the direction of the vector. We then can use this value as the rotate to value.

## Scale
We can use the magnitude. The greater the distances between the frames means the point is moving faster the longer the size fill be

In particles we often also define the size of the particle over the life of the particle.