﻿<#
.SYNOPSIS
	list-scripts.ps1
.DESCRIPTION
	Lists all PowerShell scripts in this repository (sorted alphabetically).
.EXAMPLE
	PS> .\list-scripts.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

function ListScripts { param([string]$FilePath)
	write-progress "Reading $FilePath..."
	$Table = import-csv "$FilePath"
	foreach($Row in $Table) {
		New-Object PSObject -Property @{
			'PowerShell Script' = "$($Row.Script)"
			'Description' = "$($Row.Description)"
		}
	}
	$global:NumScripts = $Table.Count
	write-progress -completed "Reading $FilePath..."
}

try {
	$PathToRepo = "$PSScriptRoot/.."
	ListScripts "$PathToRepo/Data/scripts.csv" | format-table -property "PowerShell Script",Description

	"✔️ $($global:NumScripts) PowerShell scripts total"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
