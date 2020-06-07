#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Beginning of actual script
#include <Vis2>
#include <GDIP_All>

f7::
	pToken := Gdip_Startup()
	snap := Gdip_BitmapFromScreen("479|399|973|50")
	Gdip_SaveBitmapToFile(snap, "cache/Shot.png")
	Gdip_DisposeImage(snap)
	text := OCR("cache/Shot.png")
	MsgBox % text
	Exit

