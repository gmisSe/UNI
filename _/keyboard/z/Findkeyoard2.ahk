#Requires AutoHotkey v2

MsgBox "`"" WinGetKeyboardLayout() "`""
A_Clipboard := WinGetKeyboardLayout()

WinGetKeyboardLayout(wintitle := "A") {
; https://www.autohotkey.com/boards/viewtopic.php?f=82&t=136834&sid=e635df54e0df603943305f8aa2f23968#p602091
    static WindowThread(hwnd) => DllCall("GetWindowThreadProcessId", "ptr", hwnd, "ptr", 0, "int")
    static KeyboardLayout(threadId) => DllCall("GetKeyboardLayout", "Uint", threadId, "ptr")
    return KeyboardLayout(WindowThread(WinGetID(wintitle)))
}