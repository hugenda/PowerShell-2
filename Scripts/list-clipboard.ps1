﻿<#
.SYNOPSIS
	list-clipboard.ps1
.DESCRIPTION
	Lists the contents of the clipboard.
.EXAMPLE
	PS> .\list-clipboard.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	"📋 $(get-clipboard)"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
