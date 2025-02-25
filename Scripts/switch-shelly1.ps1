﻿<#
.SYNOPSIS
	switch-shelly1.ps1 [<host>] [<turn-mode>] [<timer>]
.DESCRIPTION
	Switches a Shelly1 device in the local network.
.EXAMPLE
	PS> .\switch-shelly1.ps1 192.168.100.100 toggle 10
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Host = "", [string]$TurnMode = "", [int]$Timer = -999)

try {
	if ($Host -eq "") { $Host = read-host "Enter hostname or IP address of the Shelly1 device" }
	if ($TurnMode -eq "") { $TurnMode = read-host "Enter turn mode (on/off/toggle)" }
	if ($Timer -eq -999) { [int]$Timer = read-host "Enter timer in seconds (0=endless)" }

	$Result = Invoke-RestMethod "http://$($Host)/relay/0?turn=$($TurnMode)&timer=$($Timer)"
	
	"✔️ Shelly1 device at $Host switched to $TurnMode for $Timer second(s)"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
