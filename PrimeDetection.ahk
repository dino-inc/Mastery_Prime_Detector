#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Beginning of actual script
#include <Vis2>
#include <GDIP_All>

f7::
	pToken := Gdip_Startup()
	boxX := 479
	Loop, 4
	{
		numbers := boxX "|410|238|50"
		snap := Gdip_BitmapFromScreen(numbers)
		filename := "cache/Shot" A_index ".png"
		Gdip_SaveBitmapToFile(snap, filename)
		Gdip_DisposeImage(snap)
		text := text OCR(filename)
		boxX := boxX + 243
	}

	MsgBox % text
	text := ""
	Exit

