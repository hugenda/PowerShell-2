﻿<#
.SYNOPSIS
	check-cpu-temp.ps1 
.DESCRIPTION
	Checks the CPU temperature.
.EXAMPLE
	PS> .\check-cpu-temp.ps1 
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

try {
	if (test-path "/sys/class/thermal/thermal_zone0/temp" -pathType leaf) {
		[int]$IntTemp = get-content "/sys/class/thermal/thermal_zone0/temp"
		$Temp = [math]::round($IntTemp / 1000.0, 1)
	} else {
		$data = Get-WMIObject -Query "SELECT * FROM Win32_PerfFormattedData_Counters_ThermalZoneInformation" -Namespace "root/CIMV2"
		$Temp = @($data)[0].HighPrecisionTemperature
		$Temp = [math]::round($Temp / 100.0, 1)
	}

	if ($Temp -gt "80") {
		write-error "⚠️ $Temp °C CPU temperature is too high!"
		exit 1
	} elseif ($Temp -lt "-20") {
		write-error "⚠️ $Temp °C CPU temperature is too low!"
		exit 1
	} elseif ($Temp -gt "50") {
		"✔️ $Temp °C CPU temperature - quite high"
	} elseif ($Temp -lt "0") {
		"✔️ $Temp °C CPU temperature - quite low"
	} else {
		"✔️ $Temp °C CPU temperature - good"
	}
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
