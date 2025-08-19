#Requires AutoHotkey v2.0

GetCurrentKeyboardLayout() {
    threadID := DllCall("GetWindowThreadProcessId", "ptr", WinActive("A"), "uint*", 0, "uint")
    hkl := DllCall("GetKeyboardLayout", "uint", threadID, "ptr")
    return Format("0x{:04X}", hkl & 0xFFFF)
}

MsgBox "Current Keyboard Layout: " GetCurrentKeyboardLayout()