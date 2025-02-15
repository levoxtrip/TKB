---
comments: true
tags:
    - Javascript
    - ReactNative
    - ReactNative/Library
---

# Mapbox React Native
## Installation
Installing packages for expo
`npm install @rnmapbox/maps`

## Configuration
For iOS, Android and Expo there are different configurations you can find here
[Configurations Platforms](https://rnmapbox.github.io/docs/install?configure-module=expo)

For expo:
Set `RNMapboxMapsDownloadToken` to your secret token. 

Add `RNMapboxMapsDownloadToken` to the `@rnmapbox/maps` config plugin in the plugs array of your app.

Then add you key in the the config.js/app.js

```JS
{
  "expo": {
    "plugins": [
      [
// highlight-start
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
## Rebuild app`
`expo prebuild --clean`


## Configure permissions for location access
To show the location puck on the map with the `LocationPuck` component you use the `expo-location` plugin to configure the requires `NSLocationWhenInUseUsageDescription` property.

Install the plugin with `npx expo install expo-location` and add its config plugin to the plugins array
```JS
{
  "expo": {
    "plugins": [
// highlight-start
      [
        "expo-location",
        {
          "locationWhenInUsePermission": "Show current location on map."
        }
      ]
// highlight-end
    ]
  }
}
```




[Mapbox Github Link](https://github.com/rnmapbox/maps)



!!!
In the App.js you use the public token or your secret token from mapbox and in the app.json file you use your download token.
You can also set up your secret token in an env file