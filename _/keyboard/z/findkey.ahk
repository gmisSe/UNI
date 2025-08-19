#Requires AutoHotkey v2.0
InstallKeybdHook
caracter := '"'
sc_code := GetKeySC(caracter)
vkcode := GetKeyVK(caracter)


F1::KeyHistory()