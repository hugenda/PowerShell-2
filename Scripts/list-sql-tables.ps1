﻿<#
.SYNOPSIS
	list-sql-tables.ps1
.DESCRIPTION
	Lists all tables in a SQL server database and exports the list as CSV.
	Install-Module InvokeQuery
	Run the above command if you do not have this module.
.EXAMPLE
	PS> .\list-sql-tables.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param(
[Parameter(Mandatory=$true)]$server,
[Parameter(Mandatory=$true)]$database,
[Parameter(Mandatory=$true)]$username,
[Parameter(Mandatory=$true)]$password
)
$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
$csvfilepath = "$PSScriptRoot\sqlserver_tables.csv"
$result = Invoke-SqlServerQuery -Credential $creds -ConnectionTimeout 10000 -Database $database -Server $server -Sql "SELECT TABLE_NAME FROM $database.INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'" -CommandTimeout 10000
$result | Export-Csv $csvfilepath -NoTypeInformation
