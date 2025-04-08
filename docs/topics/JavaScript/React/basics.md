---
comments: true
tags:
  - Javascript
  - React
---

# Basics

React is a JS library for building dynamic and interactive user-interfaces.

With React we describe a webpage with small reusuable components and react will take care of creating efficient DOM elements.

Components help us write reusuable, modular and better organized code.

We build components individually and then combine them to build the page.

React app is a tree of components with the `App.js` bringing all together.

# Setup development environment

You need node 16 or higher.
`node -v` to check your version.

_Prettier Code format_ extension for formatting code.
Then preferences settings - format on save

# Create a React App

We can use _Create React APP (CRA)_ or
_Vite_
_Vite_ has the advantage of being faster and smaller bundle sizes.

To use _Vite_
`npm create vite@latest` or when you want a specific version `npm create vite@4.1.0`

Then select the framework - choose _React_ and JS or Typescript

Then move into folder and install `npm install` all dependencies and run the _development server_
`npm run dev`

# Project structure

_node_modules_ folder - where all the third party libraries are installed

_public_ folder - where public assets lie - videos, images etc.

_src_ folder - source code of application

_app.tsx_ is the app component.

_index.html_ - html template contains div with container for application.

_main.tsx_ - entry point to application

_package.json_ - info about the application

_tsconfig.json_ - typescript configuration file - telling the compiler how to compile code to JS.

_vite-config.ts_ - configuration file for vite

# Create a React Component

Extention of typescript files should ether be `.ts` or `.tsx`
`.ts` for plain typescript files
`.tsx` for react components.

There are two ways to create a component. As a JS class or as a function. Today many use functions based components because they are easier to write.

We declare a function with `PascalCasing` because React expects it.

```JS
function Message(){
//what does the UI look like
//JSX: Javascript XML
return <h1>Hello World</h1>

//To use the component somewhere else you need to export it
export default Message;
}
```

At [babeljs.io](http://babeljs.io/repl) you can see how the code gets converted to JS.

If you now want to use the component in your `App.tsx` you need to import it.

```JS
import Message from './Message'

function App(){
    return <div><Message/></div>
}
export default App
```

To implement values or functions in to the code

```JS
function Message(){
    const Name = 'myName'
    if (name)
        return <h1>{Name}</h1>
    return <h1>Hello world</h1>
export default Message;
}
```

# How React works

The App component is the Root component of the app and the message as a child.
When the application starts React takes the components tree and builds a JS data structure called the _Virtual DOM_ which is a lightweight in memory representation of the component tree which each node represents a component and its properties.

When the state or data of a component changes React updates the corresponding node in the virtual DOM to reflect the new state then compares the current version of the virtual DOM with the previous version to identify what nodes need to be updated. It will then update those nodes in the actual DOM.
The updating of the DOM gets done by `react-dom` library.

In `main.tsx` we use `ReactDOM` to render the component tree inside of an element with the id _root_.

`React.StrictMode` is a component that doesn't get rendered and it is used to identify potential problems.

So we render the structure via the `ReactDom.createRoot`.
We also could render it via `React Native` for mobile phones etc.

# Library vs Framework

A _Library_ is a tool that provides specific functionality.
A _Framework_ is a set of tools and guidelines for building apps

# Routing

Navigation from one page to another.

# Importing other libraries and frameworks

We can for example import other libraries like Bootstrap to make the styling of the website easier.

# Create a List group component

Inside the components folder we can create a new file `ListGroup.tsx` and borrow some code from Bootstrap

```JS
function ListGroup(){

    return (
        <h1>List</h1>//React.createElement("h1")
        <ul className = "list-group">
            <li className="list-group-item">An item</li>
            <li className="list-group-item">An item</li>
            <li className="list-group-item">An item</li>
            <li className="list-group-item">An item</li>
            <li className="list-group-item">An item</li>

        </ul>
    )
};
export default ListGroup
```

# Fragments

In React a component can't return more than one element that means we need to wrap all the elements inside one element
that the component can return.
We could use a `<div>` but that creates an extra element in the DOM which we try to avoid.
For that there are React `Fragment`. They also wrap the JSX content but don't create an extra DOM element.

```JS
import {Fragment} from 'react';
function ListGroup(){
    return(
        <Fragment>
        <h1>List</h1>
        <ul className = "list-group">
            <li className="list-group-item">An item</li>
            <li className="list-group-item">An item</li>
            <li className="list-group-item">An item</li>
            <li className="list-group-item">An item</li>
            <li className="list-group-item">An item</li>

        </ul>
        </Fragment>
    )
}
```

But there is even a shorter version of that to tell React without needing to import `Fragment`.
We can use `<>` brackets

```JS
function ListGroup(){
    return(
        <>
        <h1>List</h1>
        <ul className = "list-group">
            <li className="list-group-item">An item</li>
            <li className="list-group-item">An item</li>
            <li className="list-group-item">An item</li>
            <li className="list-group-item">An item</li>
            <li className="list-group-item">An item</li>

        </ul>
        </>
    )
}
```

# Render List dynamically

In React we don't have a for loop to for example go through all elements of data and show it on the screen.
But we can use the JS Array function `.map()` that is used to convert each item into an item of a different type.

So we can take each item of our data and convert it into a JSX `<li>`element.
It is important that we map each item with a specific `key` property that uniquely identifies that item.
React needs it to keep track of all the items.

```JS
function ListGroup(){
    const data = ["London","Paris","Milan","Madrid"]
    return (
        <>
        <ul className = "list-group">
            {data.map((item)=>(
                <li key={item}>{item}</li>
            ))}
        </ul>
        </>
    )
}
```

In JSX we only can use HTML elements or other React components.
We can't just write expressions inside a JSX markup. We need to wrap it with `{}`.

# Conditional Rendering

In JSX we can't write if statements to for example show things dynamically. So we again can wrap
components and parts of our code in `{}` to create expressions inside to decide what gets rendered. To also not fill
up out JSX we can save it in a variable outside of it and just reference it. We are using
ternary expression so we can return null (item is not gonna get shown) if a condition is not true. Or we also can move
the logic inside a function. This allows us to use parameters and show different messages depending on the parameter.
If you don't use any parameters just use the const variable.

```JS
function ListGroup(){
    const data ...
    const message = items.length === 0 ? <p> No item found</p> : null
    // const getMessage = () => {
    //     items.length === 0 ? <p> No item found</p> : null
    // }
    return(
        <>
        <h1>List</h1>
        {message}
        <ul className="list-group">
            {items.map((item,index)=>(
                <li className="list-group-item" key={item}>{item + ` `+index}</li>
            ))}

        </ul>
        </>
    )
}
```

There is a better way to write the code so we don't have to write the `: null` at the end.
So we take the condition but instead of using the ternary operator `?` we use a logical `&&` and the element we
want to return if this condition is true.
`{items.length === 0 && <p>No items found</p>}`

So it works because if the first expression is true the result of the whole expression will be the second part.

`true && 'hallo' -> hallo`

## Check if element is not empty

```JS
<div className="Link-button">
  {project.url && (
    <a href={project.url}>Link</a>
  )}
</div>
```

# Handling events

In React each element has a prop(erty) `onClick={}` we can ether write an expression inside of that
or we reference a function.

```JS
...
{items.map((item,index)=>(
    <li key ={item} className="list-group-item" onClick={()=>console.log(item,index)}>
    {item}
    </li>
))}
```

The arrow function `()=>` can have a parameter that represents the browser event with `e` or `event`
`(e)=> console.log(event)`
With that we get properties of the object which contain for example the clicked `target` object or the position where we clicked.

To leave the code more easier to grasp we should move the logic into it's own function.

```TS
...
const handleClick = (event) => {
    console.log(event)
}
```

But this code would give us an error in typescript.
` Parameter ``event`` implicitly has an ``any`` type `.
That meets the Typescript compiler doesn't know the type of this parameter. So we need to specify
the type of our parameter to get type safety and also autocompletion for parameters.

We can hover over the parameter in the JSX Version to see the type of the event

```tsx
<li onClick={(event)=>console.log(event)}>
```

We then see that event is `React.MouseEvent` type. So to avoid the error in our function we need to first import
the Reference into our component `import {MouseEvent} from 'react'`. And then specify the `event:MouseEvent` so typescript
knows the type. This is called _Type annotation_ in React.

We then reference the function in the `onClick={handleClick}` property.

# Managing State

If we have a variable that keeps track of a selected index it makes sense to initialize it with the index `-1`
`let selectedIndex = -1`

We then can use it for example render elements with different classes. For example active class or non active class

```JS
...
{items.map((item,index)=>(
    <li
    className={selectedIndex === index ? "list-group-item active":"list-group-item"}>...</li>
))}
```

When we click on an item, we then can change the index of the selected item.

The variables that you declare in your component is local to that component. That means that React is not aware of it.
So to make the variable available and be usable by React we tell it that this component has data or state
that are changing over time.
To do that we use a build in function from React `useState()`. The `useState()` function is a _Hook_ which are
functions that allow us to access build-in React functionality.

To declare that variable we can set the initial value in the round brackets. `useState` returns an array
with two elements:

```JS
const arr = useState(-1);
arr[0]//variable(selectedIndex)
arr[1]//updater Function to update the variable state

//we destructure the array into two elements
const [selectedIndex,setSelectedIndex] = useState(-1);
```

When we use the updater function React will be notified and it knows that the state of our component has changed
which leads to rerendering that component which also causes the DOM to be updated.

Generally about state - each component has its own state. So if we for example have two of the components in your
App() each of the component has it's own state.

# Passing Data via Props

To make a component reusable we use Props so we can insert information into an component. So for example we should
be able to pass the data into our component so we can use the same component for different data.

First we need to decide the structure of the input that we want to pass into the component.
For example we want to pass and object with two properties `{items:[],heading:string}`
We can use a Typescript feature `interface`

```JS
interface Props{
    items:string[];
    heading:string;
}

function ListGroup(props:Props){
    ...
    {props.items.length ...}
}

// To avoid the props keyword we also can decontruct it in the function declaration

function ListGroup({items,heading}:Props){
    items....

}


// in the Parent component

function App(){

    return(
        <div>
        <ListGroup items={items} heading="Cities">
        </div>
    )
}
```

# Passing Functions via Props

Often in projects we want something to happen after for example an item gets selected. Because we want a reusable
component we don't want to handle that behavior inside the component but outside of the component.

So we need a mechanism to notify the consumer/parent of the component that an item is selected.
We can implement a function in the _Props interface_ that notifies the parent that something happened.
So when an item gets selected we call the function and then the App component will get notified.

```JS
interface Props{
    items:string[];
    heading:string;
    onSelectItem: (item:string)=> void;
}
function ListGroup({items,heading,onSelectItem}){
    <li

    onClick={()=> {
        setSelectedIndex(index);
        onSelectItem(item);
    }}
    >
}
...
function App(){
    data ...

    const handleSelectItem = (item:string) => {
        console.log(item)
    }
    return(
        <div>
        <ListGroup items={data} heading={"cities"} onSelectItem={handleSelectItem}>
        </div>
    )
}
```

# Trigger something in the parent when the child is clicked

To trigger something in the parent component when a button is clicked in your child component,
you need to pass down a callback function as a prop. Here's how to implement this for your animated filter buttons:

# State vs. Props

| Props                                                     | State                                                   |
| --------------------------------------------------------- | ------------------------------------------------------- |
| Input passed to a component, Similar to function args     | Data managed by a component, Similar to local variables |
| Treat them as immutable(Read only)                        | Mutable - data that changes over time                   |
| Everytime they change it will causes re-render of the DOM |

# Passing Children

Sometimes we want to pass children to a component.

When you have the ES7+ extension installed in VSCode you can use
`rafce` to create the basic structure. It stands for "React Arrow function component export".

Sometimes we want to pass html code or just text as a children to a component.
For that we add `children` to the _Props_ interface. We ether can specifically assign like string for the
children type. But if we want to be able to pass Html we should use `ReactNode`.

```JS
import {ReactNode} from 'react';

interface Props {
    children:ReactNode
}

const Alert = ({children:Props}) => {
    return (
        <div className="alert alert-primary">{children}</div>
    )
}
```

# Inspect components with React Developer tools

React Developer Tools is an use extension for the browser.

# Giving Props default value

If we want to give one of our props a default value we can set it in the component parameter field

```JS
interface Props{
    color?:string;

}

const Button = ({color = 'primary'}:Props){

}
```

To avoid that we have to specify the default value in the component we can set it as optional with the `?` after
_color_

`<Button ...>` no color specification necessary.

To define which values a certain property can take we define in the interface the possible values.

```JS
interface Props{
    color?: 'Primary'|'secondary'|'danger'
}
```
