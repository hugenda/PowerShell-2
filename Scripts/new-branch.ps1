﻿<#
.SYNOPSIS
	new-branch.ps1 [<BranchName>] [<RepoDir>]
.DESCRIPTION
	Creates and switches to a new branch in a Git repository.
.EXAMPLE
	PS> .\new-branch.ps1 moonshot
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$BranchName = "", [string]$RepoDir = "$PWD")

try {
	if ($BranchName -eq "") { $BranchName = read-host "Enter new branch name" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$RepoDirName = (get-item "$RepoDir").Name
	"🢃 Fetching updates for Git repository 📂$RepoDirName ..."

	& git fetch --all --recurse-submodules --jobs=4
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	& git checkout -b "$BranchName"
	if ($lastExitCode -ne "0") { throw "'git checkout -b $BranchName' failed" }

	& git push origin "$BranchName"
	if ($lastExitCode -ne "0") { throw "'git push origin $BranchName' failed" }

	& git submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ created new branch '$BranchName' in Git repository 📂$RepoDirName in $Elapsed sec"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
