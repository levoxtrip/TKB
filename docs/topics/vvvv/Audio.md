---
comments: true
tags:
  - VVVV
  - Audio
  - VVVV/Audio
---
# Audio

`nuget install vl.audio -pre`

## Audio driver
ASIO4ALL driver allows you to have easily 

## Set audio settings
You can set the audio settings with `alt+c`

## AudioPlayer
We can use `AudioPlayer` to get an audio file into VVVV.

## AudioIn
With `AudioIn` we can get audio from a realtime audio source like the microphone or an audio stream that you want to pass into vvvv from a different software.

## Get Amplitude of audio
`Meter` converts the audio into a float to give us the *volume/amplitude* of the audio.
Combined with a `Damper` node we can get a smoother signal.

The `NormalizeMeter` allows to adjust the meter value.

## Stereo to mono
When we don't need the *stereo* audio but just a single audio signal we can use `Mono` node to convert it.

## Filtering Audio
The *VL.Audio* library has filter to manipulate the incoming audio.
We can filter *lowpass,bandpass and highpass*
![Filter](./img/FilterAudio.png)

## Analyze audio spectrum
The `FFT` node allows us to analyze the audio spectrum of our audio source. Depending on the *Bin Count* it outputs the amount of frequencies. With the `FromSequence` we can convert it into a *spread* to use values.

## Audio input signal to value
![Audio Input to signal](./img/AudioInputToValue.png)
With `AudioIn` we get the microphone as an input. When convert it `ToMono` and use `Meter` node to convert it into a single *level* value.

## Latest audio sample to value
The `A2V` outputs the value of the lastest audio sample from an AudioSource. In combination with `Queue` and `Reverse(Spread)` we can store and show the evolution of the audio sample over time.


## Audio to Frequency
AudioIn -> FFT

FFT extracts from a sinewave all components that compose the sinewave. Creates a spread for energy of the bins of the frequency.

BufferSize sets how many frequency you want.

`FFT4Bands` interprets the FFT information for us.

`FFTPreview` allows us to visualise the fft

## Play Audio file
With `AudioPlayer` we can input an audio file.


## IFFT
 
To convert data into frequency information.

Particles positions to frequency.

# Check
Adam Stark Sound Analyser