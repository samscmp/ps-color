function Get-FileLength {
	param (
		[Parameter(Mandatory = $true)] $file
	)

	$length = $null;

	if ($file -isnot [System.IO.DirectoryInfo]) {
		$length = $file.length;
	}
	$f = "n1" #'F'
	if ($null -eq $length) {
		return "";
	} elseif ($length -ge 1PB) {
		return ($length / 1PB).ToString($f) + ' PB';
	} elseif ($length -ge 1TB) {
		return ($length / 1TB).ToString($f) + ' TB';
	} elseif ($length -ge 1GB) {
		return ($length / 1GB).ToString($f) + ' GB';
	} elseif ($length -ge 1MB) {
		return ($length / 1MB).ToString($f) + ' MB';
	} elseif ($length -ge 1KB) {
		return ($length / 1KB).ToString($f) + ' KB';
	}

	return $length.ToString() + ' B ';
}

function Get-FileName {
	param (
		[Parameter(Mandatory = $true)] $file
	)

	$name = $file.Name;

	if (
		($Global:ColorSettings.File.Types.SymbolicLink.ShowTarget -eq $true) `
		-and ($file.Attributes -band [IO.FileAttributes]::ReparsePoint)
	) {
		$target = $null;

		try {
			$target = Get-ShortenedPath (Get-Item -Path $file | Select-Object -ExpandProperty Target);
		} catch {}

		if ($null -ne $target) {
			$name = $name + ' -> ' + $target;
		}
	}

	return $name;
}

function Write-ColorizedFileLine {
	param (
		[String] $color,
		[Parameter(Mandatory = $true)] $file
	)

	Write-HostColor -ForegroundColor $color -Value (
		"{0,-7} {1,21} {2,10} {3}" -f 
		$file.Mode,
		([String]::Format("{0,10} {1,5}", $file.LastWriteTime.ToString("d"), $file.LastWriteTime.ToString("t"))),
		(Get-FileLength $file),
		(Get-FileName $file)
	);
}

function Write-FileHeader {
	param (
		[Parameter(Mandatory = $true, Position = 1)] [String] $directory
	)

	if ($Script:showHeader -eq $false) {
		return;
	}

	Write-Host;

	if ($Global:ColorSettings.File.Path.Visible -eq $true) {
		$currentDirectory = Get-ShortenedPath $directory;

		$pathTitleColor = $Global:ColorSettings.File.Path.TitleColor;
		$pathTextColor = $Global:ColorSettings.File.Path.TextColor;

		Write-HostColor -Value "    Directory: " -ForegroundColor $pathTitleColor -NoNewline;
		Write-HostColor -Value "$currentDirectory" -ForegroundColor $pathTextColor;
		Write-Host;
	}

	if ($Global:ColorSettings.File.Header.Visible -eq $true) {
		$headerTextColor = $Global:ColorSettings.File.Header.TextColor;
		$headerSeparatorsColor = $Global:ColorSettings.File.Header.SeparatorsColor;

		$modeTitle = 'Mode';
		if ($Script:platform -eq 'Unix') {
			$modeTitle = 'UnixMode';
		}
		$strings = $modeTitle, (Get-Spaces 12), 'LastWriteTime', (Get-Spaces 5), 'Length', (Get-Spaces 1), 'Name';
		$titleRow = -join $strings
		$separatorRow = Get-SeparatorsForTitles $titleRow;
		Write-HostColor -Value $titleRow -ForegroundColor $headerTextColor
		Write-HostColor -Value $separatorRow -ForegroundColor $headerSeparatorsColor
	}	

	$Script:showHeader = $false;
}

function Write-File {
	param (
		[Parameter(Mandatory = $true, Position = 1)] [hashtable] $regex_opj,
		[Parameter(Mandatory = $true, Position = 2)] [System.IO.FileSystemInfo] $file
	)



	if ($file -is [System.IO.DirectoryInfo]) {
		$currentDirectory = $file.Parent.FullName;
	} else {
		$currentDirectory = $file.DirectoryName;
	}

	Write-FileHeader $currentDirectory;
	$cant_find = @(1);
	if ($file -is [System.IO.DirectoryInfo]) {
		Write-ColorizedFileLine $Global:ColorSettings.File.Types.Directory.Color $file;
		$cant_find = @(0);
	}elseif ($file.Attributes -band [IO.FileAttributes]::ReparsePoint) {
		Write-ColorizedFileLine $Global:ColorSettings.File.Types.SymbolicLink.Color $file;
		$cant_find = @(0);
	}else {
		foreach ($currentItemName in $regex_opj.Keys) {
			if ($regex_opj[$currentItemName].IsMatch($file.Name)) {
				Write-ColorizedFileLine $Global:ColorSettings.File.Types[$currentItemName].Color $file;
				$cant_find = @(0);
				break;
			}
		}
	}
	
	if ($cant_find) {
			Write-ColorizedFileLine $Global:ColorSettings.File.DefaultColor $file;
		}
}
