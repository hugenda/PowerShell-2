﻿<#
.SYNOPSIS
	list-os-releases.ps1
.DESCRIPTION
	Lists OS releases and download URL.
.EXAMPLE
	PS> .\list-os-releases.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	write-progress "Reading OS_IPFS_hashes.csv ..."

	$PathToRepo = "$PSScriptRoot/.."
	$PathToCsvFile = "$PathToRepo/Data/os-release.csv"
	invoke-webRequest -URI "https://fleschutz.droppages.com/downloads/OS_IPFS_hashes.csv" -outFile "$PathToCsvFile"

	$Table = import-csv "$PathToCsvFile"
	remove-item -path "$PathToCsvFile"

	write-output "Operating System Releases"
	write-output "========================="
	foreach ($Row in $Table) {
		write-output "* $($Row.Path.substring(3)) -> ipfs://$($Row.IPFS)"
	}
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
