﻿<#
.SYNOPSIS
	set-wallpaper.ps1 [<image-file>] [<style>]
.DESCRIPTION
	Sets the given image file as desktop wallpaper (.JPG or .PNG supported)
        (<style> is either Fill, Fit (default), Stretch, Tile, Center, or Span)
.EXAMPLE
	PS> .\set-wallpaper.ps1 C:\ocean.jpg
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$ImageFile = "", [string]$Style = "Fit")

function SetWallPaper {
	param([string]$Image, [ValidateSet('Fill', 'Fit', 'Stretch', 'Tile', 'Center', 'Span')][string]$Style)
 
	$WallpaperStyle = switch($Style) {
	"Fill"    {"10"}
	"Fit"     {"6"}
	"Stretch" {"2"}
	"Tile"    {"0"}
	"Center"  {"0"}
	"Span"    {"22"}
	}
 
	if ($Style -eq "Tile") {
		New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
		New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 1 -Force
	} else {
		New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
		New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 0 -Force
	}
	Add-Type -TypeDefinition @" 
	using System; 
	using System.Runtime.InteropServices;
  
	public class Params
	{ 
	    [DllImport("User32.dll",CharSet=CharSet.Unicode)] 
	    public static extern int SystemParametersInfo (Int32 uAction, 
							   Int32 uParam, 
							   String lpvParam, 
							   Int32 fuWinIni);
	}
	"@ 
  
	$SPI_SETDESKWALLPAPER = 0x0014
	$UpdateIniFile = 0x01
	$SendChangeEvent = 0x02
  
	$fWinIni = $UpdateIniFile -bor $SendChangeEvent
  
	$ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
}
 
try {
	if ($ImageFile -eq "" ) { $ImageFile = read-host "Enter path to image file" }

	SetWallPaper -Image $ImageFile -Style $Style

	"✔️  Done."
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
