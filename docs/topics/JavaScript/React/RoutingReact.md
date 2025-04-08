---
comments: true
tags:
  - Typescript
  - ReactNative
  - React
---

# Routing in React

In the `main.tsx` first import `createBrowserRouter` from `react-router-dom`.

Then we create a `router` object
`createRouter = createBrowserRouter([])`

So we exchange the `App.tsx` with our router.

```JS
import {RouterProvider} from 'react-router-dom'

...

<RouterProvider router={router}/>
```

This deffer the entry point to the application to react router.

Next step is to create a route in the Browser router

```JS
const router = createBrowserRouter([
    {
        path:'/',//Index path of our application
        element:<HomePage/>,
        errorElement:<NotFoundPage/>
    },
    {
        path:'/profiles',
        element:<ProfilesPage/>
    }
])
```

You also can add an Error element which leads to a default error site when the address is not available - like 404

In React Router there is a specific way to handle links.
You use the `Link` component.
`<Link to="/">Home</Link>`


---
Info from other tutorial
`npm install react-router-dom`

`import {BrowserRouter as Router,Route,Routes} from "react-router-dom"`

```JS
<Router>
<Routes>
    <Route path="/" element={<Write/>}>
    <Route path="/write" element={<Write/>}>
</Routes>
</Router>
```

We then can use on the other sides
```JS
import {useNavigate} from 'react-router-dom'
...

const navigate = useNavigate();
...
<button onClick={()=>navigate("/")}>Go Homepage</button>
```
