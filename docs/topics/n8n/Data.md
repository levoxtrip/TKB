---
comments: true
tags:
 - n8n

---
# Data
N8n uses two major datastructures Json and List.

We want to access data from one node and use it to setup next node.


## Json
Json is used for digital communication.
It gets written with braces and contains key:value pairs
```JSON
{
    "key":"value",
    "key2":"value2",
    ...
}
```
We also can embed JSON into a JSON then key:value is another JSON.

To access the json data in a node we can write into the expression field `{{$JSON.keyname}}`. 
To access data inside a json that is a key we have to go down one level deeper `{{$JSON.jsonKeyName.country}}`

There is also a 1:1 correspondance of JSON and tables. 
The keys of the JSON are the header of the rows.

```
{
    "first": 1,
    "second":2
},
```
first | seconds
---------------
  1   |  2

One JSON is one "item" in n8n and one row in the table.

## List
Because a JSON is an object itself we can create a List of JSONS

```
[
    {...},
    {...}
]
```

