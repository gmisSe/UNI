#Requires AutoHotkey v2


a::WinSetKeyboardLayout("67896332") ; French
b::WinSetKeyboardLayout("67699721") ; English   

WinSetKeyboardLayout(layout, winTitle := "A") => PostMessage(0x50, 0, layout, , winTitle)