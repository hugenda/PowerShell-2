﻿<#
.SYNOPSIS
	list-voices.ps1 
.DESCRIPTION
	Lists the installed text-to-speech (TTS) voices
.EXAMPLE
	PS> .\list-voices.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#Requires -Version 2.0

try {
	Add-Type -AssemblyName System.Speech
	$Synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
	$Synth.GetInstalledVoices() | 
	    Select-Object -ExpandProperty VoiceInfo | 
	    Select-Object -Property Name, Culture, Gender, Age

	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
