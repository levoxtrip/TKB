---
comments: true
tags:
  - JavaScript
---
# Basics

*Runtime*: Where code gets executed for example Browser or on a Server thanks to Node.Js

JavaScript(JS) got invented to make websites interactive.

JavaScript is a programming language - you can execute it on the fly e.g. in your browser console.

In the relation to HTML,CSS and JS we can say:
- HTML is the content - NOUN
- CSS is the adjectives - How is something? - ADJECTIVE
- JS - dynamic and interactive elements - VERB

JS is interpreted line by line.

V8 is engine under the hood that let's run JS extremely fast.

To run JS on a webpage you need an html document with a `<script>...</script>` Tag to run your JS inside.
The advantage is that you don't have to load a seperate file. But it makes sense to seperate the website content from the javascript functionality
You can write directly inside the script tag or you reference an external file
`<script src = "app.js"></script>`
We usually reference the script at the end of the html file.

## Print out statements
If you want to show information in the console you can use
`console.log('hi momi')` 
To print multiple information you can seperate it by a comma
`console.log(var1,var2,'Hallo')`

## Show Alert Popup in browser
`alert('string text')`

# Variables
A value is a piece of data - the smallest piece of information in our programm.

A variable is like a box that contains objects. By assigning a value to a variable we define what the *box* contains.
## Defining variables
There are several different ways to define/declare variables
`let luckyNumer = 23;`
`let luckyNumber;` <- undefined value (default value)

We use `let` for variables, that can change later.

JS is a dynamically typed language so no type assignment to variable is necessary.

To define an emtpy value
`let luckyNum = null;`

To define a variable that will not change in the future we use `const`.
`const` variable can't reassigned later. 
`const birthYear = 1992;`

Because it can't be changed later we also can't declare empty constant variables.

So as a rule of thumb always declare your variables as `const` unless you are 100% your variable is gonna change later then use `let`

The third way is to use `var` but these just should be ignored or used if you really know why.
Under the surface `let` and `var` are really different although they look like the same.


## Naming variables

In JS a variable naming conventing is camel case. The first word is small and to seperate the second we start with a capital letter.
`let firstVariable`

We can't start variable names with a number. 
`let 3years = 3` wouldn't work.

Variables only can contain letters,numbers,underscore or the dollar sign.

Don't start a variable with a capital letter because we use it for object oriented programming.

Variables written in uppercase are often reserved for constants that never change.
`let PI = 3.1415;`

Make your variable names descriptive.

`let myFirstJob = 'Programmer'`
`let currentJob = 'Teacher'`

instead of
`let job1 = 'Programmer'`
`let job2 = 'Teacher'`

## Datatypes
*Number*: Floating point numbers - used for decimals and integers
`let age = 23;`
`let weight = 22.23;`

*Strings*: Sequence of characters
`let firstName = 'Jonas';`

*Bool*: Logical type that can be `true` or `false` - used for making decisions
`let goodWeather = true`

*Undefined*: Value taken by a variable that haven't been defined yet - "empty value"
`let children;`

*Null*: Also means empty value but gets used in other circumstances.

*Symbol*: Value that is unique and cannot be changed

*BigInt*: Larger integers than the Number type can hold

JS has dynamic typing which means you don't have to define the data types of the values that get stored. JS automatically stores it for you. 
In JS the value stores the type not the variable.

To evaluate what datatype some value is we can use `typeof`
```JS
let jsIsFun = true
console.log(typeof jsIsFun)
```

There is a bug inside of JS when you do `typeof null`. It returns an `object` which is wrong. It should return `null`.

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

# Comments
We write comments inside our code with eather single line comments or multi line comments
```JS
//This is a simple line comment

/*
This is 
a multi
line 
comment
*/
```
# Operators
Operators allow us to transform or combine multiple values.

## Arithmetic operators
Add - `+`
Subtract - `-`
Multiply - `*`
Devide - `/`
Exponent - `**` 2 ** 3 means: 2 to the power of 3

We can use the `+` to join strings
`firstName + " " + lastName`

## Assignment operators
The most basic assignment operator is the `=` to assign values to a variable.

`x+=10` is a short version of `x = x +10`. The same works with the other basic arithmetic operators `-=, *= , /=,`

If you want to add or subtract just 1 there is another short version `x++` and `x--`

# Functions
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

Normally when you run your code in a script it gets executed synchronously line by line.
The next line can't start before the previous line finished.

With an event loop we can write asynchronous code in javascript which runs in a serparate thread pool while the rest of the application continues to execute. It allows multi task

We can writer async code with a `promise()`

```JS
const promise = new Promise(
    (resolve, reject) => {
        // Do something async here

        if(sucess){
            resolve('success');
        } else {
            reject('failure')
            //To raise an error 
        }
    }
)
```

A promise is a wrapper for a value that is unknow right know but that will resolve to a value in the future. For example a call to a 3rd party api that resolves to some data.

The consumer of the promise can use methods `.then()` and `.catch()` to handle this outfcomes

```JS
promise
.then(success => {
    console.log('yay!',success);
})
.catch(err =>{
    console.log('oh no!',err)
})
```

You also can define an `async function` that automatically returns a promise
```JS
async function asyncFun(){
    //waits till the promise is resolved
    const result = await promise;
}
// To implement error handling you want to wrap it in a try catch block

async function asyncFun(){
    try{
        const result = await promise;
    } catch(error) {

    }
}
```

To keep bigger code more easy to read we can use modules which is code in an extra file for parts of the code.

By default all the code in a file is private just to that file.
In order to share code with other files we can make the code *default export* by assigning `export default function name`.

Then we can import it in another file with
`import functionFun from './help.js';`

we also can export and import variables 
`export const hallo = 344;`
`import {hallo} from '.help.js';`


## Node package manager
To use code from other developers we can use *npm* javascript package manager
We can install packages with `npm install`. It downloads the code it in the `node_modules` folder. It also provides a `package.json` file that list out all the dependencies that you use in your project.

## Browser


The browser is based on *document object model (DOM)* where the UI is based on a tree of html elements.

A browser provides an api to interact with these elements with `window.document`.
The `document` allows us to grab an individual html element using the `.querySelector('.button')`
it takes a css selecter as an argument and will find the html elements that has the same classname, id or tag name. It returns an instance of the element class.

We can grab multiple elements at the same time with `.querySelectorAll('.button')`

We also can listen to events that happen to the element. For example when a btn is clicked, we can assign a function that gets called when the button gets clicked.

```JS
btn.addEventListener('click', () => {
    console.log('clicked')
}
```

## Front-end frameworks
Many developers use front-end frameworks that produce declerative code where the UI is a function of its input data /states.

These frameworks encapsulate JS, HTML,CSS into components. Inside a components the data is reactive. It can be bound from js directly to html

## Bundle
Module bundler

## Network waterfall

## Dynamic imports 
Only import bundle when it is needed

## Run Javascript on a server
With node.js we can run javascript on a server.
with `node` command we can execute javascript 

##
Electron node.js with the browser to create app
react native to build whole apps

typescripts


## Errors
### Unexpected token 
You used a wrong variable name.