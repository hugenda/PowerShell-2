﻿<#
.SYNOPSIS
	speak-test.ps1
.DESCRIPTION
	Performs a text-to-speech (TTS) test.
.EXAMPLE
	PS> .\speak-test.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

function Speak { param([string]$Text)
	write-output "'$Text'"
	[void]$Voice.speak("$Text")
}

try {
	$Voice = new-object -ComObject SAPI.SPVoice
	$DefaultVolume = $Voice.volume
	$DefaultRate = $Voice.rate
	Speak("This is the default voice with default volume $DefaultVolume and speed $DefaultRate")

	$Voice.rate = -10
	Speak("Let's speak very, very slow")
	$Voice.rate = -5
	Speak("Let's speak very slow")
	$Voice.rate = -3
	Speak("Let's speak slow")
	$Voice.rate = 0
	Speak("Let's speak normal")
	$Voice.rate = 2
	Speak("Let's speak fast")
	$Voice.rate = 5
	Speak("Let's speak very fast")
	$Voice.rate = 10
	Speak("Let's speak very, very fast")
	$Voice.rate = $DefaultRate

	$Voice.volume = 100
	Speak("Let's try 100% volume")
	$Voice.volume = 75
	Speak("Let's try 75% volume")
	$Voice.volume = 50
	Speak("Let's try 50% volume")
	$Voice.volume = 25
	Speak("Let's try 25% volume")
	$Voice.volume = $DefaultVolume

	$Voices = $Voice.GetVoices()
	foreach ($OtherVoice in $Voices) {
		$Voice.Voice = $OtherVoice
		$Description = $OtherVoice.GetDescription()
		Speak("Hi, I'm the voice called $Description")
	}
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
