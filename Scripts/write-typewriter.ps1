﻿<#
.SYNOPSIS
	write-typewriter.ps1 [<text>] [<speed>]
.DESCRIPTION
	Writes the given text with the typewriter effect.
.EXAMPLE
	PS> .\write-typewriter.ps1 "Hello World"
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Text = "`nHello World`n-----------`nPowerShell is cross-platform`nPowerShell is open-source`nPowerShell is easy to learn`nPowerShell is fully documented`n`nThanks for watching`n`n:-)`n`n", [int]$Speed = 250) # in milliseconds

try {
	$Random = New-Object System.Random

	$Text -split '' | ForEach-Object {
		write-host -nonewline $_
		start-sleep -milliseconds $(1 + $Random.Next($Speed))
	}
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
