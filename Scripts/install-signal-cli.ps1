﻿<#
.SYNOPSIS
	install-signal-cli.ps1 [<version>]
.DESCRIPTION
	Installs signal-cli from github.com/AsamK/signal-cli. See the Web page for the correct version number.
.EXAMPLE
	PS> .\install-signal-cli.ps1 0.11.12
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Version = "")

try {
	if ($Version -eq "") { $Version = read-host "Enter version to install (see https://github.com/AsamK/signal-cli)" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	set-location /tmp

	& wget --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'wget' - make sure wget is installed and available" }

	& wget "https://github.com/AsamK/signal-cli/releases/download/v$Version/signal-cli-$($Version).tar.gz"
	if ($lastExitCode -ne "0") { throw "'wget' failed" }

	sudo tar xf "signal-cli-$Version.tar.gz" -C /opt
	if ($lastExitCode -ne "0") { throw "'sudo tar xf' failed" }

	sudo ln -sf "/opt/signal-cli-$Version/bin/signal-cli" /usr/local/bin/
	if ($lastExitCode -ne "0") { throw "'sudo ln -sf' failed" }

	rm "signal-cli-$Version.tar.gz"
	if ($lastExitCode -ne "0") { throw "'rm' failed" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed signal-cli $Version to /opt and /usr/local/bin in $Elapsed sec"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
