﻿<#
.SYNOPSIS
	mute-audio.ps1
.DESCRIPTION
	Mutes the audio output.
.EXAMPLE
	PS> .\mute-audio.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$obj = new-object -com wscript.shell
	$obj.SendKeys([char]173)
	"🔇 audio is muted"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
