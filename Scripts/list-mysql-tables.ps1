﻿<#
.SYNOPSIS
	list-mysql-tables.ps1 
.DESCRIPTION
	Lists the MySQL tables.
.EXAMPLE
	PS> .\list-mysql-tables.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

# This script lists all of the tables in a MySQL database and exports the list as a CSV
# Install-Module InvokeQuery
# Run the above command if you do not have this module
param(
[Parameter(Mandatory=$true)]$server,
[Parameter(Mandatory=$true)]$database,
[Parameter(Mandatory=$true)]$dbuser,
[Parameter(Mandatory=$true)]$dbpass
)
$csvfilepath = "$PSScriptRoot\mysql_tables.csv"
$result = Invoke-MySqlQuery  -ConnectionString "server=$server; database=$database; user=$dbuser; password=$dbpass; pooling = false; convert zero datetime=True" -Sql "SHOW TABLES" -CommandTimeout 10000
$result | Export-Csv $csvfilepath -NoTypeInformation
