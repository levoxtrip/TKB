---
comments: true
tags:
  - Unity
---
# Tipps and tricks
## Serialising Components
Always serialize what you need not the whole `gameObject`

```C#

[SerializeField] AudioSource _carrotPrefab;
...

void Update(){
    if(Input.GetKeyDown(KeyCode.Space)){
        var audioS = Instantiate(_carrotPrefab,transform.gameobject);
        audioS.playAudiOneShot();
    }
}
```

## Draw gizmos
To keep track of positions in the screen we can draw 
```C#
private void OnDrawGizmos(){
    Gizmos.color = Color.green;
    Gizmos.DrawSphere(_variable,0.4f);
}
```

## Calling Scripts
Rule of thumb is never call other scripts in awake. Only initialise yourself in awake


## Variable scope
The goal is to lock your scripts down as much as possible so don't make components available for the outside unless they really need to.

So instead of setting variables `public` that you need to be accessed from outside 
you should create a getter
```C#
//Read only for external scripts
int CarrotsSpawned {get;private set;}
//To serialize it you need to add a serialize field
[field:SerializeField] int CarrotsSpawned {get;private set;}

//The shorthand version of that is
public Carrot CarrotPrefab => _carrotPrefab

```

## Iterating through collection with Modulo
If you want to iterate through a collection and want to set the index back at the end
```C#

private int _clipIndex;

_clips[_clipIndex++%_clips.Length]
```

## Set Position and Rotation with one call
```C#
transform.SetPositionAndRotation(Vector3.zero,Quaternion.identity);
```

## Composition
Try to keep your scripts as single purposed as possible.

## Variable Naming
Make your public variables capital `public int Variable`
Make your private variables underscore `private int _anotherVariable`
And the local variables in a function non underscore camelcase `var aThirdVariable`




