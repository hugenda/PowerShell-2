﻿<#
.SYNOPSIS
	enable-god-mode.ps1 
.DESCRIPTION
	Enables the god mode (adds a new icon to the desktop).
.EXAMPLE
	PS> .\enable-god-mode.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$GodModeSplat = @{
		Path = "$HOME\Desktop"
		Name = "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
		ItemType = 'Directory'
	}
	$null = new-item @GodModeSplat

	"✔️ enabled god mode - see the new desktop icon"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
