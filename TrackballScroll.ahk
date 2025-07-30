#Requires AutoHotkey v2.0
#SingleInstance Force
SetWorkingDir A_ScriptDir

global wheelingSensitivity := 1
global wheelingPeriod := 1
global wheelingMouseX := 0
global wheelingMouseY := 0

XButton1::MouseClick "Middle"

XButton2:: StartWheeling()
XButton2 Up:: StopWheeling()

StartWheeling() {
    if !WinActive("ahk_class TscShellContainerClass") {
        global wheelingMouseX := 0
        global wheelingMouseY := 0
        MouseGetPos &wheelingMouseX, &wheelingMouseY
        SetTimer WatchCursor, wheelingPeriod
    }
}

StopWheeling() {
    SetTimer WatchCursor, 0
}

WatchCursor(*) {
    static wheelingNewMouseX := 0, wheelingNewMouseY := 0
    MouseGetPos &wheelingNewMouseX, &wheelingNewMouseY

    clicks := Round((wheelingNewMouseY - wheelingMouseY) / wheelingSensitivity)
    MouseMove wheelingMouseX, wheelingMouseY, 0

    if clicks > 0
        MouseClick "WheelDown", , , Abs(clicks)
    else if clicks < 0
        MouseClick "WheelUp", , , Abs(clicks)
}
