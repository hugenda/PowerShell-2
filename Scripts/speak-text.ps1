﻿<#
.SYNOPSIS
	speak-text.ps1 [<text>]
.DESCRIPTION
	Speaks the given text by text-to-speech (TTS).
.EXAMPLE
	PS> .\speak-text.ps1 "Hello World"
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Text = "")

try {
	if ($Text -eq "") { $Text = read-host "Enter the text to speak" }

	$Voice = new-object -ComObject SAPI.SPVoice
	$Result = $Voice.Speak($Text)
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
