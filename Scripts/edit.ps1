﻿<#
.SYNOPSIS
	edit.ps1 <filename>
.DESCRIPTION
	Opens the built-in text editor to edit the given file.
.EXAMPLE
	PS> .\edit.ps1 C:\MyFile.txt
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Filename = "")

try {
	if ($IsLinux) {
		& vi "$Filename"
		if ($lastExitCode -ne "0") { throw "Can't execute 'vi' - make sure vi is installed and available" }
	} else {
		& notepad.exe "$Filename"
		if ($lastExitCode -ne "0") { throw "Can't execute 'notepad.exe' - make sure notepad.exe is installed and available" }
	}

	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
