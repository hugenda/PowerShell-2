﻿<#
.SYNOPSIS
	list-earthquakes.ps1
.DESCRIPTION
	Lists earthquakes with magnitude >= 6.0 for the last 30 days.
.EXAMPLE
	PS> .\list-earthquakes.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Format="csv" # csv, geojson, kml, text, xml
$MinMagnitude=5.8
$OrderBy="magnitude" # time, time-asc, magnitude, magnitude-asc

function ListEarthquakes { 
	write-progress "Loading data ..."
	$Earthquakes = (invoke-webRequest -uri "https://earthquake.usgs.gov/fdsnws/event/1/query?format=$Format&minmagnitude=$MinMagnitude&orderby=$OrderBy" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-CSV
	foreach ($Quake in $Earthquakes) {
		new-object PSObject -Property @{ Mag=$Quake.mag; Depth=$Quake.depth; Location=$Quake.place; Time=$Quake.time }
	}
}
 
try {
	ListEarthquakes | format-table -property @{e='Mag';width=5},@{e='Location';width=42},@{e='Depth';width=6},Time 
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
