﻿<#
.SYNOPSIS
	set-profile.ps1
.DESCRIPTION
	Sets the PowerShell profile for the current user.
.EXAMPLE
	PS> .\set-profile.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$PathToProfile = $PROFILE.CurrentUserCurrentHost
	$PathToRepo = "$PSScriptRoot/.."

	copy-item "$PathToRepo/Scripts/my-profile.ps1" "$PathToProfile" -force

	"✔️ updated PowerShell profile 'CurrentUserCurrentHost' by my-profile.ps1 - it gets active on next login"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
