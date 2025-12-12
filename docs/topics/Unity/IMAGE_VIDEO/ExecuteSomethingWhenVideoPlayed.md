---
comments: true
tags:
 - Unity
 - Unity/ImageVideo

---

# Execute Something When Video Played

```C#

[SerializeField] UnityEngine.Video.Videoplayer myVideoplayer;

void OnEnable(){
	StartCoroutine("DoWhenFinished")
}

private IEnumerator DoWhenFinished(){
yield return new WaitForSeconds((float)myVideoPlayer.clip.length);
or
yield return new WaitForSeconds(myAudioSource.clip.length);
//Do something after video is finished
}
```