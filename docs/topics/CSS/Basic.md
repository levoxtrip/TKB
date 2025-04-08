---
comments: true
tags:
  - CSS
---

# CSS

## Block Scroll

In css we define
`html,body {overflow:hidden;}` to prevent the user to scroll outside of our Three.js canvas.

## Fixed position for element

With `fixed` the element stays in the viewport

```css
.canvas {
  position: fixed;
  top: 0;
  left: 0;
}
```

## Full screen sections

```css
.section {
  display: flex;
  align-items: center;
  height: 100vh;
  position: relative;
  padding-left: 10%;
  padding-right: 10%;
}
```

```html
<section class="section">
  <h2>Contact me</h2>
</section>
```
