﻿<#
.SYNOPSIS
	convert-csv2txt.ps1 [<csv-file>]
.DESCRIPTION
	Converts a .CSV file into a text file.
.EXAMPLE
	PS> .\convert-csv2txt.ps1 salaries.csv
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Path = "")

try {
	if ($Path -eq "" ) { $Path = read-host "Enter path to CSV file" }

	$Table = Import-CSV -path "$Path" -header A,B,C,D,E,F,G,H

	foreach($Row in $Table) {
		write-output "* $($Row.A) $($Row.B) $($Row.C) $($Row.D) $($Row.E) $($Row.F) $($Row.G) $($Row.H)"
	}
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
