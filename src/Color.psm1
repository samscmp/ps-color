. "$PSScriptRoot\config\Default.ps1"

. "$PSScriptRoot\util\Path.ps1"
. "$PSScriptRoot\util\String.ps1"
. "$PSScriptRoot\util\Color.ps1"
. "$PSScriptRoot\helpers\File.ps1"
. "$PSScriptRoot\helpers\ErrorRecord.ps1"
. "$PSScriptRoot\helpers\MatchInfo.ps1"
. "$PSScriptRoot\helpers\Service.ps1"

$Script:showHeader = $true;

$Script:platform = $PSVersionTable.Platform
function Out-Default {
	[CmdletBinding(HelpUri = 'http://go.microsoft.com/fwlink/?LinkID=113362', RemotingCapability = 'None')]
	param(
		[switch] ${Transcript},
		[Parameter(Position = 0, ValueFromPipeline = $true)][PSObject] ${InputObject}
	)

	begin {
		try {
			$regexOptions = ([System.Text.RegularExpressions.RegexOptions]::IgnoreCase);

			$regex_opj = @{};
			foreach ($currentItemName in $Global:ColorSettings.File.Types.Keys) {
				if (($currentItemName -eq 'Directory') -or ($currentItemName -eq 'SymbolicLink')){
					continue;
				}
				$regex_opj[$currentItemName] = New-Object System.Text.RegularExpressions.Regex($Global:ColorSettings.File.Types[$currentItemName].RegEx, $regexOptions);
			}
			#Write-Host $regex_opj

			$outBuffer = $null

			if ($PSBoundParameters.TryGetValue('OutBuffer', [ref] $outBuffer)) {
				$PSBoundParameters['OutBuffer'] = 1;
			}

			$wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Out-Default', [System.Management.Automation.CommandTypes]::Cmdlet);
			$scriptCmd = {& $wrappedCmd @PSBoundParameters }

			$steppablePipeline = $scriptCmd.GetSteppablePipeline();
			$steppablePipeline.Begin($PSCmdlet);

			$wrappedCmdlet = $ExecutionContext.InvokeCommand.GetCmdlet("Out-Default")
			$sb = { & $wrappedCmdlet @PSBoundParameters }
			$__sp = $sb.GetSteppablePipeline()
			$__sp.Begin($pscmdlet)
			$__all=@()
		} catch {
			throw
		}
	}
	
	process {
		$do_process = $true
		try {
			if (($_ -is [System.IO.DirectoryInfo]) -or ($_ -is [System.IO.FileInfo])) {
				Write-File $regex_opj $_;
			} elseif ($_ -is [System.ServiceProcess.ServiceController]) {
				Write-Service $_;
			} elseif ($_ -is [System.Management.Automation.ErrorRecord]) {
				if ($_.Exception -is [System.Management.Automation.CommandNotFoundException])
				{
					$__command = $_.Exception.CommandName.TrimStart(".\")
					if ($do_process -and (Test-Path -Path $__command -PathType container))
					{
						cdlog $__command
						$do_process = $false
					}else{
						# $_ | out-host
						Write-ErrorRecord $_
					}
					if($do_process -and $global:Capabilities.HasGit){
						if (Get-GitStatus){
							$branches=myGitBranches
							if(($branches -match '^' + $__command + '$') -or ($branches -match '^/' + $__command + '$')){
								git checkout $__command
								$do_process = $false
							}
							if ($do_process){
							}
						}
					}
				} else {
					Write-ErrorRecord $_
				}
			} elseif ($_ -is [Microsoft.Powershell.Commands.MatchInfo]) {
				Write-MatchInfo $_;
			} else {
				$steppablePipeline.Process($_);
			}
		} catch {
			throw
		}
	}

	end {
		try {
			$Script:showHeader = $true;
			$steppablePipeline.End();
		} catch {
			throw
		}
	}
}

Export-ModuleMember -Function Out-Default
Export-ModuleMember -Function MyWrite
