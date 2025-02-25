﻿<#
.SYNOPSIS
	write-rot13.ps1 [<text>]
.DESCRIPTION
	Prints the given text encoded or decoded with ROT13.
.EXAMPLE
	PS> .\write-rot13.ps1 "Hello World"
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

function ROT13 { param([string]$text)
	$text.ToCharArray() | ForEach-Object {
		if ((([int] $_ -ge 97) -and ([int] $_ -le 109)) -or (([int] $_ -ge 65) -and ([int] $_ -le 77))) {
			$Result += [char] ([int] $_ + 13);
		} elseif ((([int] $_ -ge 110) -and ([int] $_ -le 122)) -or (([int] $_ -ge 78) -and ([int] $_ -le 90))) {
			$Result += [char] ([int] $_ - 13);
		} else {
			$Result += $_
		}        
	}
	return $Result
}

try {
	if ($text -eq "" ) { $text = read-host "Enter text to write" }

	$Result = ROT13 $text
	write-output $Result
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
