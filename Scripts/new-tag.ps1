﻿<#
.SYNOPSIS
	new-tag.ps1 [<TagName>] [<RepoDir>]
.DESCRIPTION
	Creates a new tag in a Git repository.
.EXAMPLE
	PS> .\create-tag.ps1 v1.7
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

param([string]$TagName = "", [string]$RepoDir = "$PWD")

try {
	if ($TagName -eq "") { $TagName = read-host "Enter new tag name" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Result = (git status)
	if ($lastExitCode -ne "0") { throw "'git status' failed in $RepoDir" }
	if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Repository is NOT clean: $Result" }

	& "$PSScriptRoot/fetch-repo.ps1"
	if ($lastExitCode -ne "0") { throw "Script 'fetch-repo.ps1' failed" }

	& git tag "$TagName"
	if ($lastExitCode -ne "0") { throw "Error: 'git tag $TagName' failed!" }

	& git push origin "$TagName"
	if ($lastExitCode -ne "0") { throw "Error: 'git push origin $TagName' failed!" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ created new tag '$TagName' in $Elapsed sec"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
