


# Structure Projects
Especially when you have bigger projects you should structure up your patch in different layers.

Store subparts like `AudioAnalysis`, `MidiInputs`, ... in there own patch and then implement them as modules. Store as class and process node.


# Context Class
In the *Context* we create a class where we collect the properties of our system inside.
We create a unique data type to collect all the inputs.

We add some operations to retrieve the properties - GetAudioAnalysis, GetMidiInputs, GetKinectData, get LeapData.

We then have the *Context* instance that we can use everywhere in our patch to retrieve and handle the information.

The *Context* wraps all the resources of the system and 

# Content Process
In the *Content*  we put something like our visual elements.

We can connect the context to the content and then in the contect get the parts from the context that we need.