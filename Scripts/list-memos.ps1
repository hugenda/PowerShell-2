﻿<#
.SYNOPSIS
	list-memos.ps1 
.DESCRIPTION
	Lists all memos in $HOME/Memos.csv.
.EXAMPLE
	PS> .\list-memos.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>


try {
	$Path = "$HOME/Memos.csv"
	if (test-path "$Path" -pathType leaf) {
		write-progress "Reading $Path ..."
		$Table = import-csv "$Path"
		write-progress -completed "Reading $Path"

		""
		"Time                 User  Text"
		"----                 ----  ----"
		foreach($Row in $Table) {
			$Time = $Row.Time
			$User = $Row.User
			$Text = $Row.Text
			"$Time $User    $Text"
		}
	} else {
		"Sorry, no memos saved yet"
		exit 1
	}
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
