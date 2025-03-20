---
comments: true
tags:
  - Javascript
  - ReactNative
---

# Basics

React Native allows you to build mobile apps for android and iOS.

It allows you to use native components which allows better performance and more seamless UX.

Hot reloading lets you see the changes you make in real-time.

Expo allows you to build React Native apps.
Expo Router uses file based routing system.

In React Native instead of rendering HTML elements you render _native mobile components_.

Basic RN component example:

```JS
import React from 'react'
import {View, Text} from 'react-native'

const App = () = {
    return (
        <View >
            <Text
            style ={{fontSize:24,color:'blue'}}
            > Hallo World!</Text>
    )
}

export default App;
```

RN also offers stylesheet utility
We can create styles by creating JS objects

```JS

const styles = StyleSheet.create({
    text: {
        fontSize:24,
        color: "blue",
        fontWeight: "bold",
    }
});
```

_NativeWind_ allows you to write tailwind like styles in your app.

```JS
import {Text} from "react-native";

const App = () => {
    return <Text className ="text-[24px] text blue font-bold">Hello, world!</Text>;
};
export default App;
```

## <View> component

Think of the `<View>` component like a box or a container that holds other components.
Similar to a `<div>` in html but with added functionality specific to mobile apps.

It is used to create layout structures for other components. It uses _flexbox_ layout by default.
So you can use flexbox properties like `justify-content` or `align-items`

## Interactivity

### TouchableOpacity

Is like a button with more customisations.

- It reduces it's opacity when pressed, creating a fade effect.
- Lighter visual impact
- Better for smaller elements and icons.
- Default choice for most cases.

```JS
import React from 'react';
import {TouchableOpacity,Text} from 'react-native';

function MyButton(props) {
    return (
        <TouchableOpacity onPress={props.onPress}>
            <Text>{props.label}</Text>
        </TouchableOpacity>
    )
}
```

### TouchableHightlight

- Adds an underlay color when pressed
- More prominend feedback
- Better for larger elements like buttons

```JS
...
import {TouchableHightlight, Text} from 'react-native';

function MyButton(props) {
    return(
        <TouchableHighlight onPress={props.onPress}>
            <Text>{props.label}</Text>
        </TouchableHightlight>
    );
}
```

### TouchableWithoutFeedback

Most basic touchable component

- No visual feedback when pressed
- Just handles touch events(onPress, onLongPress)
- Minimal overhead
- Userful when you want custom feedback or no feedback
- Useful for links and images that don't require additional styling and visual feedback.

```JS
import {TouchableWithoutFeedback,Text} from 'react-native';

function MyLink(props){
    return (
        <TouchableWithoutFeedback onPress={props.onPress}>
        <Text style = {{ textDecorationLine: 'underline'}}>
        {props.label}
        </Text>
        </TouchableWithoutFeedback>
    )
}
```

### ActivityIndicator

Allows to show spiner animation or loading indicator

```JS
import {View, ActivityIndicator, StyleSheet} from 'react-native';

const App = () => {
    return(
        <View style={styles.container}>
            <ActivityIndicator size="large" color="#0000ff" />
        </View>
    );
};

const styles = StyleSheed.create({
    container: {
        flex:1,
        justifyContent: 'center',
        alignItems: 'center',

    },
}),
```

### Button

```JS
import {View, Button,StyleSheet} from 'react-native';

const App = () => {
    const handlePress = () => {
        console.log('Button Pressed!');
    };

    return (
        <View style={styles.container}>
        <Button title="Press me" onPress = {handlePress}/>
        </View>
    );
};

export default App;
```

### Flatlist

Rendering a long list of items that need to be scrolled efficiently.
Like the `map` function in React.
Flatlist has optimized scroll performance and item seperation.
If you want to create larger lists with smooth scrolling you should use _Flatlist_.
For smaller list you can use `map` function from React.

```JS
import { View, FlatList, Text, StyleSheet} from 'react-native';

const App = () => {
    return (
        <View style={styles.container}>
            <FlatList
            data={DATA}
            renderItem={({ item }) => (
            <View style={styles.item}>
                <Text style={styles.title}>{item.title}</Text>
            </View>
        )}
          keyExtractor={item => item.id}
         />
         </View>
    );
};
...
```

### Scrollview

Can hold multiple components and views, providing a scroll container for them.
We can use it for a large list of items or large amount content in general so users
can easily explore all content.
It requires a bounded height.

```JS
import {View, ScrollView, Text, StyleSheet} from 'react-native';

const App = () => {
    return (
        <View style={styles.container}>
            <ScrollView contentContainerStyle={styles.scrollViewContent}>
                <Text style={styles.text}>Text 1</Text>
                <Text style={styles.text}>Text 1</Text>
                <Text style={styles.text}>Text 1</Text>
                <Text style={styles.text}>Text 1</Text>
                <Text style={styles.text}>Text 1</Text>
                <Text style={styles.text}>Text 1</Text>
                <Text style={styles.text}>Text 1</Text>
                <Text style={styles.text}>Text 1</Text>
            </ScrollView>
        </View>
    );
};
```

### Default SaveAreaView

Provides a save area to render the content without getting covered by the devices hardware features like notch etc.
This falls short for some users so there is another
_react-native-safe-area-context_ in the npm. `npm install react-native-safe-area-context`

```JS
import {SaveAreaView} from 'react-native-safe-area-context';

function SomeComponent(){
    return(
        <SaveAreaView style={{ flex:1, backgroundColor:'red'}}>
            <View style= {{flex:1,backgroundColor: 'blue'}}/>
        </SaveAreaView>

    );
}
```

## Image

Used to display standalone images.

```JS
import{View, Image, StyleSheed} from 'react-native';

const App = () => {
    return (
        <View style={styles.container}>
            <Image
                source={{uri:'https://via.placeholder.com/200'}}
                style = {styles.image}
            />
        </View>
    );
};

export default App;
```

## ImageBackground

To create an image as background there is a special component `ImageBackground`

```JS
import{View,ImageBackground,Text,StyleSheet} from 'react-native';
const App = () => {
    return (
        <View style={styles.container}>
            <ImageBackground
                source={{uri: 'https://via.placeholder.com/400'}}
                style={styles.imageBackground}
            >
            <Text style={styles.text}>Hello, Image Background!</Text>
        </ImageBackground>
    </View>
    );
};
...
```

Both components can handle _.png,.jpg,.gif,.webp,.jif_ no svgs though.
you can use svg directly within expo with third party package `react-native-svg`

## Modal

Modals are like popups that get animated in from the bottom.

```JS
import {View,Modal, Text} from 'react-native';

const App = () => (
    <Modal
        visible={true}
        animationType="slide"
        onRequestClose={()=> console.log('Modal closed')}
    >
    <View style={{flex:1,justifyContent: 'center',alignItems:'center'}}>
        <Text> This is a modal</Text>
    </View>
</Modal>
);

export default App
```

## Alert

Two/three button Alert

```JS
import {Alert} from 'react-native';

const App = () => {
    return(
        Alert.alert(
            'Alert Title',
            'My alert message',
            [
                {text: 'Cancel', onPress:()=> console.log('Cancel pressed'),
                style: 'cancel'},
                {text:'OK', onPress: () => console.log('OK pressed')}
            ]
        );
    );
};

export default App;
```

## Toggle

If you want to create a toggle we can use a `Switch` component

```JS
import {Switch, View} from 'react-native';

const App = () => {
    return (
        <View>
        <Switch
            trackColor={{false: '#767577', true:'#81b0ff'}}
            thumbColor={isEnabled ? '#f5dd4b' : '#f4f3f4'}
            onValueChange={toggleSwitch}
            value={isEnabled}
        />
        </View>
    );

};
export default App;
```

## StatusBar

With `StatusBar` can we control how the statusbar on the phone should look like.

```JS
import React from 'react';
import {Text, View} from 'react-native';
import {StatusBar} from 'expo-status-bar';

export default function App(){
    return (
        <View style={styles.container}>
            <Text style={{color:'#fff'}}> Notice that the status bar has light text!</Text>
            <StatusBar style="light"/>
        </View>
    );
}
```

More components here

<iframe height="300" style="width: 100%;" scrolling="no" title="Drawing Circle" src="https://reactnative.dev/docs/components-and-apis" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
</iframe>

## Routing in Expo

_Expo-Router_ is a file-based navigation library that is build specificly for React Native Projects that are build with Expo.

You set up a folder `App` and based on your folder structure and the files within that folder that is how your navigation is gonna look in your Application.

To learn how expo router works it makes sense to do the _Manual Installation_. If you know how everything works you can do the quickstart.
[Link to Documentation](https://docs.expo.dev/router/installation/)

After installing all the dependencies the next step is to setup up the entry point in the `package.json`file.
This make the entry point of the application going directly to Expo Router

```JS
{
    "main":"expo-router/entry"
}
```

Then you want to modify the project configuration in `app.json`

```JS
{
    "scheme":"your-app-scheme"
}
```

Then in the `babel.config.js`:

```JS
module.exports = function(api){
    api.cache(true);
    return {
        presets: ['babel-preset-expo']
        plugins:['expo-router/babel'],
    }
}
```

So everything is based on the folder structure of the `app` folder.
So the entry file of your app is gonna be `index.tsx`.
So when you create a subfolder like `Station` you already enable the `/station` url endpoint you then can navigate to.

You can create _dynamic route_ with `url`parameter. For that you name the file `[id].tsx`. This allows us to show whatever we pass through `/station/id` gonna render that `[id].tsx` component. Id can be a number, string.

### Navigation to router

There are two ways to navigate the pages in the subfolder.
The first way is to create the native `<Link>` component from expo router and then create link to navigate to the specific page.
`<Link href="{/station/1}">Go to Station 1</Link>`. This automatically create a button you can click.

It is important that the names in the links have to match the file names in the folder structure.

Or you do it programmatically by importing router object from expo router and calling the `.push` or `.navigate()`method on it. For that we use a `Pressable` from react native

```JS
<Pressable onPress={()=>router.push("/users/2")}></Pressable>
```

So when you need the specific functionality of Link like press and hold you should use `<Link>`.
Sometimes you want to link programmatically for example when you want to navigate the user to a new side when the user fills out a form and hits onSubmit.

Also if you want to no just pass the route via a link it can make sense to make it with the pressable

```JS
<Pressable
    onPress={()=> router.push({
        pathname:"/station/[id]",
        params: {id :2},
    })}>
</Pressable>
```

To then get the `id` on the linked component we can use the _hook_ from expo router called `useLocalSearchParams()`

```JS
import {useLocalSearchParams} from "expo-router"
...
const {id} = useLocalSearchParams();
//const {id} = useLocalSearchParams<{id:string}>(); // typed version
return (
    <View>
        <Text>User {id}</Text>
    </View>
)
```

### Navigating back to index

We can make use of `Stacks` from expo router which directly wraps these stacks that you have in React Navigation.

So you create a new file called `_layout.tsx`. These layout files define the layout for the group/folder they are laying in. Each `_layout.tsx` overwrite the other from the folder above it.

Inside the file you call the component RootLayout.
You then import `Stack` and define the Screens you want to link to.

```JS
import {Stack} from `expo-router`

const RootLayout = () => {
    return(
        <Stack>
        <Stack.Screen name="index" options={
        headerTitle: "Home",
        headerStyle: {
            backgroundColor: "red",
        }
        }/>
        <Stack.Screen name="station/[id]" options={
            headerTitle: "Station"
        } />
        </Stack>
    )
}
```

This gives you a header on top of your screen which shows the name of the page. You also get animation and a back button back to the start side. We then further customize is as you can see above with `options`

### Create button tabs

You can create folders inside the `app` that are not affecting the url. It is called grouping. So you can group certain parts together. For example when you want to create tags for your navigation you can create a `(tabs)` folder.

You then can move `index` und the `station` folder inside of `tabs`.
For the tabs you can create an own `_layout.tsx` file to define the tabs layout.

```JS
const TabsLayout = () => {
    return (
        <Tabs>
        <Tabs.Screen name="index" options={
            title:"Station"}
            />
        <Tabs.Screen name= "users/[id]"/>
        </Tabs>
    );
};
```

We then can change the `_layout.tsx` from the folder above the tabs group and change it to

```JS
import {Stack} from "expo-router"

const RootLayout = () => {
    return (
        <Stack>
        <Stack.Screen name="(tabs)"
        options={{
            headerShown:false,
        }}
        />
        </Stack>
    );
};
export default RootLayout;
```

## Create a new component

In an empty file we can create a new component Structure with `rjsfc`

## Uninstall a package

`npm un packagename`

## For each datapoint show an element in the views

First import the data
`import data from './data.json'

then you can ether use Flatlist

```JS
import data from '....'

<FlatList
    data={data}
    keyExtractor={(item) => item.id.toString()
        renderItem={({item})=> (
            <Text style={styles.text}>{item.name}</Text>
        )}
    }/>
```

Or you use the `.map()` function

```JS
import data from ...

{data.map((item) => (
        <Text key={item.id} style={styles.text}>
          {item.name}
        </Text>
      ))}
```

## Pass Data via Link

```JS
//Screen 1
      <Link
        style={GlobalStyles.button}
        href={{
          pathname: "/movement",
          params: { interval: selectedInterval },
        }}
      >
        Start Notifications
      </Link>

//Screen 2
import {useLocalSearchParams} from 'expo-router'
const { interval } = useLocalSearchParams();
```

## Expo notifications

`npx expo install expo-notifications expo-device expo-constants`

New file
`usePushNotifications.ts`

```JS
import {useState,useEffect, useRef} from 'react'
import * as Device from 'expo-device'
import * as Notifications from 'expo-notifications'

import Constants from 'expo-constants'
import {Platform} from 'react-native'

export interface PushNotificationState {
    notification?: Notification.Notification;
    expoPushToken?:Notification.ExpoPushToken;
}

export const usePushNotification = ():PushNotifcationState => {
    Notifications.setNotificationHandler({
        handleNotification: async()=> ({
            shouldPlaySound:false,
            shouldShowAlert:true,
            shouldSetBadge:false
        })
    })

    const [expoPushToken,setExpoPushToken] = useState<
    Notification.ExpoPushToken | undefined>();

    const [notification,setNotification] = useState<
    Notification.Notification | undefined>();

    const notificationListener = useRef<Notifications:Subscription>();
    const responseListener = useRef<Notifications:Subscription>();

    async function registerForPushNotificationsAsync(){
        let token;

        if(Device.isDevice){
            const {status:existingStatus} = async Notifications.getPermissionAsync();

            let finalStatus = existingStatus;

            if(existingStatus !== "granted"){
                const {status} = await Notifications.requestPermissionsAsync();
                finalStatus = status;
            }
            if(finalStatus !== "granted"){
                alert("Failed to get push token")
            }

            token = await Notifications.getExpoPushTokenAsync({
                projectId:Constants.expoConfig?.extra?.eas?.projectId;
            })

            if(Platform.OS === 'android'){
                Notifications.setNotificationsChannelAsync("default", {
                    name:"default",
                    importance:Notifications.AndroidImportance.MAX;
                    vibrationPattern:[0,250,250,250],
                    lightColor:"#FF231F7C",
                })
            }

            return token;


        }else {
            console.log("Error please use a physical device");
        }
    }
    useEffect(()=> {
        registerForPushNotificationsAsync().then((token)=>{setExpoPushToken(token)});

        notificationlistener.current =Notifications.addNotificationReceiveListener((notification)=> {
            setNotification(notification);k
        });

        responseListener.current = Notifications.addNotificationResponseListener((response) => {
            console.log(reponse);
        }

        return () => {
            Notifications.removeNotificationSubscription(
                notificationListener.current!
            )

            Notifications.removeNotificationSubscription(
                responseListener.current!);

        }
    },[])

    return {
        expoPushToken,
        notification
    }
}


//App.tsx

export default function App(){
    const {expoPushNotification,notification}= usePushNotification();

    const data = JSON.stringify(notification,undefined,2);
    ...
    return(
        <View>
            <Text>Token:{expoPushToken?.data?? ""}</Text>
            <Text>{data}</Text>
        </View>
    )
}

```
