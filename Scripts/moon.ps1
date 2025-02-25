﻿<#
.SYNOPSIS
	moon.ps1
.DESCRIPTION
	Prints the current moon phase.
.EXAMPLE
	PS> .\moon.ps1.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	(Invoke-WebRequest http://wttr.in/Moon -UserAgent "curl" ).Content
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
