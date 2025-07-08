---
comments: true
tags:
  - JavaScript
  - JavaScript/React
  - React
---
# React FirebseDatabase

If you need router
`npm install react-router-dom`

To use Environment files to store your keys
`npm install dotenv`

For Firebase
`npm install firebase`

## Connect React to Firebase
Create new Firebase Project

Register an App in firebase for web

Go to realtime database and setup the database - creating the database.

Change database rules to 
.read :true
.write : true

Grab firebase configurations by clicking on whe gear settings
We need the database url 
also we can copy the code to 

Create in `src` a file. `firebaseConfig.js`

Add `databaseURL:` parameter in the the firebaseConfig object
You can find the databaseURL in the Realtime Database window its the `htpps://fir.-number-default...` next to the link sign

Add it in the object

We should save the important data of firebase config inside an .env file
Don't change the naming in the file. pass the data from the `firebaseConfig` into the env
```
6. create a dotenv file at the root of your project:
REACT_APP_FIREBASE_API_KEY="..."
REACT_APP_FIREBASE_AUTH_DOMAIN="..."
REACT_APP_FIREBASE_DATABASE_URL="a.."
REACT_APP_FIREBASE_PROJECT_ID=".."
REACT_APP_FIREBASE_STORAGE_BUCKET="..."
REACT_APP_FIREBASE_MESSAGING_SENDER_ID="..."
REACT_APP_FIREBASE_APP_ID="..."
REACT_APP_FIREBASE_MEASUREMENT_ID="..."
```

Now pass the REACT_APP_FIREBASE_API_KEY etc variables and pass them into `firebaseConfig.js`

Don't forget to add 
`export default firebaseConfig` in the `firebaseConfig.js`

## Write

Create a Write Component `Write.ts`

```JS
import app from '../firebaseConfig'
import React, {useState} from 'react'
import {getDatabase,ref,set,push} from "firebase/database"

const saveData = async () => {
    //Get the database
    const db = getDatabase()
    //Define what and where we push/save the data
    //we reference the database db, with "nature/fruits" we create a folder and subfolder where e store the data in
    const newDocRef = push(ref(db, "nature/fruits"))
    // To save the data we use set and define where we are saving the data in the database with the newDocRef and what we save in the object
    set(newDocRef, {
        fruitName: inputValue1,
        fruitDefinition:inputValue2
    }).then(()=> {
        ///When successful
        alert("data saved successfully")
    }).catch((error) => {
        //When not successful
        alert("error: ", error.message)
    })
}


function Write(){
    const [inputVal,setInputVal] = useState("");
    const [inputVal2,setInputVal2] = useState("");
    return (
        <div>
        <input type="text" value={inputVal} onChange={(e)=>setInputVal(e.target.value)}/>
        <input type="text" value={inputVal2} onChange={(e)=>setInputVal2(e.target.value)}/>

        <button onClick={saveData}>Save Data </button>
        </div>
    )
}
```

Important to add to your `.gitignore` to ignore the .env file otherwise you get problems when you host it

## Read
Create a `Read.js` compontent
`rfce`

Now we need to import the `get` function from firebase
```JS
import {getDatabase,ref,get} from 'firebase/database'
import app from '../firebaseConfig'

function Read() {
    let {fruitArray, setFruitArray} = useState([]);

    const fetchData = async () => {
        const db = getDatabase(app);
        //create a reference where the data is - database - folder structure
        const dbRef = ref(db,"nature/fruits");
        // make a snapshot
        const snapshot = await get(dbRef);

        if(snapshot.exists()){
            setFruitArray(Object.values(snapshot.val()))
        } else {
            alert("error")
        }
    }

    return(
        <div>
            <button onClick={fetchData}>Display Data</button>
            <>
            <ul>
            {
                fruitArray.map((item,index)=> (
                    <li key= {index}>
                    {item.fruitName}: {item.fruitDefinition}
                    </li>
                ))}
                </>
            </ul>
        </div>
    )
}
```
`snapshot.val()` gets the data from the database but with the uuid like
```
BEFORE SNAPSHOT.VAL() -- JSON LIKE FORMAT
{
  "fruit1Id": {
    fruitName: "apple", 
    fruitDefinition: "red fruit"
  },
  "fruit2Id": {
    fruitName: "banana",
    fruitDefinition: "yellow  fruit"
  }
}


AFTER SNAPSHOT.VAL() -- JAVASCRIPT OBJECT
{
    "fruit1Id": {
      fruitName: "apple",
      fruitDefinition: "red fruit"
    },
    "fruit2Id": {
      fruitName: "banana",
      fruitDefinition: "yellow  fruit"
    }
}

OPTION 1: AFTER OBJECT.VALUES(SNAPSHOT.VAL()) -- AN ARRAY OF JAVASCRIPT OBJECTS
[
    {
      fruitName: "apple",
      fruitDefinition: "red fruit"
    },
    {
      fruitName: "banana",
      fruitDefinition: "yellow  fruit",
      fruitId: "fefwef2f"
    }
]
```

## Update Data
So we need to grab the unique identification number of the data and then display it on the frontadd

So you don't want to rewrite everything every time so you grad the element with the uuid and then change only that one.

### Update Read

`UpdateRead.js`

To get the keys of an element from our database we can call `Object.Keys` this give us the key of the element
```
AFTER CALLING OBJECT.KEYS(SNAPSHOT.VAL())
[
  "-NfCnDYK3ZUCQgQ90A1b",
  "-NfCnDYK3ZUCQgQ90C3c"
] 
```

```JS
...
const fetchData = () => {
    const db = getDatabase(app);
    const dbRef = ref(db,"nature/fruits");
    const snapshot = await get(dbRef);
    if(snapshot.exists()){
        const myData = snapshot.val();
        //Object.key Gives us an array of the uuids of our elements
        const tempArray = Object.key(myData).map(fireUUID => {
            return {
                //this will return the object fields from the json
                ...myData[fireUUID],
                elementID:fireUUID//adding a UUID field for the new array
            }
        })
        setFruitArray(temporaryArray);
    } else {
        alert("error")
    }
}
return(
    ...
    {item.elementID}
)
```



### Update Write
Update write component
When we update data most of the time we want to show the currently data
for that we first fetch the data in an `useEffect()`
```JS
...

useEffect(()=> {
    const fetchData = async () => {
        const db = getDatabase(app);
        const dbRef = ref(db, "nature/fruits/"+UUIDElement);
        const snapshot = await get(dbRef);
        if(snapshot.exists()) {
            const targetObject = snapshot.val()
            setInputValue1(targetObject.fruitName)
            setInputValue2(targetObject.fruitDescription)
        }else {
            alert("error")
        }
    }
    fetchData();
})

const overWriteData = async () => {
    const db = getDatabase(app);
    const newDocRef = ref(db, "nature/fruits/"+UUIDElement);
    set(newDocRef, {
        fruitName:inputValue1,
        fruitDefintion:inputValue2
    }).then(()=> {
        alert("data uptaded successfullY")
    }).catch((error)=> {
        alert("Error:", error.message)
    })
}
```
### Delete Data
```JS
import {getDatabase,ref,get,remove} from 'firebase/database'

const deleteFruit = async (UUID) => {
    const db = getDatabase(app);
    const dbRef = ref(db, "nature/fruits/"+UUID)
    await remove(dbRef);
    window.location.reloat();
}
...

<button onClick={deleteFruit}>Delete</button>
```