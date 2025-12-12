---
comments: true
tags:
  - VCV
  - VCV/Basics
  - Audio
  - Audio/Basics

---
# Basics OLD

---

# Basics

## Polymeter
A polymeter is the use of different rhythmic cycles that run independently and that doesn't repeat at the same time. We can create a `polymeter` by giving two sequencers the same `CLK` input and give each sequencer a different amount of steps.

![Polymeter](../img/PolymeterSequencer.png)

For example the left sequencer goes over 4 steps (4/4) and the right goes over 3 (3/4).

### Modulation

Modular synthesis uses a signal *modulator* to change different aspects of another *carrier* signal like amplitude, frequency or timbre/tone color.

Good question to ask is: which principle of modulation is used in this step?


Some types of modulation are:
- frequency modulation
- amplitude modulation
- phase modulation
- ring modulation
- pulse-width modulation




## Mix Module


## Basic Sounds
### Snare
To build a Snare we need a `Noise` module which is connected to a *high-pass-filter* that only lets through the higher sounds. With an `ADSR` module connected to `VCA` you shape how amplitude behaves when the *ADSR* is triggered by a *gate* signal.

![Basic Snare](./img/BasicSnare.png)


#### Process
T+H Track and Hold - The signal gets through and when a gate signal turns ON it hold the value till the game is off

H+T Hold and Tack - The signal gets hold until gate is on where the value gets tracked

You can use rhythmic gate signals to manipulate your control voltage


When you reset you control vvoltage modules with a divided clock signal/ every 4th cloth or something you can create something more rhythmic

To have a signal comming in and out of phase use step sequencers with different length of steps



next
https://www.youtube.com/watch?v=qbnY-6jKazg


### Tuning Oscillators
Quantisiser only lowest c(key)
Dann into `mult` Module und dann in alle `V/Oct` verbinden.
Damit sie alle *in tune* sind.


### V/OCT
Pitch CV signal to create different tones

What is an octave? An octave is 8 tones of the white keys on a piano CDEFGABC nodes. Different octaves - higher and lower octaves

How do I tell it to play a note of c? Midi devices have midi signals each node has certain values - midi 48 value -> c3 ->

With synthesizer we work with octaves
-1V = C1
0V = C2
1V = C3
2V = C4
3V = C5
