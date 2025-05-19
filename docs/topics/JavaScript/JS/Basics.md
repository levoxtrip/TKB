---
comments: true
tags:
  - JavaScript
---

# Basics

_Runtime_: Where code gets executed for example Browser or on a Server thanks to Node.Js

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

A value is a piece of data - the smallest piece of information in our program.

A variable is like a box that contains objects. By assigning a value to a variable we define what the _box_ contains.

## Defining variables

There are several different ways to define/declare variables
`let luckyNumber = 23;`
`let luckyNumber;` <- undefined value (default value)

When we want to assign two variables we can also do it in one line
`let x,y`

If you want to assign a specific value to two values in one line you could write `x = y = 20*4` -> x =80 y=80

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

_Number_: Floating point numbers - used for decimals and integers
`let age = 23;`
`let weight = 22.23;`

### Strings

Strings are a sequence of characters
`const firstName = 'Jonas';`

To concatenate strings we can use the `+`
`const jonas = "I'm " + name + ' a ' + year`

For more complex string concatenation we can use template literals. We can write a string more normal and then insert the variables into the string. To write template literals we need backtics and then set the variables into `${variableName}`

```JS
const firstName = 'Jonas'
const jonasNew = `I'm ${firstName}`
```

We can write every expression inside the `{year - birthyear}`

We also can use backticks for all strings

```JS
console.log(`just a regular string`)
```

We also can use _template literals_ for multiline strings.

```JS
console.log(`String with \n\
multiple \n\
lines`)
```

_Bool_: Logical type that can be `true` or `false` - used for making decisions
`let goodWeather = true`

_Undefined_: Value taken by a variable that haven't been defined yet - "empty value"
`let children;`

_Null_: Also means empty value but gets used in other circumstances.

_Symbol_: Value that is unique and cannot be changed

_BigInt_: Larger integers than the Number type can hold

JS has dynamic typing which means you don't have to define the data types of the values that get stored. JS automatically stores it for you.
In JS the value stores the type not the variable.

To evaluate what datatype some value is we can use `typeof`

```JS
let jsIsFun = true
console.log(typeof jsIsFun)
```

There is a bug inside of JS when you do `typeof null`. It returns an `object` which is wrong. It should return `null`.

### Type-Conversion and -Coersion

In JS there is _Type-conversion_ and _Type-coersion_

- Type-conversion: When we manually convert from one type to another
- Type-coersion: When JS automatically converts types for us in the background

JS can only convert to string,number and boolean.

#### Convert a String into a Number

You can use the build-in `Number()` function.

```JS
const inputYear = '1991'
console.log(Number(inputYear))
```

Using the `Number()` function only gives a converted value. It doesn't automatically assign it to the input value.

If we try to convert something into a number that isn't JS returns `NaN` for _Not a Number/Invalid number_

#### Convert Number into String

You can use the build-in `String(23)` function.
or we can use
`const numberToString = num => num.toString();`

#### Coersion

Javascript is converting some types internally. That is called _Type-Coersion_
`console.log('I am' + 23 + 'years old')`
`console.log('1' + 1) => '11'`
If you use `-` or `*`, `/` it triggers the conversion from string to number
`console.log('23' - '10' -3) => 10`
`console.log('23' * '10') => 230`

### Truthy and Falsy

Falsy values are not exactly false but will become false when we convert them into boolean
`0,'',undefined,null,NaN` will become false when we convert them into boolean.
`console.log(Boolean(0))-> false`
`console.log(Boolean(undefinied))->`

```JS
const money = 0
if(money){
    console.log("Dont spend it all")
}else {
    console.log("You should get a job")
}
```

JS converts the number 0 into a falsy false Boolean.

Everything else will be _truthy_ values

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
Exponent - `**` 2 \*\* 3 means: 2 to the power of 3

We can use the `+` to join strings
`firstName + " " + lastName`

## Assignment operators

The most basic assignment operator is the `=` to assign values to a variable.

`x+=10` is a short version of `x = x +10`. The same works with the other basic arithmetic operators `-=, *= , /=,`

If you want to add or subtract just 1 there is another short version `x++` and `x--`

## Comparison operators

We use comparison operators to create boolean values.

`a>b` - a is greater than b
`a<b` - a is smaller than b
`a<=b` - a is smaller/equal to b
`a>=b` - a is greater/equal to b

We can also assign directly a value to a variable

`let isThisBigger = a>b`

## Operator precedence

The order operators get executed in JS.
![OperatorPrecedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_precedence#table)

The higher values get executed before lower values.

So usally all the math operators get executed before the comparison operators.

# Control structure - Conditionals

## If-else

To make decisions in our code we can use `if else` to decide what happens if something is true or false

```JS
const age = 19

if(age >= 18){
    console.log(`Sarah is start driving`)
} else {
    console.log(`She is not old enough`)
}
```

You don't have to use the `else` part if you don't want anything executed when the condition isn't met.

We can extend the `if-else` with an `else if` to ask for more conditions

```JS
const weather = 'hot'
if(weather === 'cold'){
    console.log("I'm so cold')
} else if (weather === 'mild'){
    console.log("I'm mild)
} else if(weather === 'hot'){
    console.log("uff so hot)
}else {
    console.log("no idea")
}

```

## Switch statement

The switch does a strict comparision of a variable and iterates through different cases.

```JS
const day = 'monday'

switch (day){
    case 'monday': // equal to day === 'monday' strict comparision
        console.log("do monday stuff")
        break;
    case 'tuesday':
        console.log("do tuesday stuff")
        break;
    case 'wednesday':
    case 'thursday'://If you do this with two cases it will be executed for both
        console.log("Write this")
        break;
    case 'friday':
        console.log("chill mate")
        break;
    case 'saturday':
    case 'sunday':
        console.log("Enjoy the weekend")
        break;

    default:
        console.log("WOW a new day that we havent seen before')

}
```

If we use a switch without break statement the code continues executing

```JS
const count = 0
swithc(count){
    case 0:
        count+=1
    case 1:
        count+=1
    case 2:
        count+=1
    case 3:
        break;
}
console.log(count)
```

## Ternary Operator

The _Ternary/conditional operator_ allows us to write something like an if-else structure in just one line.
`age >= ? console.log('I like to drink this') : console.log('I like to drink water')`

Operator always produce values - so they are expressions. So we can produce new values with the _Ternary Operator_.

```JS
const drink = age >=18 ? 'wine' : 'water'
console.log(`I'm allowed to drink ${drink}`)
```

So because the Ternary operator is an expression we actuall can insert the into string literals

```JS
const age = 15
console.log(`I'm gonna have a ${age>=18?'wine':'water'}`)
```

So we use _Ternary operators_ when we need to make a quick decision. We still need if-else for bigger parts of codes.

## Equality Operators

### Equal

JS has two equality operators which test if two values are equal.
`===` strict equality operator - does not perform type coersion - only returns true when both values are exactly the same.
`'18' === 18 -> false`

`==` loose equality operator - does type coersion.
`'18'==18 -> true`

```JS
const age = 18;
if(age===18) console.log("18 Years old")
```

It is suggested to always use `===` the strict one.

### Difference

To check if something is different from another value we can use `!==`

```JS
const age = 18;
if(age !== 16) console.log("You are not 16 years old")
```

## Boolean Logic

Boolean logic uses true and false values to solve complex logical problems.
In order to do that it combines several logical operators to combine true and false values.

### AND

`&&` AND operator - both needs to be true to return true.
`if A AND B are true -> returns true`

### OR

`||` OR operator - one needs to be true to return true
`if A OR B are true -> return true`

### NOT

`!` inverts a boolean value
`!true -> false`

```JS
const hasDriversLicence = true
const hasGoodVision = false

if(hasDriversLicence && hasGoodVision){
    console.log("You are able to drive")
} else {
    console.log("you shouldn't drive")
}
```

### Properties of logical operators
But the logical operators doesn't necessary need to return *boolean* values
`console.log(3||'Jonas') -> 3`

They can use and return any data type.

Logic operators do also `short-circuiting` or *short-circuit-evaluation*. It returns the first value that is a *truthy* value.

*Truthy values* - all Values except `false,0,-0,0n,"",null,undefinied,NaN,document.all`

#### OR operator
The OR operator returns the first truthy value of all the operants or the last value if all other values are *falsy*.
So we can use the *OR* operator to set default values.

```JS
3 || 'Jonas' -> 3
'' || 'Jonas' -> Jonas
true || 0 -> true
undefined || null -> null //because undefined not truthy it automatically returns the other value
false || undefined || null || 'Hallo' -> 'Hallo'
```

So this allows us to short-circuit the assigning of default values if a value doesn't exist
```JS
//instead of 
const guest = concert.guests ? concert.guests : 20;
// we can 
//if concert.guests undefined it sets 20 as default. If not undefined it sets concert.guests
const guest = concert.guests || 20;
```
The only problem is when `concert.guests` exists but is `0`. Then it sets 20 although concert.guests is defined as 0.

#### Nullish Coalescing Operator
*Nullish Coalescing* works with the idea of *nullish* values which are only `null` and `undefined`
For that case we need to use *Nullish Coalescing Operator* `??`
```JS
concert.guests = 0;
const guest = concert.guests ?? 10;
guest -> 0
```


#### AND operator

The *AND* operator works the exact opposite way to the *OR* operator. It returns the first *falsy* value or the last value if all of them are *truthy*.

```JS
//When first value is falsy -> return that value
// Because && is only true when both values are true -> so if the first value is false already we don't need to look at the second and we return the first value
0 && 'Jonas' -> 0
//when first value is truthy -> return the second value
7 && 'Jonas' -> 'Jonas'
//this returns the first falsy value
'hello' && '23' && null && 'Jonas' -> null
```
So we can use the *AND* operator to execute code if the first value is true.

```JS
//instead of
if(concert.band){
    concert.start()
}
// you can do
concert.start && concert.start()
```









#### Logical Assignment Operators
JS has *Logical Assignment Operators* which makes the assignment event faster

`||=` assigns a value to a variable if the current variable is *falsy*

```JS
const house1 = {
    street:"street1",
    doors: 1
}
const house2 = {
    street:"street2",
    windows:10
}

house1.doors ||= 2; -> house1.doors = 1
house2.doors ||= 2; -> house2.doors = 2
```
Again this doesn't work when the value is actually defined as `0`

For this we can use the *nullish* operator `??`
```JS
const house1 = {
    street:"street1",
    doors: 0
}
const house2 = {
    street:"street2",
    windows:10
}
house1.doors ??= 10; -> house1.doors = 0;
house2.doors ??= 10; -> house2.doors = 10;
```

There is als the `&&=` assignment.
This allows us to replace a value when there is actually a value.

```JS
const house1 = {
    street:"street1",
    doors: 1
}
const house2 = {
    street:"street2",
    windows:10
}

house1.windows &&= 23 -> house2.windows = undefined
house2.windows &&= 23 -> house2.windows = 23
```


## Loops

Loops allow to execute repetitive tasks.

### For-loop

For loop keeps running while the condition is true.

```JS
for(let i= 0; i<=10;i++){
    console.log(`do something ${i}`)
}
```

#### Looping through arrays

```JS
const arrayNames = ['Jonas','Heinz','Reinhold']

for(let i = 0;i<arrayNames.Count;i++){
    console.log(`Name is:${arrayNames[i]}`)
}
```

#### Continue

With `continue` you exit the current iteration and move on to the next iteration.

```JS
for(let i= 0; i<=20;i++){
    if(i/2 !== 0){
        continue;
    } else {
        console.log(`${i} is an even number`)
    }
}
```

#### break

`break` is used to leave the whole loop.

```JS

for(let i=0;i<10;i++){
    if(i>4){
        break;
    }
    console.log(i);
}
```

#### Loop backwards

```JS
for(let i = arrayNames.length -1; i>=0,i--){
    console.log(arrayNames[i]);
}
```

### While-Loop

A while loop runs as long as the condition of the loop is true.

```JS
let rep = 1
while(rep<10){
    rep++;
}
```

For example when we don't know how many times the loop should run we can use a `while`-loop.
Role a dice till you get the value = 6

```JS
let dice = Math.trunc(Math.random()*6)+1;

while(dice!=6){
    console.log(`you rolled a ${dice}`)
    dice = Math.trunc(Math.random()*6)+1;
    if(dice=== 6) console.log('Loop is about to end...')
}
```

# Expressions vs Statement

_Expression_ is code that produces a value like `3+4`

_Statement_ is a bigger piece of code that doesn't produce a value

```JS
if(20>4){
    const str = "20 is bigger"
}
```

This doesn't really produces a value it just performes some actions.
So JS expect _Expressions_ and _Statements_ in differnt places.
In _Template Literals_ we can only insert expressions but not statements.

` console.log(``I'm ${2037-1991}``) `

# Functions

Functions are one of the main building blocks in JS. They work by taking an input, process the input and returning it. We can think of them like being machines that process input we give and return an output.

To write a function _declaration_ we write
`function name(parameters){...}`

To execute a function is also called _calling_/_running_ or _invoking_ a function. We then reference the function name and round brackets `name()`.

We can also pass values into a function to be processed in a function. These are called `Parameters`. Here in the example `a`and `b`.

```JS
//Function declaration
// input params
function add(a,b){

    // return a value
    return a +b;
}
//calling a function
add(4,5)
```

With functions we also can assign their return value directly to a variable
`let fruitMix = fruitMachine(apples,oranges);`

So when coding we should keep our code _dry_ which means we shouldn't repeat ourselves in our code. For that functions are super useful.

Functions are objects so they can be used as _expressions_(Function expression) allowing them be used as variables.
When we write function expressions we don't really define a name for the function so we create [anonymous functions](#anonymous-functions).

```JS
//Function expression
const add = function(a,b){
    return a +b;
}
```

Sometimes we need to write functions as expressions and sometimes as declarations.
So the difference between these two is that we can call the function declaration before they are defined.

```JS
const age = calculateAge(1982);

function calculateAge(birthYear){
    return 2025-birthYear;
}
```

We couldn't do that with _function expressions_.

It is personal preference to decide which way you use your functions.

In JS functions are also a value. That means we can do \*Method borrowing - copying a method from another object

```JS
const jonas = {
    name:"jonas",
    calcAge: function () {
        console.log("calculate")
    }
}
jonas.calcAge()

const matilda = {
    year:1992
}
matilda.calcAge = jonas.calcAge
matilda.calcAge()
```

Another way is to save a function in it's own variable

```JS
const f = jonas.calcAge
f()
```

### Anonymous functions

An _Arrow function_ is a shorter version to write a function expression.

```JS
//instead of
const calcAge = function(birthYear){
    return 2025-birthYear
}
// we can write
const calcAge = birthYear => 2025 - birthYear;
// To call the function
const age = calcAge(1991);

```

This works only if we just have a one line process in the function.

If we have multiple steps or multiple parameters we still need to go back to the brackets.

```JS
// one paremeter
const yearsTillRetirement = birthYear => {
    const age = 2025-birthYear;
    const retirement = 65-age;
    return retirement;
}
yearsTillRetirement(1990);
// multiple parameters for the function.
const yearsTillPayedDebt = (startYear,endYear) => {
    const yearsToPay = endYear - startYear;
    return `You have to pay ${yearsToPay} years.:(`
    }
yearsTillPayedDebt(2020,2099);
```

We also can construct higher-order functions where a function is used as an argument or a return value.

```js
function higherOrder(fun) {
  fun();
  return function () {
    //Do something
  };
}
```

Functions can also be nested to create _closure_, that incapsulates data and logic from the rest of the program.

Normally when you call a function that has a variable with a primitive value `let a = 10;` it is stalled on the _call stack_ which is the browsers short term memory.
When you call a closure the inner function can still acccess variables in the outer function and even after the initial function call. That happens because JS automatically stores the data in the outer function and the heap memory, which persists after the function call.

```JS
function giveMeClosure(){
    let a = 10;
    return function () {
        a++:
        return a;

    }
}
```

JS functions can only return one thing.

### Rest Pattern in Funktions
We can use the *Rest* pattern to unpack an undefined amount auf parameters into a function
```JS
const add = function(...parameters){
    let sum = 0;
    for(let i = 0;i<parameters.length;i++){
        sum += parameters[i];
    }
    console.log(sum);
}

add(2,4)
add(3,2,3)
add(3,4,5,6,6)

const x = [2,68,93]
add(...x);

```

# Arrays

_Arrays_ are a datastructure where we can collect different variables.
`const names = ['leon','ro','il'];`
another way is
`const years = new Array(1990,1991,1992);`

Arrays can hold any datatype that we want. We can add expressions into arrays and we can even put whole other arrays into an array.
Another possibility is to put function calls inside an array declaration.
`const ages = [calcAge(years[0]),calcAge(years[1]),calcAge(years[2]),calcAge(years[3])]`

To pick an element from an array we use square brackets `[]`
`const firstFriend = names[0];`.

To get the amount of elements in an array we use `.length`
`const len = name.length;`

To get the last element of your array.
`const lastElement = names[names.length-1];`

We can put any expression that we want inside of the square brackets to pick the element we want.

To change the data inside an array at a specific position.
`names[2] = 'Ju';`

Even though we defined an array as `const` we still can change its elements. But we can't exchange it with a whole new array.


## Array operations

### Add Element to the end of the array

With `.push()` we can add an element to the end of the array.
`friends.push('me')`

`.push()` returns the length of the new array.
`const newLength = names.push('name')`

### Add Element to the beginning of array

The `.unshift()` method allows us to put an element to the beginning of an array.

`names.unshift('Heinz')`
As `.push()` the `.unshift()` method returns the length of the new array.

`.push()` adds an element to the end of the array.

We also can add multiple elements in push
`array.push('word1','word2','word3')`

### Remove last element of an array

To remove the last element of an array we use the `.pop()` methods
`names.pop()`

The `.pop()` method returns the removed element from the array.

### Remove first element from array

With `.shift()` we can remove the first element from an array.
`names.shift()`
The `.shift()` method returns the removed element from the array.

### Get position of element in array

To find out which position a certain element in the array has we can use `.indexOf('variableName')`
`names.indexOf('me')`
If the element is not in the array the function returns `-1`

A function from new JS version is `.includes('variableName')`.
It returns a boolean if the element is in the array.

### Loop through array
So instead of using a `for` loop we also can use `for(const item of arrayName)`. This is meant to give you the current element. 
```JS
const menu = ["food1","Food2","food"]

for(const item of menu) console.log(item)
```
The `for of` loop also allows to use `break` and `continue`

If you still want the `index` but want to use the `for of` loop
```JS
for(const item of menu.entries()){
    console.log(item);
    
}
/*
[0, "food1"],
[1, "Food2"],
[2, "food"],
*/
```
`.entries()` creates an array of arrays with each child array having the elements of `index` and the `item`.

With further destructuring
```JS
for(const [i,el] of arrayName.entries()){
    console.log(`${i}:${el}`)
}
```



### Merge two arrays

Wie can use the `.concat()` function to merge two arrays.

```JS
const array1 =
const array2 =

const array3 = array1.concat(array2);
["a","b","c","d","e","f"]

```

### Find biggest/smallest element in Array

```JS
let max = testArray[0];
let min = testArray[0];
for(let i= 0; i<testArray.Length;i++){
    const curTemp = testArray[i]
    if(curTemp>max) max = curTemp;
    if(curTemp<min) min = curTemp;
}
```

### Ignore elements that aren't the type you look for

```JS

for(let i = 0; i<array.Length;i++){
    if(typeof array[i] !== 'number') continue;
}
```

### Empty an array

With `.splice` we replace the content of the array with nothing.
`array.splice(0,array.length)`

### Unpack all array elements
```JS
const arr = [7,8,9]
const badArray = [5,6,arr[0],arr[1], arr[2]]

const goodWay = [5,6,...arr];e
```
So the *spread* operator takes each element out of an array and adds them as a single element into another array.

### Expand existing array
```JS
const oldMenu = ["pizza","pasta","dumplings"]
const newMenu = [...oldMenu,"Choco"]//this creates a new array
```

To useful application for using the *spread operator* are creating shallow copies of an array
```JS
const menu = ["pizza","pasta","dumplings"]
const copiedMenu = [...menu]
```


and merge multiple arrays together into a new one
```JS
const menu1 = ["Dumplings","noddles with water"]
const menu2 = ["pizza","burger"]
const menu3 = ["IceCream","Tiramisu"]
const allDishes = [...menu1,...menu2,...menu3]
```

The *spread operator* works on all iterables: arrays, strings,maps,sets. But NOT objects.


### Rest pattern - Collect unspecified elements in assignment
The *rest pattern* allows us to pack elements, that aren't specifically assigned, into an array.
Always use the *rest pattern* as the last element.

```JS
const [a,b,...others] = [1,2,3,4,5]
console.log(a) -> 1
console.log(b) -> 2
console.log(others) -> 3,4,5
```

## Input multiple values into array via prompt
```JS
const inputs = [prompt("Input 1?"),prompt("Input 2?"),prompt("input3")]
```

## Array Destructuring
to destructure an array we can use `[]` to assign elements
```JS
const arr = [2,3,4]
const [x,y,z] = arr
```

Only taking the first and the last element
```JS
const arr = [2,3,4]
const[x,,z] = arr
```

This makes also switching the order easier
```JS
[main,secondary] = [secondary,main]
```

With destructuring we can have a function returning an array and then directly destruct the result into different values
```JS
...
const restaurant = {
order: function(starterIndex,mainIndex){
    return [this.starterMenu[starterIndex],this.mainMenu[mainIndex]];
}
}
//Destructuring the returned array
const[starter,main] = restaurant.order(2,0)
```
To destructure a nested array
```JS
const nested = [4,5,[6,3]]
const [i,,[j,k]] = nested;
//i = 4
//j = 6
//k = 3
```

Sometimes it is useful to set *default values*  when we destructure arrays. For example when we get data from an api
```JS
const [a=1,b=2,c=3] = [8,9]
a = 8
b = 9
c = 3
```
## Get Value from prompt

We can use the `prompt()` function to ask the user to input a value.
`const favNumber = prompt("What is your favorite number")`
It returns a string.

# this

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

Read more about `this` [here](#this-keyword)

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

# Objects

An object contains a collection of _key:value_ pairs or properties and values.
A _key_ in the object is called _property_.
The order of the values in an object doesn't matter at all. We reference values by their _key_
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

### Retrieve data from object

The first way to get a property from an object is the `.` notation:
`const humDNA = human.dna`
The other way is to use the `['keyName']` way
`const humDNA = human['keyName']`
The difference is that with the brackets way we can put any expression inbetween the brackets. So we can compute it from a calculation

### Add new property to the object

To set no properties to the object we again can use both ways
`human.eyeColor = 'blue'`
`human['eyeColor'] = 'blue'`

### Object methods

In JS functions are just like a value which means we can add functions to an _key:value_ pair in an object. Any function added to an object is called _method_.
We can reference the name of the function as a key and the value as an expression. In Objects we need a function expression instead of a definition.

```JS
const human = {
    ...,
    calcAge: function(birthYear){
        return 2037 - birthYeah;
    }
}

console.log(human.calcAge(2099))
console.log(human['calcAge'](2099))
```

If we want to access a inside the object a variable from within we can use the `this.` keyword. It is equal to the object calling the method.

```JS
const human = {
    birthYear:1991,
    calcAge:function(){
        return 2037 - this.birthYear
    }
}

```

To avoid multiple calculations we can calculate a value once then store it in the object and then can retrieve it later as a property from the object.

```JS
const human = {
    birthYear: 1991,
    calcAge: function(){
        this.age = 2037-this.birthYear;
        return this.age;
    }
}
```

### Destructure Objects
To destructure objects we use `{}`
```JS
const object = {
    name:"me",
    location:"world"
}

const {name,location} = object
console.log(name,location)
```

To change the *variable names* from the *property names* we
```JS

const {name:newName,location:newLocationName} = object;
console.log(newName,newLocationName)
```

To set default values for a property that may not exist in the object. If it exists the default values get's overwritten.
```JS
// sets menu to empty 
const {name,location,menu = []} = object;
console.log(name,location,menu)
```

#### Mutating variables while destructuring objects
In order to mutate the variables `a,b` while destructuring our object we need to put it inside `()` to make it work.
```JS
let a = 111;
let b = 999;
const obj = {a:23,b:7,c:14};
({a,b} = obj);
console.log(a,b);
```

#### destructure nested objects

```JS
const object = {
    feed: {left:43,
        right:44
    }
}

const {feed:{left:l,right:r}} = object;
console.log(l,r)
```

this allows to use destructuring inside functions for example
```JS
const order = {
    food:"pizza",
    time:14
}


function orderSomething({food = "none" ,time = 0}){
    console.log(`Order received: ${food} at ${time}`);
}

orderSomething(order);
```

### Spread operation on objects
```JS
const object1 = {
    name:"rolfo",
    location:"Berlin"
}

const object2 = {...object1, weather:"good"}
```

### Shallow copy of object
```JS
const object2 = {...object1}
```

### Rest operations on objects - Collect unspecified elements in assignment
The *rest pattern* allows us to pack elements, that aren't specifically assigned, into an object.
Always use the *rest pattern* as the last element.

```JS
const object = {
    a:0,
    b:2,
    c:4,
    d:6,
    f:8
}

const {myA,myB,...others} = object
console.log(myA) -> 0
console.log(myB) -> 2
console.log(others) -> {c:4,d:6,f:8}
```

### Enhanced Object Literals

With *Enhanced Object Literals* we don't need to reassing objects from outside an object with the variable name. We just implement it as an element.
```JS

const openingHours = {
    mon: {
        open:0,
        close:24
    },
    tue: {
        open:0,
        close:24
    }
}


const restaurant = {
    name:'my restaurant',
    openingHours
    //dont need openingHours = openingHours
}
```

Also methods doesn't need to be declared with function

```JS

const restaurant = {
    ...
    order(starterIndex,mainIndex){
        return [this.starterMenu[starterIndex]]
    }
    ...
}
```

Another enhancement is that we can compute the variable names inside the object
```JS
const weekdays = ['mon','tue']

const openingHours = {
    [weekdays[0]]: {
        open:0,
        close:24
    },
    [`day-${2+4}`]:{
        open:2,
        close:20
    }
}
```


### Optional Chaining
With *optional chaining* `?.` if a certain property does not exist `undefined` will be returned.

`console.log(restaurant.openingHours.mon?.open)`

We also can check for multiple properties

`console.log(restaurant.openingHours?.mon?.open)`

```JS
const weekdays = ['mon','tue','wed','thu','fri','sat','son']
const openingHours = {
    [weekdays[0]]:
    {
        open:0,
        closed:23
    },
    [weekdays[1]]:
    {
        open:0,
        closed:23
    },
    [weekdays[1]]:
    {
        open:0,
        closed:23
    },
}

for(const day of weekdays){
    const open = openingHours[day]?.open ?? 'closed';
    console.log(`On ${day}, we open at ${open}`);
}
```

This also works for *methods*
`restaurant.oder?.(0,3) ?? 'Method does not exist'`

And on arrays to check if an array is empty
```JS
const users = [{name:"me",email:"Hallo world"}];
console.log(users[0]?.name ?? "User array is empty")
```
# OOP

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

# Other Datastructures

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

JS is _garbage collected_ which means it will automatically deallocate objects from memory when they are no longer referenced in the code.

With Maps and Sets all your properties will always be referenced.
For optimization there is `WeakMap()` and `WeakSet()` that contain properties that can garbage collected and the memory reduced.

# Non blocking event loop

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
In order to share code with other files we can make the code _default export_ by assigning `export default function name`.

Then we can import it in another file with
`import functionFun from './help.js';`

we also can export and import variables
`export const hallo = 344;`
`import {hallo} from '.help.js';`

# Node package manager

To use code from other developers we can use _npm_ javascript package manager
We can install packages with `npm install`. It downloads the code it in the `node_modules` folder. It also provides a `package.json` file that list out all the dependencies that you use in your project.

# Js in Browser

The browser is based on _document object model (DOM)_ where the UI is based on a structured tree of html elements.
![HTMLDOMStructure](./img/HTMLDOMStructure.png)

It allows JS to access HTML elements and style to manipulate them

When JS interacts with an element from the website it is called _Dom manipulation_

A browser provides an api to interact with these elements with `window.document`.

The DOM methods and properties are part of the WEB APIs that browser implement.

## Grab element from html

The `document` allows us to grab an individual html element using the `.querySelector()`
it takes a css selector as an argument and will find the html elements that has the same classname`.className`, id `#idName` or tag name. It returns an instance of the element class.
If there are multiple instances with the same className `querySelector()` will pick the first the first element.
To grab multiple elements at the same time with `.querySelectorAll('.button')`

## Select and manipulate elements

We can select an element by it's class
`document.querySelector(.message).textContent = 'new Text'`

or select it by an elements unique id
`document.querySelector(#id).textContent = ...`
`document.getElementById('id').textContent = ...`

### Get and Set values Input field

`document.querySelector(.inputField).value` <- This returns a string
Converting into a number
`Number(document.querySelector(.inputField).value))`
Setting value of input field.
`document.querySelector(.inputField).value = 10`

## Grab text from element

`document.querySelector(.message).textContent`

## Handling Click Events

When we want our javascript to react to something that happens in the dom we need to listen to the
event that happen to the element. For example when a btn is clicked, we can assign a function that gets called when the button gets clicked.

Every time an event happens JS creates an event object which allows us to get information about the specific event.

```JS
const btn = document.getSelector(.btn);
const btn2 = document.getSelector(.btn2);
btn.addEventListener('click', () => {
    //Only gets called when the event happens
    console.log('clicked')
})

btn2.addEventListener('dblclick',function () {
    console.log("hallo")
})
```

## Handling KeyPressed Events

The keypress event is a global event. For global events we usually listen to the whole document

```JS
document.addEventListener('keydown',handleEscKey)

const handleEscKey = (e)=> {
    if(e.key === "Escape"){
        console.log(`${e.key} pressed`)
    }
}

```

There are three key events
`keydown` - when we put down the key
`keypress`- fired while we have finger on the keyboard
`keyup` - when we lift our finger up from the keyboard

## Manipulate CSS styles

To manipulate the css style we have to access the html element and then the `style` property.
Whenever we manipulate a style we have to specify a `string`. We can't write a number.

`document.querySelector(body).style.backgroundColor = '#60b347'`

`document.querySelector(.message).style.width = '30rem'`

The changes get applied as `Inline Styles` so the css files doesn't get changed or manipulated
It looks like `div class="message" style="width:30rem">text</div>`
The `Inline Styles` overwrite the properties of css file.

Why is that new info

## Manipulate classes

To check if an element contains a class we can use
`if(elemnt.classList.contains('hidden'))`

We can use JS to `remove` classes from an html element. For example we can have a modal which has the class

```CSS
.hidden{
    display:none;
}
```

We then call `myElement.classList.remove('hidden')` and the class is removed and the element is shown on the screen.

To add a class we can call `modal.classList.add('hidden')`

We also can use `myElement.classList.toggle('hidden')` this will add a class if it's not there and remove a class when
it already exists

# Math

## Cut of decimal part of number

We can call `Math.trunc()`
`Math.trunc(Math.random()*20)`

# Front-end frameworks

Many developers use front-end frameworks that produce declerative code where the UI is a function of its input data /states.

These frameworks encapsulate JS, HTML,CSS into components. Inside a components the data is reactive. It can be bound from js directly to html

# Bundle

Module bundler

# Network waterfall

# Dynamic imports

Only import bundle when it is needed

# Let JS reload automatically when code is changed

We can use the VSCode extension Live Server or we can set up our own node.js server

## Run Javascript on a server

With node.js is a javascript runtime. It allows us to run javascript outside of a browser and on a server.
with `node` command we can execute javascript.

### See if node is installed

`node -v`

### Install live server

`npm install live-server -g`

`-g` install globally

On mac you might need `sudo` in front of npm.

### Run live server

Call live server
`live-server`

# Strict Mode

Strict mode assures that we write secure JS code.
For that we just add `'use strict'` at the beginning of our code.
It needs to be the first line in the code.

Strict mode also blocks the usage of certain variable names that JS has blocked to use because it might use them in the future. Like `interface` or `private`

##

Electron node.js with the browser to create app
react native to build whole apps

typescripts

# DOM

Document Object Model
What every browser uses to model all the html elements on a webpage.
![DOM Structure](../JS/img/DOMStructure.png)

# Errors

### Unexpected token

You used a wrong variable name.

# How to Learn to Code

## What can you do wrong

- dont have clear goal
- just copy the code without thinking what the code means
- dont reinforce what you learned by doing small challenges
- dont practise coding
- dont create own project ideas
- quickyl become frustrated
- lose motivation because you think you never can know everything
- learn in isolation

## What do write

- write down your specific,measurable,realistic and time-based goal on a piece of paper. I want to become a web developer in 6 month.
- Always type the code
- Understand the code
- Use immediately what you learned.
- Take notes
- Challenge yourself
- practise coding on your own - come up with your own project ideas.
- dont be stuck in "tutorial" hell
- you will never know everything
- Even devs after 20 years struggle to get their code to work and it is a tedious slog.
- Never learn in isolation - explain new concepts to other people.
- Share your learning progress with web dev community #100DaysOfCode #CodeNewbie #webdev
- Keep challenging yourself, run into lots of problems and fix them

# How to think like a developer

How to solve problems in coding:

- stay calm and slow down - don't jump at a problem without a plan
- take a logical and rational approach
- Framework:

1. Take a step back and make sure you understand 100% the problem:

   - Ask right questions to get a clear picture of the problem
   - What does ... mean?
   - What should we do if something else happens?

2. Divide and conquer:

   - Break big problem into smaller sub-problems.

3. Do as much Research as possible

4. For bigger problem write pseudo code before writing actual code.

# See objects as a Table in Console

`console.table(object)`

# Debugger in Chrome

In the debugger under `Sources` we can set breakpoints to evaluate values at a certain stage.
You can find the debugger next to console under sources.

Don't forget to unselect the breakpoint at the end.

# Bundler

Bundler is a tool in which you send assets like JavaScript,Css,HTML,images, TypeScript. The bundler handles these assets, applies potential modifications and output a _bundle_ composed for web friendly files like HTML,CSS,images and JS. Like a pip in which you send non-web-friendly assets and at the end of the tube you get web-friendly assets back.

Bundler can do even more. You can use a bundler to create a local server, manage dependencies, improve compatibility, support modules, optimize images, deploy on a server, minify the code, etc.

# Webpack

Webpack is most popular bundler.




# JS behind the scenes

Every software need to use some hardware resources like cpu and memory to run.
In Low-level languages like c you have to manually manage these resources.
In high level languages we don't have to manage the resources. They have abstractions that take care for us.

Garbage Collection takes memory management away from the developer. Its an algorithm that automatically removes
old unused objects from the computer memory. Like a cleaning guy that cleans up for us.

JS is an interpreted/just-in-time-compiled language.
A computers processor only understands 0 and 1 - which is called as machine code.
We write human readable javascript code which is an abstraction from machine code. And this code needs to be translated
into machine code by the compiler/interpreter. This happens inside the javascript engine.

Javascript is a multi-paradigm language. A paradigm is an approach of structuring code.
Three paradigms are:
_Procedural programming:_
Organising code in a linear way with some functions in between.

_Object-oriented programming(OOP):_
In JS OOP is a prototype based object oriented approach: almost everything in JS is an object except primitives like numbers,string etc. Arrays are objects for example.
We create arrays from an array blueprint - which is like a template - and this is called `Prototype` - `Array.prototype.push` for the `.push()` method.
The prototype contains all the methods.
The array in our code then inherits all the methods from the blueprint.

_Functional programming(FP):_

Many languages are only procedural,oop or functional, but javascript does all of it. That makes it super flexible.

JS is a language with `first-class` functions, _functions that are treated as variables_.
We can pass into other functions and return functions from functions.

Javascript is a `dynamic-typed` language - we don't assign datatypes to variables. They only become known when the engine executes the code.
Also the type of variables can easily be changed.
If you want to use JS with types you can use `Typescript`

Concurrency model is how the engine handles multiple tasks that are happening at the same time.
JS runs in one single thread - it only can do one thing at a time.
In computing a thread is a set of instructions executed in the cpu. Where the code is executed in the processor.

To avoid that long task are blocking the single thread we create an event loop. The event loop executes these tasks in the `background` and puts them back in the main thread once they are finished.

## Javascript Engine and Runtime

A Javascript engine is a program that executes JS code. Every browser has its own javascript engine but the most well known is googles v8 engine which powers chrome and node.js.

Any JS engine contains a `call stack` and a `heap`.
A `call stack` is where our code gets executed - using execution context
A `Heap` is a unstructured memory pool which stores all the objects that our application needs.

How is the code compiled to machine code?
There are two ways how code gets converted into machine code

### Compilation

The entire code is converted into machine code at once - written to a binary file that can be executed by a computer.
Two steps:
Source code -> COMPILATION = machine code -> EXECUTION = program running

### Interpretation

Interpreter runs through source code and executes it line by line.
Source code -> EXECUTION line by line = program running

The source code gets converted into machine code right before execution - not ahead of time.

Modern JS now uses a mix of interpretation and compilation - _Just-in-time compilation_
Compiles the entire code in machine code once and executes it right away.

### JS Engine example

![JS Engine](./img/JSEngine.png)
As JS code enters the engine the first step is to `Parse`/read the code.
During the `Parsing` the code is parsed into a data structure called abstract syntax tree - AST.
Every line of code that is meaningful to the engine gets spit up in pieces and then saving
all the pieces into the tree in a structured way. It also checks if there are syntax errors.

Next step is the compilation which takes the generated AST and compiles it into machine code.
This machine code gets executed right away. The execution happens in the `Call Stack`.

Modern JS engines have optimisation strategies where they first create unoptimised version of machine code
so it can start executing as fast as possible. Then in the background code is optimised and recompiled in the background multiple times.

### JS Runtime

Browsers are JS Runtime.
A JS runtime is like a big box which includes all the things that we need to use JS.
At the heart is always the JS Engine.
In order to work properly the engine needs access to apis like `DOM`, `Timers`,`FetchAPI`. WebAPIs are functionalities provided to the engine but not part of JS language. JS get's access to theses apis over the gloabel `window` object.

![alt text](./img/JSRuntime.png)

A typical JS runtime also contains a `Callback queue` which is a data structure that contains all the callback functions.
We attach eventHandler functions to DOM elements to react to certain events. These event handler functions are called `Callback functions`.
As the event happens, e.g. `click`, the callback function will be called - the callback function is put in the callback queue. When the call stack is empty the callback function is passed into the call stack so it can be executed. This is caused by the event loop - it takes callback functions from the callback queue and puts them into the call stack so they can be executed.

### How is JS code executed

When the compilation is finished a `global execution context` is created for the top level code - code that is not inside a function. So only the code outside of functions is executed because you only want to execute the functions when they are called.

A `global execution context`is an environment where JS is executed. It stores all the necessary information for the execution like variables or arguments passed into a function.

In any JS project there is only one `global execution context`.

Once the top level code is processed functions get executed as well. For each function call one execution context is created - containing all the necessary information to run the function.
All these execution contexts make up the call stack.

Inside a execution context is:

- Variable environment: `let`, `const` and `var` declarations
  - Functions
  - `arguments` object
- Scope chain
- `this` keyword

Arrow functions don't have `arguments` object nor `this` keyword.

![alt text](./img/ExecutionContext.png)

The `Call Stack` is where the execution contexts get stacked on top of each other in order to keep track of where we are in the program execution.
So the execution context that is on the top of the stack gets executed. When it's finished it gets removed from the stack and the next execution context gets processed.

If the program is completely finished also the `global execution context` is popped out of the call stack.

### Scope and Scope chain

Scoping defines how the variables are organized and accessed in our program.
"Where do they live and where can we access a variable"

In JS we have `Lexical scoping` - scoping is controlled by `placement` of functions and blocks in the code.
A function inside another function has access to the variables of its parent function.

```JS

function func1(){
    func2()//Has access to the variables of func1
}
```

`Scope` environment in which a certain variables and functions is declared: `global`, `function`and `block` scope.

`global` - Outside of any function or block; variables are accessible _everywhere_
`function` - Each function creates a scope in which its variables are accessible - also called `local` scope - local life in the functions and are not accessible outside of the function
`block` - from ES6 blocks also create a scope. So for example variables created in an if block have there own scope in the if block. Same for for block etc. This applies only to `let` and `const` variables. `var` would be accessible in the function or global scope.

From ES6 all functions are also `block` scoped - so only accessible inside that block

`Scope of variable` region of code where variable can be _accessed_

Every scope has access to all variable from all outer scopes. You can see that `second()` has access to the variables of the `first()` function and the `global` scope.

```JS
const myName = "Leo";

function first() {
    const age = 30;

    if(age>=30){
        const decade = 3;
        var millenial = true;
    }
    function second(){
        const job = "worker";
        console.log(`${myName} is a ${age}-old ${job}`)
    }
    second()
}
first()
```

So a function looks in itself if it can find the variable, if not it looks up in the next outer scope.
This is called _variable lookup in scope chain_. One `scope` can only look up in the scope chain not down.

![Scope Chain](./img/ScopeChain.png)

### Hoisting

Makes some types of variables accessible before they are declared in the code.
Behind the scenes - before the execution the code is scanned for variable declarations - for each variable found, a new property is created in the variable environment object.

It doesn't work the same for all variable types.
![HoistingOverview](./img/HoistingOverview.png)

`function` declarations are hoisted and the initial value is the actual function - we can use function declarations before they are actually declared - because they are stored in the variable environment object before the code starts executing.

`var` variables also are hoisted but we don't get the declared value we get the initial value `undefined`. One of the reason why we almost never use `var`

`let` and `const` are not hoisted - they are set to `<uninitialized>` no value at all - not even undefined. These variables are placed in the `TDZ` [temporal dead zone](#temporal-dead-zone).

`function expressions and arrows` depend on if using `var` `let/const`

```JS

console.log(addDecl(2,3));// -> Works
console.log(addExpr(2,3));// -> Doesn't Work
console.log(addArrow(2,3));// -> Doesn't Work -> AddArrow function is undefined(2,3)

function addDecl(a,b) {
    return a+b;
}

const addExpr = function(a,b) {
    return a+b;
}

var addArrow = (a,b) => a+b;
```

#### Temporal dead zone

![alt text](./img/TemporalDeadZone.png)
The `const job = 'teacher'` will only be accessible from the line it is defined because
the lines before lies the _Temporal Dead Zone_ of that `job` variable - so we can't use it there. The region where the variable is defined but can't be used anyway - as if the variable doesn't even exist.

In the first `console.log()` with the `job` variable we get an
`ReferenceError: Cannot access 'job' before initialization` error.

The `TDZ` got invented to catch errors like accessing variables before declaration.
It also allows `const` variables to not be reassigned.

Hosting got invented to make it possible to use functions before there actual declarations.

### this keyword

`this` keyword is special variable that is create for every execution context / every function.
`this` keyword will always take the value of the _owner_ of the function in which the `this` is used - it points to the owner of the function.

The value of `this` is depends on how the function is called - _NOT_ static.
`this` is only assigned when the function is called.

`Method` - `this` -> Points to Object that is calling the method

```JS
const jonas = {
    name: 'Jonas',
    year: 1889,
    calcAge:function () {
        return 2037 - this.year;
    }
}
jonas.calcAge()
```

Here `this.` points to `jonas`

_Global scope_

```JS
//global scope
console.log(this)
//returns the window object
```

`Simple function call` - `this`-> undefinied(in strict mode) Otherwise points to `window`

```JS
const calculate = function(a,b){
    console.log(this)
}
calculate(1,2)
//Return undefined
```

`Arrow functions` - `this` -> `this` of the function that surrounds the arrow function

```JS
const calculate = (a,b) => {
    console.log(this)
}
calculate(1,2)
// returns the window because it is the surrounding "function"/scope of the arrow function
```

`Event listener` - `this` -> DOM element that the handler is attached to

`this` doesn't point to the _function itself_ nor the _variable environment_

Never user an arrow function as a method in an object
```JS
//Dont do this!!!!
const hans = {
    ...
    greet: ()=> {

    }
}
// Use a normal function
const hans = {
    ...
    greet: function() {
        concole.log(this)
    }
}
```

### Arguments Keyword
Regular Javascript functions have an arguments keyword which store all the passed arguments. 
It is also possible to pass more arguments than specified into a function. But you can't use it in arrow functions.
```JS
const addExpr = function(a,b) {
    console.log(arguments);
}

addExpr(2,5,40,45)
//-> agrumentsArray[2,5,40,45]
```

### Memory Management: Primitives and Objects
Memory management is how JS allocates space in memory to create variables and later frees up the memory.
Every value in the program goes through a memory lifecycle.

In the lifecycle:
- When a variable gets created a peace of memory gets allocated
- Then whenever the variable or its value is used the memory gets used.
- When the variable is not used anymore the memory is released.

For different types of values memory is allocated in different places in the JS Engine.

Values are ether primitive types or objects in JS.

Objects get stored in the `Heap` of the JS Engine and primitive values get stored in `Call Stack`.

Object Variables in the call stack don't hold the objects themselves but references to the objects in the heap
References to objects are also stored in the `Call Stack`
![Object Reference](./img/ObjectReference.png)

When we copy a variable that contains a reference to an object then we only copy the reference to the object.
But we have to be aware that if we change a value in the copied variable it will also change the value in the original object because we overwrite the reference and both elements have the same reference.
![Changing Object Reference](./img/ChangingObjectReference.png)

So to properly copy on object and not copying the reference we need to use the spread operator `...`
```JS
//Shallow copy
const object = {
    name:"franz",
    age:20
}

const objectCopy = {...object}
```
But be aware this only creates a `shallow` copy. It copies the `primitives` but if the object would contain another object/ a object reference it wouldn't really make a unique copy of the object reference.

To create a *Deep copy/clone* for example when we want to manipulate a big object in our code and make sure that the original data isn't affected by these changes.
```JS
//Deep copy/clone
const objectClone = structuredClone(object);
```

### Memory Management: Garbage Collection
*Call stack*
Variable environment is simply deleted when execution context pops off stack
![EC Pops](./img/ECPops.png)

*Heap*
In order to clean up old unused objects from the heap JS uses `Garbage Collection`. The JS Engine runs `Garbage Collection` automatically whenever it thinks it is necessary. The developer can't instruct to do it.

*Mark-and-sweep-Alogrithm*
1. Mark all objects that are *reachable* from a root/starting point like global and other execution context as "alive".
If objects can be reached object is considered alive.
2. Sweep - Delete all un-marked objects and reclaim memory for future allocations.
![Sweep](./img/Sweep.png)
When  the getTasks() finishes execution and the execution context pops of the stack, the garbage collection deletes the objects from getTasks() because they aren't reachable any more.

Any globally defined object will never be garbage collected because the `Global EC` exists whe whole lifetime of the program.

*Memory Leaks*
When an object that is no longer needed by the program is incorrectly still actively reachable by the garbage collection from one of the roots. So the object is marked as alive and not deleted.
Forgetting to throw away stuff that you don't use anymore.

Often old and undesired reference happen from event listener and timers. If a timer creates an object this object will always be reachable unless the developer deletes the timer when not needed anymore.
Same for event listeners.
Also avoid declare large objects as global objects because they will never be garbage collected