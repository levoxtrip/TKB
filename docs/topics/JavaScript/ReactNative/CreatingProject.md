---
comments: true
tags:
    - Javascript
    - ReactNative
---
# Creating a project
1. Create an expo project
`npx create-expo-app ./`
or 
`npx create-expo-app@latest`
Downloads and installs the bases for deact native projects
If you want an empty project not with the default template you can use.
`npx create-expo-app MyApp --template blank`

Then navigate into the new project folder with `cd`

2. Install dependencies
`npx expo install expo-router react-native-safe-area-context react-native-screens expo-linking expo-constants expo-status-bar`
All these packages are necessary

In the `package.json` *dependencies*  we see everything that got installed

3. Setup entry point
Overwrite the main in your package.json with 
`"main": "expo-router/entry",` Now we cann use Filebase routing.

4. Copy content from App.js
Copy content from App.js file and and add it into a `_layout.jsx` file that is in a new folder `app`
This will be the starting point of the application

5. Modify project configuration
Add a deep linking `scheme` with your app name in your `app.json` config
```JSON
{
    "scheme":"your-app-scheme"
}
```
Its used to deeplink expo and react native applications. Allows you app to be open within a specicific screen directly from the url outside the app. 

In the `app.json` under `"name"` you can change the value to your app name.
The `slug` which is an url friendly name of the app you can also change it to your app name.

File with many configuration to improve your app.

6. Start the app
`-c` clears the cache.
`npx expo start -c`

7. Expo
If you want to directly test the app on your device you can use the Expo go app on your device. And scan the qr code.
You need to be connected to the same network.
In iOS
- turn the VPN Status Off
- Local Network on.

8. index.jsx
index.jsx is often used as the entry point or main component of the application, similar to an index.html
*Routes* define then different screens/pages in the app.
*Routing determines how users moves between different parts of the application.
And the `_layout.jsx` will be present in all files

So there we would set the navbar or header
for that we can use a special snipped `rnfes` But you have to have ex7+ react snippets extention in vscode installed.

Then rename the object to `RootLayout`

## Apply style
Assign to the element `style={styles.contentname}`

To center the container element on the screen.
```JS
const styles = StyleSheed.create({
    container:{
        display:'flex',
        flex:1,
        alignItems: 'center',
        justifyContent: 'center'
    },
    text:{
        color:'white',
        textSize:42,
        fontWeight: 'bold',
        textAlign: 'center'

    }

})
```

To apply directly a style you can use double braces
`style={{marginHorizontal:'auto'}}`

## Slot
When you want to render your `index.jsx` on your home screen we can modify the layout.jsx to render different screens and specified default ones or we can use the `<Slot/>` property from expo router

```JS
...
import {Slot} from 'expo-router'

const RootLayout = () => {
    return <Slot/>
}
export default RootLayout
```
And we don't need the styles anymore.

The `<Slot>` renders the current child router.

When we also want to render header and footer we need to wrap it
```JS

<>
<Text>Header</Text>
<Slot/>
<Text>Footer</Text>
</>
```

Another way to do navigation is to use a `Stack` of different screens. There you add all the sites 
```JS
...
import{Stack} from 'expo-router'

const RootLayout = {} => {
    return(
        <Stack>
        <Stack.Screen name="index" options={{headerShown:false}}/>
        <Stack.Screen name="explore" options={{title:"Home"}}/>
        </Stack>
    )
}
```

## Adding images
You can put the images in the `assets` directory in the project folder

To show a background image you need to import in the `import {View,Text,StyleSheet,ImageBackground} from 'react-native'` and also import the image reference
`import imgName from '@/assets/images/imageName.png'`

Then you can use
```JS
<ImageBackground
    source={imgName},
    resizeMode="cover",
    style={styles.bgimage}
>
//!!!! Needs to be inbetween the open and clos of imagebackground
<Text style={styles.text}>Hello Text</Text>

</ImageBackground>
```
If you want to cover the image the entire screen you can add the `resizeMode="cover"` to

## Typescript vs Javascript
If you use typescript you can leave the file endings to `index.tsx`. but if you use javascript you have to change it to `index.jsx`

## Modify the splash screen
Go into the `app.json` file and then to `"splash"`. There you can see the link to the splash screen img.

## Modify the icon
Go into the `app.json`file and there you see the object `icon`

## Navigation
So if you for example don't want to use tabs you can drag the `index.jsx` out of the `(tabs)` folder and delete the tabs folder. 
Then add `"**/*.jsx"` to the `tsconfig.json` so it doesn't add every file that you move.

## Adding links to other pages
You need to import `Link` from expo-router
`import {Link} from 'expo-router'`

`<Link href="/explore">Export</Link>`

When you style the link you can add
`textDecorationLine: 'underline'` to create the link look.

## Pressable
If you want more complex interactions or custom styling it can make to use `Link` and `Pressable` instead of Button because you can customise more.
```JS
import {Link} from 'expo-router'
import {Pressable} from 'react-native'

...
<Link 
href="/explore" style={{marginHorizontal:'auto'}}
asChild>
<Pressable>
<Text> Explore</Text>
</Pressable>
</Link>
```

## Groups
When you have a folder in `(categories)` that defines groups. Anytime you create a folder like this it needs its own `_layout.jxs` file.

If we have a group we then can reference the group in the _layout file

```js
...
<Stack.Screen name="(groupName)" options={{headerShown:false}}/>
...
```

## Tabs
Tabs is a special directory. It tells expo to use the tab layout.
`_layout.txs` defines how the tabbar and each tab behaves.
Your files for the single pages need to be in the `(Tabs)` folder.

In the layout file you need to set the right links to your pages that you want to lead to with the tabs.

### Define the tabbar active/inactive colors
In the `<Tabs screenOptions={{...tabBarActiveTintColor}}>` can we define the colors for the active tab.
If you want to define the inactive color you can use `tabBarInactiveTintColor:`

You can assign a color object

```JS
import {Colors} from '@/constants/Colors';
...
const colorScheme = useColorScheme();
<Tabs
    screenOptions={{
        tabBarActiveTintColor:Colors[colorScheme ?? 'light'].tint,
    }}>
    ...
```
`colorScheme ?? 'light'` is null coalescing operator `if color is null or undefined` it is setting it to 'light'

in the `constants/Colors.ts` file can we set the basic colors or define which colors we want in dark and light mode for our app so we easily can reference it through the whole app.

## Modify the header
We can assign the alignment of the header with `headerTitleAlign:"center"` in the `<Tabs screenOptions={{...}}>`

## Icons in Expo
Under `https://icons.expo.fyi` you can see what icons you can use in expo.

Be aware who supplies the icons and that you import the right icons
e.g. icons from Ionicons
`import Ionicons from '@expo/vector-icons/Ionicons';`

```JS
...
import Ionicons from '@expo/vector-icons/Ionicons';
...

<Tabs.Screen
name="contact"
options={{
    title:'Contact us',
    tabBarIcon:({color,focused}) => (
        <TabBarIcon name ={focused ? 'people-circle' : 'people-circle-outline'} color={color}/>
        ...
    )
}}>
```
## Themed Text
Themed text contains already the colorscheme