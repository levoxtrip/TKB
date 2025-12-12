---
comments: true
tags:
 - Unity
 - Unity/ImageVideo

---



# Download Image From Web

```C#
using System;

using System.Collections;

using System.Collections.Generic;

using System.IO;

using UnityEngine.Networking;

using UnityEngine;

using UnityEngine.UI;

  

public class GetImageFromServer : MonoBehaviour

{

    Image textureImage;

    [SerializeField] string imageURL;

    [SerializeField] string fileName;

    private void Start()

    {

        textureImage = GetComponent<Image>();

        StartCoroutine(LoadTextureFromTheWeb());

    }

  

    IEnumerator LoadTextureFromTheWeb()

    {

        UnityWebRequest www = UnityWebRequestTexture.GetTexture(imageURL);

        yield return www.SendWebRequest();

  

        if (www.isNetworkError || www.isHttpError)

        {

            Debug.LogError("Error: " + www.error);

        }

        else

        {

            Texture2D loadedTexture = DownloadHandlerTexture.GetContent(www);

            var bytes = loadedTexture.EncodeToPNG();

            var dirPath = Application.dataPath + "/Images/";

            if (!Directory.Exists(dirPath))

            {

                Directory.CreateDirectory(dirPath);

            }

            File.WriteAllBytes(dirPath + "Image" + ".png", bytes);

            textureImage.sprite = Sprite.Create(loadedTexture, new Rect(0f, 0f, loadedTexture.width, loadedTexture.height), Vector2.zero);

            textureImage.SetNativeSize();

  

#if UNITY_EDITOR

            UnityEditor.AssetDatabase.Refresh();

#endif

        }

    }

  

}
```
