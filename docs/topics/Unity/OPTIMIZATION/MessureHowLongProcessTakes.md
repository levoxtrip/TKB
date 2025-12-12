---
comments: true
tags:
 - Unity
 - Unity/Optimization

---

# Measure how long a process in code takes

```C#
System.Diagnostics.Stopwatch sw;
...
private void Start()
    {
         sw = new System.Diagnostics.Stopwatch();
        sw.Start();
		....
		sw.Stop();
        Debug.Log(operationHandle.Result.name + " took to load in Milliseconds: " + sw.Elapsed.TotalMilliseconds);
    }

```