﻿<#
.SYNOPSIS
	list-anagrams.ps1 [<word>] [<columns>]
.DESCRIPTION
	Lists all anagrams of the given word.
.EXAMPLE
	PS> .\list-anagrams.ps1 Markus
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Word = "", [int]$Columns = 8)

function GetPermutations {
    [cmdletbinding()]
    Param(
        [parameter(ValueFromPipeline=$True)]
        [string]$String = 'the'
    )
    Begin {
        Function NewAnagram { Param([int]$NewSize)              
            if ($NewSize -eq 1) {
                return
            }
            for ($i=0;$i -lt $NewSize; $i++) { 
                NewAnagram  -NewSize ($NewSize - 1)
                if ($NewSize -eq 2) {
                    New-Object PSObject -Property @{
                        Permutation = $stringBuilder.ToString()                  
                    }
                }
                MoveLeft -NewSize $NewSize
            }
        }
        Function MoveLeft { Param([int]$NewSize)        
            $z = 0
            $position = ($Size - $NewSize)
            [char]$temp = $stringBuilder[$position]           
            for ($z=($position+1);$z -lt $Size; $z++) {
                $stringBuilder[($z-1)] = $stringBuilder[$z]               
            }
            $stringBuilder[($z-1)] = $temp
        }
    }
    Process {
        $size = $String.length
        $stringBuilder = New-Object System.Text.StringBuilder -ArgumentList $String
        NewAnagram -NewSize $Size
    }
    End {}
}

try {
	if ($Word -eq "" ) {
		$Word = read-host "Enter word"
		$Columns = read-host "Enter number of columns"
	}
	GetPermutations -String $Word | Format-Wide -Column $Columns
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
