﻿<#
.SYNOPSIS
	restart-network-adapters.ps1
.DESCRIPTION
	Restarts all local network adapters (needs admin rights).
.EXAMPLE
	PS> .\restart-network-adapters.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	htts://github.com/fleschutz/PowerShell
#>

#Requires -RunAsAdministrator

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Get-NetAdapter | Restart-NetAdapter 

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ restarted all local network adapters in $Elapsed sec"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
