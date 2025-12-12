---
comments: true
tags:
  - VVVV
  - VVVV/Fuse
  - ParticleSystem
---
# Fuse Particle System

The source of our particle system(PS) in Fuse is the `StructuredBufferResource`. It allows us to define the amount of particles we want and the *name/id* of the particle system. To define the name we need to `R+Click node -> Configure -> Show Name`.

To be able to draw the PS in *VL.Stride* we need to connect the `StructuredBufferResource` into a `BufferToRenderEntity` or `BufferToEntity`

`BufferToRenderEntity` is a low level rendering node, which is being drawn with shaders(Like MeshRenderer). No lighting and no material pipeline.
`BufferToEntity` is using the material pipeline - PBR materials and lighting.


---


*Emission Stage* defines how are you creating you particles which have a lifetime. How and where particles are born. Attributes you want to set at birth. Like settings the lifetime of particles.

*Simulation Stage* what you want to do with the created particles. What effects and forces do you want to apply, how do you want to affect the particles.

*Integration(one step of the simulation)* is where we place everything that affects the particles like forces, collisions

*PostIntregation* more deterministic things that maybe aren't part of the integration stuff.

In Fuse we have different stages to define the behavior of the particles.


To draw the Particle System in *VL.Stride* we need to connect the `StructuredBufferResource` into a `BufferToRenderEntity`. This allows us to connect it to the `RootScene` later.

If you want a static particle system, where the particles don't move around and the single particle doesn't have any lifetime to them we can use the `Compute Stage`.
We would use that for example for static *Point Cloud Scenes*

To be able to connect our `StructuredBufferResource` with the `ComputeStage` we need




#### Emission Stage
In the Emission Stage we can define all the settings how the particles get emitted.

To define if we want to emit a fixed amount of particles every frame we can use `AmountEmitter` node. If we wan't a more probabilistic behavior we use `ProgabilityEmitter` and define the *probability*