; GLOBAL SOUND UP
!WheelUp::
SoundSet, +5
return


; GLOBAL SOUND DOWN
!WheelDown::
SoundSet, -5
return

DetectHiddenWindows, On

; Get the HWND of the Spotify main window.
getSpotifyHwnd() {
	WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
	Return spotifyHwnd
}

; Send a key to Spotify.
spotifyKey(key) {
	spotifyHwnd := getSpotifyHwnd()
	; Chromium ignores keys when it isn't focused.
	; Focus the document window without bringing the app to the foreground.
	ControlFocus, Chrome_RenderWidgetHostHWND1, ahk_id %spotifyHwnd%
	ControlSend, , %key%, ahk_id %spotifyHwnd%
	Return
}

; Win+alt+o: Show Spotify
#!o::
{
	spotifyHwnd := getSpotifyHwnd()
	WinGet, style, Style, ahk_id %spotifyHwnd%
	if (style & 0x10000000) { ; WS_VISIBLE
		WinHide, ahk_id %spotifyHwnd%
	} Else {
		WinShow, ahk_id %spotifyHwnd%
		WinActivate, ahk_id %spotifyHwnd%
	}
	Return
}

; Win+alt+{p/up/down}: Play/Pause
#!p::
#!Up::
#!Down::
{
	spotifyKey("{Space}")
	Return
}

; Win+alt+right: Next
#!Right::
{
	spotifyKey("^{Right}")
	Return
}

; Win+alt+up: Previous
#!Left::
{
	spotifyKey("^{Left}")
	Return
}


; shift+volumeUp: Volume up
#!WheelUp::
{
	spotifyKey("^{Up}")
	Return
}

; shift+volumeDown: Volume down
#!WheelDown::
{
	spotifyKey("^{Down}")
	Return
}
