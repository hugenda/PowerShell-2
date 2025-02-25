﻿<#
.SYNOPSIS
	list-latest-tag.ps1 [<repo-dir>] 
.DESCRIPTION
	Lists the latest tag on the current branch in a Git repository.
.EXAMPLE
	PS> .\list-latest-tag.ps1 C:\MyRepo
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$RepoDir = "$PWD")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

#	$RepoDirName = (get-item "$RepoDir").Name
#	"🢃 Fetching updates for 📂$RepoDirName ..."
#	& git -C "$RepoDir" fetch --tags
#	if ($lastExitCode -ne "0") { throw "'git fetch --tags' failed" }

	$LatestTagCommitID = (git -C "$RepoDir" rev-list --tags --max-count=1)
	$LatestTag = (git -C "$RepoDir" describe --tags $LatestTagCommitID)
	"🔖$LatestTag ($LatestTagCommitID)"

	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
