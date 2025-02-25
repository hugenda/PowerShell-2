﻿<#
.SYNOPSIS
	list-recycle-bin.ps1 
.DESCRIPTION
	Lists the content of the recycle bin folder.
.EXAMPLE
	PS> .\list-recycle-bin.ps1 
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	(New-Object -ComObject Shell.Application).NameSpace(0x0a).Items() | Select-Object Name,Size,Path
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
