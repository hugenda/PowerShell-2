﻿<#
.SYNOPSIS
	sync-repo.ps1 [<repo-dir>]
.DESCRIPTION
	Synchronizes a Git repository by push & pull (including submodules).
.EXAMPLE
	PS> .\sync-repo.ps1 C:\MyRepo
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$RepoDir = "$PWD")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"
	$RepoDirName = (Get-Item "$RepoDir").Name

	"⏳ Synchronizing Git repository 📂$RepoDirName ..."

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git push
	if ($lastExitCode -ne "0") { throw "'git push' failed" }

	& git pull --all --recurse-submodules --jobs=4
	if ($lastExitCode -ne "0") { throw "'git pull' failed" }

	"✔️ synchronized Git repository 📂$RepoDirName"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
