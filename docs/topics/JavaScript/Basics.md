---
comments: true
tags:
  - JavaScript
---
# Basics

*Runtime*: Where code gets executed for example Browser or on a Server thanks to Node.Js

JavaScript(JS) got invented to make websites interactive.

JavaScript is a scripting language - you can execute it on the fly e.g. in your browser console.

JS is interpreted line by line.

V8 is engine under the hood that let's run JS extremely fast.

To run JS on a webpage you need an html document with a `<script>...</script>` Tag to run your JS inside.

You can write directly inside the script tag or you reference an external file
`<script src = "app.js"></script>`

## Print out statements
`console.log('hi momi')`

## Defining variables
There are several different ways to define variables
`let luckyNumer = 23;`
`let luckyNumber;` <- undefined value (default value)

JS is a dynamically typed language so no type assignment to variable is necessary.

To define an emtpy value
`let luckyNum = null;`

Another common way to define a variable is with `const`. `const` variable can't reassigned later.
`const name = 'jeff';`

The third way is to use `var` but these just should used if you really know why.


## Variable scopes
Global scope - variable is available everywhere.

If we define a variable in a function, the variable is locally scoped - only available in that function and can't used outside of the function.

If you have statements in your code a variable also can just exist in that statement
```JS
let a = 'global'; //global scope

function fun (){
    let a = 'function'; //local scope

    if(true){
        let a = 'block'; // block scope
        //when you use a var variable in that statement the variable gets available in the whole function
        var b = 'hoisted';
    }
}
```

## Functions
To define a function we use `function name(){...}`

Functions are one of the main building blocks in JS. They work by taking an Input and process the Input and returning it.

```JS
// input params
function add(a,b){

    // return value
    return a +b;
}
```
Functions are objects so they can be used as expressions(Function expression) allowing them be used as variables.
```JS
const add = function(a,b){
    return a +b;
}
```
Or to construct higher-order functions where a function is used as an argument or a return value
```js
function higherOrder(fun){
    fun();
    return function (){
        //Do something
    }
}
```

Functions can also be nested to create *closure*, that incapsulates data and logic from the rest of the programm. 
Normally when you call a function that has a variable with a primitive value  `let a = 10;` it is stalled on the *call stack* which is the browsers short term memory.
When you call a closure the inner function can still acccess variables in the outer function and even after the initival function call. That happens because JS automatically stores the data in the outer function and the heap memory, which persists after the function call.

```JS
function giveMeClosure(){
    let a = 10;
    return function () {
        a++:
        return a;

    }
}
```
## this
`this` is a keyword that references an object based on how a function is called.
We called from the global scope it references the `window` object in the browser.
```JS
//global scope
function isThis(){
    console.log(this);
}
```
If that same function is attached to an object and is called by that object `this` references the object.
```JS
const person = {
    isThis: function () {
        console.log(this)
    }
}
```
You can manually bind a function to some other objects using `.bind()` method.

```JS
function isThis(){
    console.log(this);
}

const person = {};

const personFun = isThis.bind(person)
```

In modern JavaScript we can define functions with the arrow syntax `()=>`
Arrow functions don't have their own `this` value and they are always anonymous which makes them ideal for function expressions.

When passing arguments in functions a primitive like a number is passed by value which means a copy is created of the original variable.

If the argument is an object that means it is stored in the heap and it is passed by reference. That means multiple parts of the code is mutating the same object.
```JS
const num = 23;
//copy of num gets created
someFun(num);

const obj = new Object();
//
someFun(num,obj);
```

## Objects
An object contains a collection of *key:value* pairs or properties and values.

The easiest way to define an object is with the object literal syntax using `const name = { }`:
```JS
const human = {
    dna: 'BAJCA',
    name: 'Jeff',
    born: Date.now(),
    walk() {
        console.log('walking')
    }
}
```
There is also an `Object()` Type that is created with a constructor.
`const human = new Object();`

Objects can inherit properties from each other with `human.__proto__.__proto__`
Every object has a private property that links to one prototype.

## OOP
JavaScript supports object oriented programming with the `class` keyword.

```JS
class Human {
    constructor(name){
        this.dna = 'MMYYDD'
        this.name = name
    }

    get gender() {
        return this.gender;
    }

    set gender(){
        this.gender = val;
    }
}
```
But classes are syntactic sugar for prototype and inheritance and objects.

A class can define a constructor that is called when the object is first created.
The class also can have properties and getter and setter functions to access the properties.

Classes also encapsulate functions as methods on an objects instance. We also can make the methods global to the class name by defining it `static` method

```JS

class Human {
    constructor(name){
        this.dna = 'MMYYDD'
        this.name = name
    }

    get gender() {
        return this.gender;
    }

    set gender(){
        this.gender = val;
    }

    walk(){
        console.log('walking')
    }
    static isHuman(human){
        if(human.dna == 'AACTG'){
            return true;
        }
    }
}
```

## Other Datastructures

### Array
Hold dynamic collection of index items.
`const list = ['aa','bb','cc','cc']`

### Sets
Hold a collection of unique items
`const uniq = new Set(list)`

### Map
Hold key:value pairs and it is easier to loop over this data collection than objects.
```JS
const dict = new Map([
    ['doof',1],
    ['foof',2],
    ['cruuf',3]
])
```

### Garbage collection
JS is *garbage collected* which means it will automatically deallocate objects from memory when they are no longer referenced in the code.

With Maps and Sets all your properties will always be referenced. 
For optimisation there is `WeakMap()` and `WeakSet()` that contain properties that can garbage collected and the memory reduced.

## Non blocking event loop

