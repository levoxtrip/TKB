---
comments: true
tags:
 - Unity
 - Unity/Optimization

---

# Release Unused Assets From Memory

```C#
  Resources.UnloadAsset(assetname);
  assetname = null;
```