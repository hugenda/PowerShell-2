﻿<#
.SYNOPSIS
	remove-tag.ps1 [<TagName>] [<Mode>] [<RepoDir>]
.DESCRIPTION
	Removes a Git tag (locally, remote, or both)
.EXAMPLE
	PS> .\remove-tag.ps1 v1.7 locally
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

param([string]$TagName = "", [string]$Mode = "", [string]$RepoDir = "$PWD")

try {
	if ($TagName -eq "") { $TagName = read-host "Enter new tag name" }
	if ($Mode -eq "") { $Mode = read-host "Remove the tag locally, remote, or both" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	if (($Mode -eq "locally") -or ($Mode -eq "both")) {
		"Removing local tag..."
		& git -C "$RepoDir" tag --delete $TagName
		if ($lastExitCode -ne "0") { throw "'git tag --delete' failed" }
	}

	if (($Mode -eq "remote") -or ($Mode -eq "both")) {
		"Removing remote tag..."
		& git -C "$RepoDir" push origin :refs/tags/$TagName
		if ($lastExitCode -ne "0") { throw "'git push origin' failed" }
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ removed tag '$TagName' in $Elapsed sec"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
