﻿<#
.SYNOPSIS
	download-file.ps1 [<URL>]
.DESCRIPTION
	Downloads a file from the given URL.
.EXAMPLE
	PS> .\download-file.ps1 "https://www.cnn.com/index.html"
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$URL = "")

try {
	if ($URL -eq "") { $URL = read-host "Enter file URL to download" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	& wget --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'wget' - make sure wget is installed and available" }

	& wget --mirror --convert-links --adjust-extension --page-requisites --no-parent $URL --directory-prefix . --no-verbose
	if ($lastExitCode -ne "0") { throw "Can't execute 'wget --mirror $URL'" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ downloaded file from $URL in $Elapsed sec"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
