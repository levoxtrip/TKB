


# React Own Learning

When you use React routing have in mind that when you change sites that doesn't trigger a full page reload. Elements like three.js need to be reinitiated and properly cleaned up.

ThreeJS doesn't automatically gets garbage collected by JS. You need to do it yourself. Dispose the textures etc.
*Implement Cleanup functionality in `useEffect`*
