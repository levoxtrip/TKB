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

In React Native instead of rendering HTML elements you render *native mobile components*.

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

*NativeWind* allows you to write tailwind like styles in your app.
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

It is used to create layout structures for other components. It uses *flexbox* layout by default. 
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
If you want to create larger lists with smooth scrolling you should use *Flatlist*.
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

```JS
import {View, ScrollView, Text, StyleSheet} from 'react-native';

const App = () => {
    return (
        <View style={styles.container}>
            <ScrollView conentContainerStyle={styles.scrollViewContent}>
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
*react-native-safe-area-context* in the npm. `npm install react-native-safe-area-context`

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

Both components can handle *.png,.jpg,.gif,.webp,.jif* no svgs though. 
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

