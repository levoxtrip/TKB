---
comments: true
tags:
 - Unity/AR
 - Unity


---

# Ray Timer
To increase performance and not to check for a touch input on every frame we can create a ray timer.

```C#
void Update(){
	if(rayTimer >= generateRayAfterSeconds)	{
		if(Input.touchCount > 0){
		//Do something
		rayTimer = 0;
				}
	} else{
	rayTimer += Time.deltaTime * 1.0f;
}
```
