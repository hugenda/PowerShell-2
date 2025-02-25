﻿<#
.SYNOPSIS
	check-subnet-mask.ps1 [<address>]
.DESCRIPTION
	Checks the given subnet mask for validity.
.EXAMPLE
	PS> .\check-subnet-mask.ps1 255.255.255.0
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

param([string]$address = "")

function IsSubNetMaskValid { param([string]$IP)
	$RegEx = "^(254|252|248|240|224|192|128).0.0.0$|^255.(254|252|248|240|224|192|128|0).0.0$|^255.255.(254|252|248|240|224|192|128|0).0$|^255.255.255.(255|254|252|248|240|224|192|128|0)$"
	if ($IP -match $RegEx) {
		return $true
	} else {
		return $false
	}
}

try {
	if ($address -eq "" ) { $address = read-host "Enter subnet mask to validate" }

	if (IsSubNetMaskValid $address) {
		"✔️ subnet mask $Address is valid"
		exit 0
	} else {
		write-warning "Invalid subnet mask: $address"
		exit 1
	}
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
