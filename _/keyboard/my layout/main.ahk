#Requires AutoHotkey v2.0
#SingleInstance Force
#InputLevel 1
WinSetKeyboardLayout(layout, winTitle := "A") => PostMessage(0x50, 0, layout, , winTitle)

WinSetKeyboardLayout("67896332") ; French
Run("frToDevorak.ahk")
sleep 1000 
WinSetKeyboardLayout("67699721") ; English 
Run("egToDevorak.ahk")

XButton2::
{
    Send("{LWin Down}{Shift Down}S{Shift Up}{LWin Up}")
}

XButton1::
{
    send("{Alt down}{Tab}{Alt up}")
}

^+r::Reload