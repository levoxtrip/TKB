---
comments: true
tags:
 - TD/DAT
 - TD/Storage
 - Scripting
 - Python
 - TouchDesigner
---
![Get all values of CHOP as List](./img/getValuesChopAsList.png)
# Storing and Fetching Data in Components via Script

You often need to dynamically save and retrieve data in you TouchDesigner sketches. Instead of hardcoding these values or being overwhelmed by a lot of references in complex projects we can store and fetch
the data in the components. This also makes updating the stored data convenient.

`store` and `fetch` are methods that let you save and retrieve data within a component, as a way to create your own "variables" directly inside a component.

## How to Use store and fetch

1. Storing Data
You can store any type of data: numbers, strings, lists, or even entire dictionaries.

In a Text DAT, type the following script:

```py
me.store('myNumber', 42)  # Stores the number 42
me.store('myText', 'Hello, TouchDesigner!')  # Stores a text string
```
Now, this data is saved in the component and can be accessed at any time.

2. Fetching Data
```py
number = me.fetch('myNumber')
text = me.fetch('myText')

print(number)  # Outputs: 42
print(text)    # Outputs: Hello, TouchDesigner!
```

Example:

python
Code kopieren
me.store('myData', {'speed': 1.5, 'color': [255, 0, 0]})
data = me.fetch('myData')
print(data['speed'])  # Outputs: 1.5

A Practical Example: Connecting Data to a Slider
Imagine you have a slider in your project, and you want to save its current value and use it elsewhere.

Store the Value:
``` py
sliderValue = op('slider1').par.value0
me.store('sliderValue', sliderValue)
```

Fetch the Value: Use the stored value to control another operator:

```py
op('constant1').par.value0 = me.fetch('sliderValue')
```

Error Handling: What If the Data Isn’t Stored?

If you try to fetch data that hasn’t been stored yet, TouchDesigner will throw an error. To prevent this, you can provide a default value:
```py
value = me.fetch('unknownKey', default=0)
print(value)  # Outputs: 0 (the default value)
```

[Download](./files/getValuesCHOPList.tox)  
