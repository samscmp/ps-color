# Functions for dealing with Strings

function Get-StringCharacters {
	param (
		[Parameter(Mandatory = $true, Position = 1)] [String] $string,
		[Parameter(Mandatory = $true, Position = 2)] [Int32] $length
	)

	if ($string.Length -gt $length) {
		return $string.Substring(0, ($length - 3)) + '...';
	}
	
	return $string;
}

function Get-SeparatorsForTitles {
	param (
		[Parameter(Mandatory = $true, Position = 1)] [String] $string
	)
	$result = $string -replace '\S', '-';
	return $result;
}

function Get-Spaces {
	param (
		[Parameter(Mandatory = $true, Position = 1)] [Int32] $quantity
	)
	$result = " " * $quantity;
	return $result;
}
