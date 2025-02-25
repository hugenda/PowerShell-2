﻿<#
.SYNOPSIS
	introduce-powershell.ps1
.DESCRIPTION
	Introduces PowerShell to new users.
.EXAMPLE
	PS> .\introduce-powershell.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	& "$PSScriptRoot/write-big.ps1" "PowerShell"

	& "$PSScriptRoot/write-animated.ps1" "Welcome to PowerShell"
	& "$PSScriptRoot/write-animated.ps1" "Feel the power of the console and scripting"

	""
	"* Want to learn PowerShell? See the tutorials at: https://www.guru99.com/powershell-tutorial.html"
	""
	"* Need documentation? See the PowerShell docs at: https://docs.microsoft.com/en-us/powershell/"
	""
	"* Want sample scripts? See PowerShell Scripts at: https://github.com/fleschutz/PowerShell/"
	""

	& "$PSScriptRoot/write-typewriter.ps1" "P.S. PowerShell is looking forward to execute your next command"
	""

	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
