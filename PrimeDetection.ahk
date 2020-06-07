#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Beginning of actual script
#include <Vis2>
#include <GDIP_All>


f7::
	pToken := Gdip_Startup()
	boxX := 479
	primes := []
	Loop, 4
	{
		numbers := boxX "|410|238|50"
		snap := Gdip_BitmapFromScreen(numbers)
		filename := "cache/Shot" A_index ".png"
		Gdip_SaveBitmapToFile(snap, filename)
		Gdip_DisposeImage(snap)
		OCRtext := Regexreplace(OCR(filename), "[^[:alnum:]]")
		primes.Push(OCRtext)
		boxX := boxX + 243
	}
	for index, element in primes
	{
		match := CheckForOwnedPrime(element)
		if (match == True)
		{
			Gui, -caption +ToolWindow +HWNDguiID +AlwaysOnTop
			Gui, Color, EEAA99
			Gui +LastFound  
			WinSet, TransColor, EEAA99
			Gui, Add, Picture, x0 y0 w30 h29 , mastery.png
			Gui, Show, x479 y300 
		}
	}
	Exit

CheckForOwnedPrime(text) 
{
	Loop, read, suffixes.txt
	{
		text := StrReplace(text, A_LoopReadLine) 
	}
	Loop, Read, primes.txt
	{
		similarity := compareTwoStrings(text, A_LoopReadLine)
		if (similarity > .7)
		{
			return True
		} 
	}
	return False
}

; Read user profile to text file

+f7::
	Exit

; Entirely taken from https://github.com/Chunjee/string-similarity.ahk/blob/master/export.ahk, import was not working so copy/paste it is 
compareTwoStrings(param_string1,param_string2) {
	;Sørensen-Dice coefficient
	vCount := 0
	oArray := {}
	oArray := {base:{__Get:Func("Abs").Bind(0)}} ;make default key value 0 instead of a blank string
	Loop, % vCount1 := StrLen(param_string1) - 1
		oArray["z" SubStr(param_string1, A_Index, 2)]++
	Loop, % vCount2 := StrLen(param_string2) - 1
		if (oArray["z" SubStr(param_string2, A_Index, 2)] > 0) {
			oArray["z" SubStr(param_string2, A_Index, 2)]--
			vCount++
		}
	vDSC := Round((2 * vCount) / (vCount1 + vCount2),2)
	if (!vDSC || vDSC < 0.005) { ;round to 0 if less than 0.005
		return 0
	}
	if (vDSC = 1) { 
		return 1
	}
	return vDSC
}