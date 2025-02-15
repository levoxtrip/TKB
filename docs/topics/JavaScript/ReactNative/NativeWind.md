---
comments: true
tags:
    - Javascript
    - ReactNative
---

# Native Wind

It uses Tailwind CSS as scripting language to create a universal style system for React Native.

# Installing
[Install Link for Native wind](https://www.nativewind.dev/getting-started/expo-router)
To install Native wind go to your project folder and run
`npm install nativewind tailwindcss react-native-reanimated react-native-safe-area-context`
After that you want to install the dev dependencies

To setup tailwindcss we need to run `npx tailwind init` to create a `tailwind.config.js`

The next step is to copy this to input it into the `tailwind.config.js`
```JS
/** @type {import('tailwindcss').Config} */
module.exports = {
  // NOTE: Update this to include the paths to all of your component files.
  content: ["./app/**/*.{js,jsx,ts,tsx}"],
  presets: [require("nativewind/preset")],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

The next step is to add the Babel plugin by modifying the `babel.config.js` and adding the native wind plugin.

```JS
module.exports = function (api) {
    api.cache(true);
    return {
      presets: [
        ["babel-preset-expo", { jsxImportSource: "nativewind" }],
        "nativewind/babel",
      ],
    };
  };
  ```
So now we can replace the stylesheet with tailwind like classnames.

So you remove the stylesheed imports and the styles from the elements and just add the classnames from tailwind.


## Adjusting elements in View
```JS
...
//Adjust elements in View
<View className="flex-1 items-center justify-center bg-white">
...
```


## Setting Text size
```JS

<Text className="Text-3xl">Welcome</Text>
```

## Building a Theme
We can setup fonts and colors to build up a theme for our app so we don't have to rewrite a lot of code. 
In the `tailwind.config.js` file we can set our settings for the theme. in `theme:`

### Colors
```JS
...
theme:{
  extend:{
    colors:{
      primary:'#161622'
    }
  },
},
plugins:...
```

### Fonts
To use your fonts you need to import them into the `assets/fonts` folder

```JS
...
theme:{
  extent:{
    colors:...
    ,
    fontFamily:{
      pthin:["Poppins-Thin","sans-serif"]
    }
  }
}
```
