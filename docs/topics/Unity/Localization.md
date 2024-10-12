---
tags:
  - Unity
---

# Localization - Multiple Languages in Unity

## Install package
Go to the package Manager - Unity Registry - Localization - Install it
## Create Localization Asset 
Project Settings - Localization - Create Active Localisation Settings - Create New Folder To Save Localization Files
## Select Language
Unity syntax for Language is `locale`
Select which languages you need under `localeGenerator`
Create new Folder *locals* and save the locals in there.

## Select default language
Specific Locale Selector - Assign default language locale
Match project language with default language - Project Locale Identifier -> to default language

## Change the text depending on language
Go to window - Asset Management - Localization Tables.
Select new StringTable Collection - Create

Create a key - This key holds a reference for the entries in the table

Click on brackets Localization Icon and make sure that `Preload all tables` is checked.

Add `Localize String Event` to the TextMeshPro Element.

Select the table and the key you want to use.

Now we need to tell unity which text to controll.

Assign TextMeshPro Text Comp to `Update String Event`
Choose TextmeshPro and pick `text`

## How to change the language using a button
Create a Script `LocaleSelector`

```C#
...
using UnityEngine.Localization.Settings

public class LocaleSelector : MonoBehaviour
{
    private bool active = false;
    public void ChangeLocale(int localeID){
        if(active==true)
            return;
        StartCoroutine(SetLocale(localeID))
    }



    IEnumerator SetLocale(int _localeID){
        active = true;
        yield return LocalizationSettings.InitializationOperation;
        //Making sure Localization is loaded
        LocalizationSettings.SelectedLocale = LocalizationSettings.AvailableLocales.Locales[_localeID];
        //ID is the number of the locale in the settings
        active = false;
    }

}
```

Assign Skript to Component *Localization Manager*
Drag Localization Manager Object into the *OnClick* Event of the buttons and pick the corresponding id of your language.

## You can save the players decision then as default

```C#

private void Start(){
    int ID = PlayerPrefs.GetInt("LocaleKey",0)
    ChangeLocale(ID)
}
...
IEnumerator SetLocale(int _localeID){
        active = true;
        yield return LocalizationSettings.InitializationOperation;
        //Making sure Localization is loaded
        LocalizationSettings.SelectedLocale = LocalizationSettings.AvailableLocales.Locales[_localeID];
        PlayerPrefs.SetInt("LocaleKey",_localeID)
        //ID is the number of the locale in the settings
        active = false;
    }

```

## Change assets depending on language
Add:
if you want to change a spirte -> `localize Sprite Event`
if you want to change Audio -> `localize AudioClip Event`

Add new Asset Table Collection