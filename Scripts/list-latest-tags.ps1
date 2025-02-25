﻿<#
.SYNOPSIS
	list-latest-tags.ps1 [<parent-dir>]
.DESCRIPTION
	Lists the latests tags in all Git repositories under the current/given directory.
.EXAMPLE
	PS> .\list-latest-tags.ps1 C:\MyRepos
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$ParentDir = "$PWD")

try {
	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Folders = (get-childItem "$ParentDir" -attributes Directory)
	$FolderCount = $Folders.Count
	$ParentDirName = (get-item "$ParentDir").Name
	"Found $FolderCount subfolders in 📂$ParentDirName..."

	foreach ($Folder in $Folders) {
		$FolderName = (get-item "$Folder").Name

#		& git -C "$Folder" fetch --tags
#		if ($lastExitCode -ne "0") { throw "'git fetch --tags' failed" }

		$LatestTagCommitID = (git -C "$Folder" rev-list --tags --max-count=1)
		$LatestTag = (git -C "$Folder" describe --tags $LatestTagCommitID)
		"* $FolderName $LatestTag ($LatestTagCommitID)"
	}
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
