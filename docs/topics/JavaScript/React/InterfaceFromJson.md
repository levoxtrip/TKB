---
comments: true
tags:
    - Typescript
    - ReactNative
    - React
    - Json
---
# Interface from JSON
We can write *interfaces* in an own file and then just import the when we need them
`stationData.ts`
```ts
export interface StationData {
    stationId: number
    stationTypeIndex: number
    mapLinks: MapLinks
    languages: Language[]
    image: string
  }
  
  export interface MapLinks {
    google: string
  }
  
  export interface Language {
    language: string
    title: string
    description: string
  }
  
//Component
import {StationData} from "../data/stationData"
...

const stationData = data[stationIndex] as StationData;

```
