---
comments: true
tags:
 - TD/QuickTips
 - TD/UI
 - TD/COMP
---

![Open the Filepicker](./img/OpenFilePickerBtn.png)

# Open File Picker Window on Button

To allow a user to select a new image source using the operating system's File Picker window, you can write a script that executes when a button is pressed. The script to open the File Picker is: `path = ui.chooseFile(fileTypes=['mov','mp4'])`. The `ui.chooseFile()` function launches the File Picker window and returns the path of the selected file, which is stored in the variable `path`. You can then assign this path to a `moviefileinTOP` to load the selected source.

[DownloadFile](./files/OpenFilePickerViaBtn.tox)