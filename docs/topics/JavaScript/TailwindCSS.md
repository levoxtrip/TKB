---
comments: true
tags:
    - Typescript
    - ReactNative
    - React
    - WebDesign
---
# Tailwind CSS - Basics
Tailwind provides predefined utility classes.
Every tailwind class is a predefined css rule.
When we use `flex` tailwind gerates behind the scenes.

Tailwind generates styles on the fly only on classes that we actually use.


```CSS
.flex{
    display:flex
}
```
There is an interactive playground for tailwind styles.
[Tailwind PLay](https://play.tailwindcss.com/)

Align text center `text-center`
Set text size `text-lg` Text large
Text color `text-blue-400` 400 stands for a shade of the color

Apply margin `mt-2` margin top 2

Set height of div element `h-10` 2.5rem = 40px
Set width of div element `w-full` full width
Set border of element `border-2` border width of 2
Set border color `border-violet-600`
Set roundet corner `rounded-md` medium border radius
Set margin y off `my-4` top and bottom - x for left and right
Set margin top `mt 4` 
Set margin left `ml 4`
set padding off `p-2` if you just use the letter it applies it to all sites.


*Margin* is external spacing which pushes the element away from others
*Padding* is inside the element.

# Set a background
`<div class ="bg-grey-200">

# Add Shadow
`shadow-xl`


# center element
`div class ="flex justify-center items-center"`

# Just in Time compiler
Tailwind is super flexible because of its Just in time compiler.

Tailwind only includes the exact styles that your project uses.

When you give your site a not defined utility you can do
`text-[20px]`

# Layouts - Flexbox
Tailwind provides powerful utilities for structuring your layout 
with `Position`,`Display`,`Flexbox` and `Grid`

## Positioning
Where does you element appear relative to its container or viewport
`relative` moves element relative to it's position.
`absolute` moves element to its nearest parent.
`fixed` sticks element to viewport
`sticky` behaves normally until scrolled to a certain point

`top-0` Element is fixed at the top of the website regardless of the scroll position.

## Flexbox
Determines how an element behaves in terms of layout and visibility within the document.
`dislay:block` element takes full width
`display:inline` behaves like text
`display:flex` enables flexbox
`display:grid` enables grid properties

```JS
//enable flex and align element to the right with spacing of the element
<div class ="flex justify-end space-x-6 mt-2">
    //height, width rounded corner - background blue
    <div class ="h-16 w-16 rounded-full bg-blue-600">
</div>
```

With `justify-` you can set different ways to justify the elements in the flexbox
`justify-end` move object to the *end*/right.
`center` object to the center
`space-around` evenly distribute objects with space around them.
### Column based layout
One element on top of each other
`div class = "flex flex-col"> </div>`

You also can instead of using justify you can use `items-`

```JS
<div class = "flex flex-col items-center justify center space-y-6">...</div>
```
Practise flex box with Flexbox froggy.

## CSS Grid
To position elements on a grid we need to add the `grid`property
```JS
//Grid with 3 cols and a gap of 2 and margin at top and bottom
<div class="grid grid-cols-3 gap-2 mt-2 mx-2">
// If you don't provide with in the children it will naturally expand the children
<div class="h-16"></div>
<div class="h-16"></div>
<div class="h-16"></div>
</div>
```

You can practise CSS grid on the Grid garden website.

# Media Queries
Tailwind uses mobile first break points. They set a min width by default.

Media Queries allow you to change CSS properties depending on the screen width.
```JSX
//Element is hidden in media devices smaller than md = 768 pixels
<div class ="md:block hidden">
    <p class="text-white">I appear on the screen wider than 768px</p>
</div>

// different background depending on the size
<div class="sm:bg-amber-500 md:bg-amber-700">
</div>
```
Larger Screen Sizes always overwrite smalller ones.

When you use the `max-width` media queries you can turn that around.
It applies the style then only if the width is lower than the defined size.
```JS
<div class="max-sm:bg-amber-500 max-md:bg-amber-700"></div>
```

unprefixed utilities like `uppercase` take effect on all screen sizes while prefixed utilities like `md:uppercase` only take effect at the specified breakpoint and above

## Show text in center on mobile and left on bigger screens.

```HTML
<div class="text-center sm:text-left"></div>
```

## Customize your breakpoints
```CSS app.css
@import "tailwindcss";
@theme {
    --breakpoint-xs: 30rem;
    --breakpoint-2xl:100rem;
    --breakpoint-3xl:120rem;
}
```

We also can provide arbitrary values
`div class="max-[600px]:bg-sky-300 min-[320px]:text-center">`

# Dark-mode
Tailwind supports darkmode natively. You have to add `dark:property`
```JS
<div class="bg-white dark:bg-black text-black dark:text-white">
</div>
```

## Toggle dark-mode manually
```CSS
@import "tailwindcss";
@custom-variant dark(&:where(.dark,.dark *));
...
@theme {
    ...
}
```

# Custom Styles & Reusability
## Introduce new color that isn't in theme
### Inline
You can use it for every element and property.
`h1 class ="text-[#99ffee]">Examples</h1>`

## Tailwind config
Enables to organise and control the visual style of your application.
Go into the css file and use Tailwind *directives*

### Theme directives

```JS

@theme{
    --color-chesnut: #930482;
    --font-

}
...

<p class="text-chesnut"></p>
```
You can find the different Theme variable namespaces on the Tailwind site

### Base,components,utitlies

base applies styles globally to your project for your elements
```css
@layer base {
    h1:{
        color:green;
        font-size:var(--text-2xl)
    }
    h2: {
        font-size:var(--text-xl)
    }
}
```

components - styles for reusuable components like cards, footers, header
```css
@layer components {
    .card {
        background-color: var(--color.white);
        border-radius: var(--rounded-lg);
        padding: var(--spacing-6)
        box-shadow: var(--shadow-xl);
    }
}
```
utilities - atomic styles for individual properties like margins padding typography colors
```css
@utility content-auto {
    content-visibility:auto;
}

<div class="content-auto"></div>
```

### @apply
`@apply` inserts tailwind styles into css
```CSS
.select2-dropdown{
    @apply rounded-b-lg shadow-md;
}
.select2-search{
    @apply rounded border border-gray-300;
}
.select2-results__group {
    @apply text-lg font-bold text-gray-900
}
```

### @layer
```CSS

@layer base {
    h1{
        @apply text-base font-medium tracking-tight
    }
}



@layer components {
    .card{
        @apply m-10 rounded-lg bg-white
    }
}

<div class"card"></div>
```

To overwrite certain default styles yo defines in the layers you can write your own utilites
```css

@utility flex-center{
    @apply flex justify-center items-center;
}
```

# Component libraries
We can use component libraries like `shadcn/ui` to get already pre created components.
ChadCN will create the tailwind styles for you.
We also can use native tailwind in them.

# Tips and Tricks
## Special utilies
To overwrite the default styles for elements like checkboxes and radio btn.
Provide a class of `accent-pink-500`

### Fluid text
To make text scale fluidly you can use `text-[min(10vw,70px)]`

### File
```JS
<label class="my-4 block">
    <input type="file" class="block w-full text-sm file:mr-4">
</label>
```

### Highlights
with `selection:bg-green-400 selection:text-white` you can change the selection colors


