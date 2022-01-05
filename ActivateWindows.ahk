Start(appname, runpath)
{
    Run, %runpath%
}

StartActivateOrCycle(appname, runpath)
{
	IfWinActive, ahk_exe %appname%
	{
		WinActivateBottom, ahk_exe %appname%
	}
	Else
	{
		IfWinExist, ahk_exe %appname%
		{
			WinActivate, ahk_exe %appname%
		}
		Else
		{
			Run, %runpath%
		}
	}
}

StartActivateOrCycleClass(classname, runpath)
{
	IfWinActive, ahk_class %classname%
	{
		WinActivateBottom, ahk_class %classname%
	}
	Else
	{
		IfWinExist, ahk_class %classname%
		{
			WinActivate, ahk_class %classname%
		}
		Else
		{
			Run, %runpath%
		}
	}
}

StartActivateOrCycleTitle(classname, runpath)
{
	IfWinActive, %classname%
	{
		WinActivateBottom, %classname%
	}
	Else
	{
		IfWinExist, %classname%
		{
			WinActivate, %classname%
		}
		Else
		{
			Run, %runpath%
		}
	}
}

ReloadChecked()
{
    Reload
    Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
    MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
    IfMsgBox, Yes, Run, C:\Program Files\Notepad++\notepad++.exe C:\Code\AutoHotKey\ActivateWindows.ahk
    return
}

CenterMouseOnActiveWindow()
{
    Sleep 50
    CoordMode,Mouse,Screen
    WinGetPos, winTopL_x, winTopL_y, width, height, A
    winCenter_x := winTopL_x + width/2
    winCenter_y := winTopL_y + height/2
    ;MouseMove, X, Y, 0 ; does not work with multi-monitor
    DllCall("SetCursorPos", int, winCenter_x, int, winCenter_y)
    ;Tooltip winTopL_x:%winTopL_x% winTopL_y:%winTopL_y% winCenter_x:%winCenter_x% winCenter_y:%winCenter_y%
    return
}

; https://autohotkey.com/board/topic/77815-copy-text-and-remove-all-formatting/
StripClipboardFormatting()
{
	Clipboard=%Clipboard%   ; will remove formatting
}

ClipboardForwardifySlashes()
{
	if (InStr(Clipboard, "\"))
	{
		; Change backslash to forward
		Clipboard := StrReplace(Clipboard, "\", "/")
	}
	else
	{
		; No backslashes
		if (InStr(Clipboard, "//"))
		{
			; Has double forward slash, so make back to singles
			Clipboard := StrReplace(Clipboard, "//", "/")
		}
		else
		{
			; No double forward slashes either so make doubles
			Clipboard := StrReplace(Clipboard, "/", "//")
		}
	}
}

ClipboardBackifySlashes()
{
	if (InStr(Clipboard, "/"))
	{
		; Change forward to backward
		Clipboard := StrReplace(Clipboard, "/", "\")
	}
	else
	{
		; No forward slashes
		if (InStr(Clipboard, "\\"))
		{
			; Has double back slash, so make back to singles
			Clipboard := StrReplace(Clipboard, "\\", "\")
		}
		else
		{
			; No double back slashes either so make doubles
			Clipboard := StrReplace(Clipboard, "\", "\\")
		}
	}
}

#!^+Del::ReloadChecked()
#!^+k::CenterMouseOnActiveWindow()
#!^+f::StripClipboardFormatting()

#!^+/::ClipboardForwardifySlashes()
#!^+\::ClipboardBackifySlashes()

; These are the office keys: T, Y, O, P, D, L, X, N, W
;  Teams, Yammer, Office, Powerpoint, onedrive, linkedin, excel, word

#!^+c::Start("msedge.exe", "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
#!^+b::Start("brave.exe", "brave.exe")

;#!^+r::StartActivateOrCycle("xplorer2_64.exe", "C:\Program Files\zabkat\xplorer2\xplorer2_64.exe")
;#!^+m::Start("ConEmu64.exe", "C:\Tools\cmder_mini\Cmder.exe")
#!^+a::StartActivateOrCycleTitle("Calculator", "C:\Windows\system32\calc.exe")
#!^+s::StartActivateOrCycle("speedcrunch.exe", "C:\Program Files (x86)\SpeedCrunch\speedcrunch.exe")

;#!^+c::Start("chrome.exe", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
;#!^+f::Start("firefox.exe", "C:\Program Files (x86)\Mozilla Firefox\firefox.exe")

;#!^+o::StartActivateOrCycle("outlook.exe", "C:\Program Files\Microsoft Office\Office16\OUTLOOK.EXE")
;#!^+w::Start("winword.exe", "C:\Program Files\Microsoft Office\Office16\WINWORD.EXE")
;#!^+e::Start("excel.exe", "C:\Program Files\Microsoft Office\Office16\excel.EXE")
;#!^+p::Start("powerpnt.exe", "C:\Program Files\Microsoft Office\Office16\powerpnt.EXE")

;#!^+n::StartActivateOrCycle("notepad++.exe", "C:\Program Files\Notepad++\notepad++.exe")
;#!^+y::StartActivateOrCycle("pycharm64.exe", "C:\Program Files\JetBrains\PyCharm Community Edition 2017.2.3\bin\pycharm64.exe")
;#!^+0::Start("devenv.exe", "C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\devenv.exe")
;#!^+7::Start("devenv.exe", "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe")


;^F1::StartActivateOrCycle("chrome.exe", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
;^F2::StartActivateOrCycle("thunderbird.exe", "C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe")
;^F3::StartActivateOrCycle("xplorer2_64.exe", "C:\Program Files\zabkat\xplorer2\xplorer2_64.exe")
;^F4::StartActivateOrCycle("RDCMan.exe", "C:\Program Files (x86)\Microsoft\Remote Desktop Connection Manager\RDCMan.exe")

; ^F5::StartActivateOrCycle("notepad++.exe", "C:\Program Files\Notepad++\notepad++.exe")
; ^F6::StartActivateOrCycle("pycharm64.exe", "C:\Program Files\JetBrains\PyCharm Community Edition 2017.2.3\bin\pycharm64.exe")
; ^F7::StartActivateOrCycle("devenv.exe", "C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\devenv.exe")
; ^F8::StartActivateOrCycle("devenv.exe", "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe")

; ^F9::StartActivateOrCycle("EXCEL.EXE", "C:\Program Files (x86)\Microsoft Office\Office12\EXCEL.EXE")
; ^F10::StartActivateOrCycle("WINWORD.EXE", "C:\Program Files (x86)\Microsoft Office\Office12\WINWORD.EXE")
; ^F11::StartActivateOrCycle("gimp-2.8.exe", "C:\Program Files\GIMP 2\bin\gimp-2.8.exe")

;^F11::StartActivateOrCycle("calc.exe", "C:\Windows\system32\calc.exe")
;^F12::StartActivateOrCycle("SnippingTool.exe", "C:\Windows\system32\SnippingTool.exe")

; Insert today's date (type 't' then 'd')
::td::
SendInput {Sleep 10}%A_YYYY%-%A_MM%-%A_DD%
return
