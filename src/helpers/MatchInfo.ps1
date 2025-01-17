function Write-Context {
	param (
		[Parameter(Mandatory = $True)] $display,
		[Parameter(Mandatory = $True)] $fileName,
		[Parameter(Mandatory = $True)] $start
	)

	$display | ForEach-Object {
		if ($fileName -ne 'InputStream') {
			Write-HostColor -Value "${fileName}" -ForegroundColor $Global:ColorSettings.MatchInfo.NoMatch.Path.Color -NoNewLine;
			Write-HostColor -Value ":" -ForegroundColor $Global:ColorSettings.MatchInfo.NoMatch.DefaultColor -NoNewLine;
		}

		Write-HostColor -ForegroundColor $Global:ColorSettings.MatchInfo.NoMatch.LineNumber.Color -NoNewline -Value (
			"{0, 4}" -f
			$start
		);
		
        Write-HostColor -Value ":" -ForegroundColor $Global:ColorSettings.MatchInfo.NoMatch.DefaultColor -NoNewLine;
        write-hostColor -Value "$_" -ForegroundColor $Global:ColorSettings.MatchInfo.NoMatch.Line.Color;
        
		$start++
	}
}

function Write-Match {
	param (
        [Parameter(Mandatory = $True, Position = 1)] $match
    )

	if ($match.RelativePath($pwd) -ne 'InputStream') {
		Write-HostColor -Value $match.RelativePath($pwd) -ForegroundColor $Global:ColorSettings.MatchInfo.Match.Path.Color -NoNewLine;
		Write-HostColor -Value ':' -ForegroundColor $Global:ColorSettings.MatchInfo.Match.DefaultColor -NoNewLine;
	}

	Write-HostColor -ForegroundColor $Global:ColorSettings.MatchInfo.Match.LineNumber.Color -NoNewline -Value (
		"{0, 4}" -f
		$match.LineNumber
	);

    Write-HostColor -Value ':' -ForegroundColor $Global:ColorSettings.MatchInfo.Match.DefaultColor -NoNewLine;

	#New-Object $_.Pattern, ([System.Text.RegularExpressions.RegexOptions]::$_.IgnoreCase);

	foreach ($item in [regex]::split($match.Line, "({0})" -f $_.Pattern, [Text.RegularExpressions.RegexOptions]'IgnoreCase')) {
		if($item){
			if ([regex]::IsMatch($item, $_.Pattern, [Text.RegularExpressions.RegexOptions]@('IgnorePatternWhitespace', 'IgnoreCase, IgnorePatternWhitespace')[$_.IgnoreCase])){
				Write-HostColor -Value $item -ForegroundColor $Global:ColorSettings.MatchInfo.Match.Line.Color -NoNewLine;
			}else{
				Write-HostColor -Value $item -ForegroundColor $Global:ColorSettings.MatchInfo.NoMatch.Line.Color -NoNewLine;
			}
		}
	}
	Write-Host

	
}

function Write-MatchInfo {
	param (
        [Parameter(Mandatory = $True, Position = 1)] $match
    )

	if ($match.Context) {
		Write-Context $match.Context.DisplayPreContext $match.RelativePath($pwd) ($match.LineNumber - $match.Context.DisplayPreContext.Count);
	}

	Write-Match $match;

	if ($match.Context) {
		Write-Context $match.Context.DisplayPostContext $match.RelativePath($pwd) ($match.LineNumber + 1);
	}
}
