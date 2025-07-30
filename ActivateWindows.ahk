#Requires AutoHotkey v2.0
#SingleInstance Force
SetWorkingDir A_ScriptDir

Start(appname, runpath) {
    Run runpath
}

StartActivateOrCycle(appname, runpath) {
    if WinActive("ahk_exe " appname) {
        WinActivateBottom("ahk_exe " appname)
    } else if WinExist("ahk_exe " appname) {
        WinActivate("ahk_exe " appname)
    } else {
        Run runpath
    }
}

StartActivateOrCycleClass(classname, runpath) {
    if WinActive("ahk_class " classname) {
        WinActivateBottom("ahk_class " classname)
    } else if WinExist("ahk_class " classname) {
        WinActivate("ahk_class " classname)
    } else {
        Run runpath
    }
}

StartActivateOrCycleTitle(wintitle, runpath) {
    if WinActive(wintitle) {
        WinActivateBottom(wintitle)
    } else if WinExist(wintitle) {
        WinActivate(wintitle)
    } else {
        Run runpath
    }
}

CenterMouseOnActiveWindow() {
    Sleep 50
    CoordMode "Mouse", "Screen"
    WinGetPos &x, &y, &w, &h, "A"
    centerX := x + w / 2
    centerY := y + h / 2
    DllCall("SetCursorPos", "int", centerX, "int", centerY)
}

StripClipboardFormatting() {
    A_Clipboard := A_Clipboard
}

ClipboardForwardifySlashes() {
    if InStr(A_Clipboard, "\\") {
        A_Clipboard := StrReplace(A_Clipboard, "\\", "/")
    } else if InStr(A_Clipboard, "//") {
        A_Clipboard := StrReplace(A_Clipboard, "//", "/")
    } else {
        A_Clipboard := StrReplace(A_Clipboard, "/", "//")
    }
}

ClipboardBackifySlashes() {
    if InStr(A_Clipboard, "/") {
        A_Clipboard := StrReplace(A_Clipboard, "/", "\\")
    } else if InStr(A_Clipboard, "\\\\") {
        A_Clipboard := StrReplace(A_Clipboard, "\\\\", "\\")
    } else {
        A_Clipboard := StrReplace(A_Clipboard, "\\", "\\\\")
    }
}

#!^+k::CenterMouseOnActiveWindow()
#!^+f::StripClipboardFormatting()
#!^+/::ClipboardForwardifySlashes()
#!^+\::ClipboardBackifySlashes()

#!^+c::Start("msedge.exe", "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe")
#!^+b::Start("brave.exe", "brave.exe")
#!^+a::StartActivateOrCycleTitle("Calculator", "C:\\Windows\\system32\\calc.exe")

::td::{
    SendText FormatTime(A_Now, "yyyy-MM-dd")
}
