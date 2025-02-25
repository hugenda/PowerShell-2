﻿<#
.SYNOPSIS
	smart-data2csv.ps1 [<directory>]
.DESCRIPTION
	Converts the S.M.A.R.T. JSON files in the current/given directory to a CSV table for analysis
        (use query-smart-data.ps1 to generate those JSON files).
.EXAMPLE
	PS> .\smart-data2csv.ps1.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Directory = "")

function WriteCsvHeader { param([PSCustomObject]$File) 
	foreach($Entry in $File.ata_smart_attributes.table) {
		[int]$ID = $Entry.id
		$Name = $Entry.name
		write-host -nonewline "$Name ($ID);"
	}
	write-host ""
}

function WriteCsvDataRow { param([PSCustomObject]$File) 
	foreach($Entry in $File.ata_smart_attributes.table) {
		[int]$ID = $Entry.id
		switch ($ID) {
		1 { write-host -nonewline "$($Entry.raw.value);" }
		4 { write-host -nonewline "$($Entry.raw.value);" }
		7 { write-host -nonewline "$($Entry.raw.value);" }
		9 { write-host -nonewline "$($Entry.raw.value);" }
		12 { write-host -nonewline "$($Entry.raw.value);" }
		190 { write-host -nonewline "$($Entry.raw.string);" }
		191 { write-host -nonewline "$($Entry.raw.value);" }
		192 { write-host -nonewline "$($Entry.raw.value);" }
		193 { write-host -nonewline "$($Entry.raw.value);" }
		195 { write-host -nonewline "$($Entry.raw.value);" }
		240 { write-host -nonewline "$($Entry.raw.string);" }
		241 { write-host -nonewline "$($Entry.raw.value);" }
		242 { write-host -nonewline "$($Entry.raw.value);" }
		default { write-host -nonewline "$($Entry.value);" }
		}
	}
	write-host ""
}

try {
	if ($Directory -eq "" ) {
		$Directory = "$PWD"
	}

	$Filenames = get-childitem -path "$Directory/SMART*.json"
	$ModelFamily = $ModelName = $SerialNumber = ""

	[int]$Row = 1
	foreach($Filename in $Filenames) {
		$File = get-content $Filename | ConvertFrom-Json

		if ($File.model_family -ne $ModelFamily) {
			if ($ModelFamily -eq "") {
				$ModelFamily = $File.model_family
			} else {
				write-error "Different model families: $ModelFamily vs. $($File.model_family)"
				exit 1
			}
		}
		if ($File.model_name -ne $ModelName) {
			if ($ModelName -eq "") {
				$ModelName = $File.model_name
			} else {
				write-error "Different model names: $ModelName vs. $($File.model_name)"
				exit 1
			}
		}
		if ($File.serial_number -ne $SerialNumber) {
			if ($SerialNumber -eq "") {
				$SerialNumber = $File.serial_number
			} else {
				write-error "Different serial numbbers: $SerialNumber vs. $($File.serial_number)"
				exit 1
			}
		}

		if ($Row -eq 1) {
			WriteCsvHeader $File
		}
		WriteCsvDataRow $File
		$Row++
	}
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
