﻿<#
.SYNOPSIS
	list-crypto-rates.ps1 
.DESCRIPTION
	Lists the current crypto exchange rates.
.EXAMPLE
	PS> .\list-crypto-rates.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

function ListCryptoRate { param([string]$Symbol, [string]$Name)
	$Rates = (invoke-webRequest -uri "https://min-api.cryptocompare.com/data/price?fsym=$Symbol&tsyms=USD,EUR,RUB,CNY" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	new-object PSObject -property @{ 'Cryptocurrency' = "1 $Name ($Symbol) ="; 'USD' = "$($Rates.USD)"; 'EUR' = "$($Rates.EUR)"; 'RUB' = "$($Rates.RUB)"; 'CNY' = "$($Rates.CNY)" }
}

function ListCryptoRates { 
	ListCryptoRate BTC "Bitcoin"
	ListCryptoRate ETH "Ethereum"
	ListCryptoRate ADA "Cardano"
	ListCryptoRate BNB "Binance Coin"
	ListCryptoRate USDT "Tether"
	ListCryptoRate XRP "XRP"
	ListCryptoRate DOGE "Dogecoin"
	ListCryptoRate USDC "USD Coin"
	ListCryptoRate DOT "Polkadot"
	ListCryptoRate SOL "Solana"
	ListCryptoRate UNI "Uniswap"
	ListCryptoRate BUSD "Binance USD"
	ListCryptoRate BCH "Bitcoin Cash"
	ListCryptoRate LTC "Litecoin"
	ListCryptoRate LINK "Chainlink"
	ListCryptoRate LUNA "Terra"
	ListCryptoRate ICP "Internet Computer"
	ListCryptoRate WBTC "Wrapped Bitcoin"
	ListCryptoRate MATIC "Polygon"
	ListCryptoRate XLM "Stellar"
}

try {
	""
	"Current Crypto Exchange Rates (source: cryptocompare.com)"
	"============================="

	ListCryptoRates | format-table -property @{e='Cryptocurrency';width=28},USD,EUR,RUB,CNY
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
