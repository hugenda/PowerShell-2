﻿<#
.SYNOPSIS
	check-file-system.ps1 [<drive>] 
.DESCRIPTION
	Checks the file system of a drive (needs admin rights)
.EXAMPLE
	PS> .\check-file-system.ps1 C
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

#Requires -RunAsAdministrator

param([string]$Drive = "")

try {
	if ($Drive -eq "" ) { $Drive = read-host "Enter drive (letter) to check" }

	$Result = repair-volume -driveLetter $Drive -scan
	if ($Result -ne "NoErrorsFound") { throw "'repair-volume' failed" }

	"✔️ file system on drive $Drive is clean"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
