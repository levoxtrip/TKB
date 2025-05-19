---
- VVVV
- VVVV/Collections
comments: true
---

![alt text](./img/RemoveRandomSlicesFromSpread.png)
# Remove Random Slices from Spread and Regenerate 
If we wan't to set an amount of random positions on the start we can assign `RandomSpread` to the `Create` operation. We than store that into a `Pad`.
With `RemoveSliceAt` we remove a slide from the spread every time the `LFO` triggers *On New Cycle*.
We also check if the length of the spread is 0. Then we add a new `RandomSpread` of values to the `Pad`.

