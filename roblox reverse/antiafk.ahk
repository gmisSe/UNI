#Requires AutoHotkey v2.0

loop {
    if WinExist("ahk_exe RobloxPlayerBeta.exe") {
        try prevWindow := WinGetID("A")
        WinActivate("ahk_exe RobloxPlayerBeta.exe")
        Send("{Escape}")
        try WinActivate("ahk_id" prevWindow)
    }
    sleep(500000)
}