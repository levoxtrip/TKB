# Developing React Native Mapbox App

# Installation
Install the react native cli
Create a new react native project
`npx react-native init MyProjectName --template react-native-template-typescript`

or an expo project.



Install react native project with `npm install @rnmapbox/maps`
or in expo `npx expo install @rnmapbox/maps`
More info on [Mapbox Github](https://rnmapbox.github.io/docs/install)

In Expo you have to configue the `app.json`. You need to add your DownloadToken.
```JS
{
  "expo": {
    "plugins": [ex
      [
        "@rnmapbox/maps",
        {
          "RNMapboxMapsDownloadToken": "sk.ey.."
        }
// highlight-end
      ]
    ]
  }
}
```
# Get DownloadToken Mapbox
- Go to mapbox account site and to tokens. 
- Create a new token
- Give it a name
- You just need the `DOWNLOADS:READ` permission.
- Then create token and copy it into the `app.json`

It is important to know. You cannot use Mapbox Maps in Expo Go App. So you should use EAS Builds.

# EAS Builds
- Install lates EAS CLI. You can also use this to check for new versions.
`npm install -g eas-cli`
- Login into your Expo account
`eas login`
- Configue project
`eas build:configure`

Take in mind that you have you devices be added properly.

[Infos](https://docs.expo.dev/build/setup/)

Build it for iOS and Android. 
After did *configure project* you have an `eas.json` file in your project folder.
If you have set it up you then can build it
`eas build --profile development --platform ios` or use android.

You then have to add some info in the terminal.

When the build is completed
you have to install it on the phone.
Scan the code from the terminal.
This installs the equivalent for the expo app.

Then you call `expo start --dev-client` to start the server.

Scan again the new QR code.



If you test on android or apple you have to do some basic steps:
[Android Install](https://github.com/rnmapbox/maps/blob/main/android/install.md)
[Apple Install](https://github.com/rnmapbox/maps/blob/main/ios/install.md)


Infos from [Expo EAS and Mapbox React Native Youtube](https://www.youtube.com/watch?v=C6b-TXFtJDs)



# Install ES7+
To get React and React Native snippets you should install the ES7+ extention in VSCode.

Then you can add a basic structure with `rnfe + tab`.

# Adding Basic Component structure
First import the Mapbox library into the component and add your public key from the mapbox website.

```JS
import MapboxGL from '@rnmapbox/maps'
MapboxGL.setAccessToken("ADD PUBLIC KEY FROM MAPBOX SITE HERE")

const App = () => {
    return(
        <View style={styles.page}>
            <View style={styles.container}>
            <MapboxGL.MapView style={styles.map}>
            </View>

        </View>
    );
}

export default App;

const styles = StyleSheet.create({
    page:{
        flex:1,
        justifyContent: 'center',
        alignItems:'center',
    },
    container:{
        height:'100%',
        width:'100%,
    },
    map:{
        flex:1
    }
    }
})
```
To add a basic mapview we use the `<MapboxGL.MapView>` component.
```JS
    <View style={styles.container}>
          <MapboxGL.MapView
      style={styles.map}
      zoomEnabled={true}
      styleURL='mapbox://styles/mapbox/streets-v12'
      rotateEnabled={true}
      >
        </MapboxGL.MapView>
    </View>
```

We also need to set the camera with `<MapboxGL.Camera/>` inside the `<MapboxGL.MapView>` 
```JS
...
<MapboxGL.MapView
...
>
<MapboxGL.Camera
        zoomLevel={15}
        centerCoordinate={[10.181667,36.806389]}
        pitch={60}//The rotation of camera. 0 from 90 degree. 70 lower angle
        animationMode={'flyTo'}
        animationDuration={6000}
        />
 
</MapboxGl.MapView>
```


# Display a marker
To display a marker we can use `MapBoxGL.PointAnnotation>`.
```JS
      <MapboxGL.PointAnnotation
      id="marker"
      style={styles.marker}
      coordinate={[10.181667,36.806389]}
      >
        <View style={styles.markerContainer}>
          <View style={styles.marker}/>
        </View>
      </MapboxGL.PointAnnotation>
...
const styles = StyleSheet.create({
...
  markerContainer:{
    width:20,
    height:20

  },
  marker:{
    width:20,
    height:20,
    borderRadius:10,
    backgroundColor :'red',
    borderWidth:2,
    borderColor:'white'

  }
})
```

# Catching error
We can catch errors with
```JS
Logger.setLogCallback(log =>{
  const {message} = log;
  if(message.match('....'))
  {
    //Do this
    
  }
})
```
# Placing Icons 
Install the React Native vector icons lib with
`npm i react-native-vector-icons`
Then you can import the icon set by name
`import {Fontisto} from '@expo/vector-icons'`

We can place an Icon for our marker by putting the component into a `View` in the `PointAnnotation`
```JS
...
<MapboxGL.PointAnnotation
/*... settings marker*/>
<View style={styles.markerContainer}>
<Fontisto name="shopping-store" size={20} color="#82BD61"/>
</View>
</MapboxGL.PointAnnotation>

//Defintion of stlye of the elements

```

# Trigger a Modal
First we need to define the state `modalVisible`. Then we write two functions `triggerModal()` and `closeModal()`
```JS
const [modalVisible,setModalVisible] = useState<boolean>(false)

const onMarkerPress = ()=>{
  setModalVisible(true)
}

const closeModal = ()=> {
  setModalVisible(false)
}

<Modal visible={modalVisible} animationType="none" transparent>
  <View style={styles.modalContainer}>
  <View stlye={styles.modalContent}>

    <TouchableOpacity onPress={closeModal} style={styles.closeButton}>
    <Text>X</Text>
    </TouchableOpacity>
    <Text>City:Ariana</Text>
    <Text>Country:Ariana</Text>

  </View>
  </View>
</Modal>
...
```
# Button
In React Native we don't have a Button Component we have `TouchableOpacity` Component
```JS
  <TouchableOpacity onPress={closeModal} style={styles.closeButton}>
    <Text style={styles.closeButtonTxt}> Close</Text>
  </TouchableOpacity>
```

# Reverse Geolocation
In this example we use this
[Nominatim](https://nominatim.org/release-docs/develop/api/Reverse/)

We can use the url from that side
``const url = `https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${36.806389}&lon=${10.181667}` ``
and the implement the lat and long into it.

So first we have to fetch the url with a `useEffect` hook.
```JS
//We need a new locationdata state
const [locationData,setLocationData] = useState<any>(null)
...

useEffect(()=> {
  fetch(url)
  .then(response => response.json())
  .then(data => setLocationData(data))
  .catch(error => console.error('Error fetching reverse data',error))
  console.log(locationData)
},[])


```

Then we can assign the values from the response to the text in the modal.
With the `?` we avoid that we get an error when locationData is null.
```JS
...

<Modal>
  <Text> locationData?.address.city</Text>
  <Text> locationData?.address.country</Text>
</Modal>
```
## Routing in Expo
If you haven't already installed it you can install it with
`npm expo install expo-router`




## Calculate the Route to a location
The *Directions API* from Mapbox allows you to create Routes to locations.