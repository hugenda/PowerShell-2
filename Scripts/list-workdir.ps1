﻿<#
.SYNOPSIS
	list-workdir.ps1 
.DESCRIPTION
	Lists the current working directory.
.EXAMPLE
	PS> .\list-workdir.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$CWD = resolve-path "$PWD"
	"📂$CWD"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
