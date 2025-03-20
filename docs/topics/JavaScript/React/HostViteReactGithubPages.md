---
comments: true
tags:
  - Javascript
  - React
  - Github
---

# Host Vite React Project on Github Pages

1. Install gh-pages package
   `npm install --save-dev gh-pages`

2. Update package.json
   Add homepage field with your github pages url

```JSON
{
"name":"my-project-name",
"homepager": "https://github.com/levoxtrip/MyDashboard",
"scripts": {
    "predeploy": "npm run build",
    "deploy": "gh-pages -d dist"
}
}
```

3. Configure vite.config.js

```js
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  base: "/<repo-name>/",
  plugins: [react()],
});
```

4. Initialise GIT, connect to repo, push
5. Build and deploy project
   `npm run deploy`
