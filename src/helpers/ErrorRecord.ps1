# Add-Type -AssemblyName System.ServiceProcess

# function Write-ErrorRecord {
# 	param (
# 		[Parameter(Mandatory = $true, Position = 1)][System.Management.Automation.ErrorRecord] $record
# 	)

# 	Write-HostColor -Value ("{0,-8}" -f $_.Status) -ForegroundColor $color -NoNewline;
# 	Write-HostColor -Value (
# 		" {0,-28} {1,-59}" -f
# 		(Get-StringCharacters $_.Name 28),
# 		(Get-StringCharacters $_.DisplayName 58)
# 	) -ForegroundColor $defaultColor;
# }

# function Write-ServiceHeader {

# 	if (($Global:ColorSettings.Service.Header.Visible -eq $false) -or ($Script:showHeader -eq $false)) {
# 		return;
# 	}

# 	Write-Host;

# 	$textColor = $Global:ColorSettings.Service.Header.TextColor;
# 	$separatorsColor = $Global:ColorSettings.Service.Header.SeparatorsColor;

# 	Write-HostColor -Value "Status   Name                         DisplayName" -ForegroundColor $textColor;
# 	Write-HostColor -Value "------   ----                         -----------" -ForegroundColor $separatorsColor;

# 	$Script:showHeader = $false;
# }
function MyWrite($labelColor, $valueColor, $label, $value){
    if($value){
	Write-HostColor -Value "$($label): " -ForegroundColor $labelColor #-BackgroundColor "black"
	Write-HostColor -Value ("  $($value)") -ForegroundColor $valueColor #-BackgroundColor "black"
	#Write-HostColor -Value ("  $($value)".trim()) -ForegroundColor $valueColor #-BackgroundColor "black"
    }
}
function Info($label, $value){
    MyWrite "purple" "white" $label $value
}
function Warn($label, $value){
    MyWrite "yellow" "white" $label $value
}
function Error($label, $value){
    MyWrite "red" "red" $label $value
}
function Success($label, $value){
    MyWrite "green" "white" $label $value
}
function Write-ErrorRecord {
	param (
		[Parameter(Mandatory = $true, Position = 1)] $err
	)
    Write-Host $global:psConfig.FormatErrors
    if ($global:psConfig.FormatErrors) {
        $io = $err.InvocationInfo
        Write-HostColor -Value "Custom Report for Error Record" -ForegroundColor "Red" 
        Success "CategoryInfo" "$($err.CategoryInfo)" 
        Success "FullyQualifiedErrorId: $($err.FullyQualifiedErrorId)"
        Success "PipelineIterationInfo" "$($err.PipelineIterationInfo)"
        Error "ScriptStackTrace" "$($err.ScriptStackTrace)"
        Error "TargetObject $($err.TargetObject)"
        Error "ErrorDetails: $($err.ErrorDetails)"
        Info "--"
        Error "Exception" "$($err.Exception.message)"
        Info "--"
        Success "MyCommand" "$($io.MyCommand)"
        Success "BoundParameters" "$($io.BoundParameters)"
        Success "UnboundArguments" "$($io.UnboundArguments)"
        Success "ScriptLineNumber" "$($io.ScriptLineNumber)"
        Success "OffsetInLine" "$($io.OffsetInLine)"
        Success "HistoryId" "$($io.HistoryId)"
        Success "ScriptName" "$($io.ScriptName)"
        Success "Line" "$($io.Line)"
        Success "PositionMessage" "$($io.PositionMessage)"
        Success "PSScriptRoot" "$($io.PSScriptRoot)"
        Success "PSCommandPath" "$($io.PSCommandPath)"
        Success "InvocationName" "$($io.InvocationName)"
        Success "PipelineLength" "$($io.PipelineLength)"
        Success "PipelinePosition" "$($io.PipelinePosition)"
        Success "ExpectingInput" "$($io.ExpectingInput)"
        Success "CommandOrigin" "$($io.CommandOrigin)"
        Success "DisplayScriptPosition" "$($io.DisplayScriptPosition)"
        Write-HostColor -Value "End of Custom Report for Error Record" -ForegroundColor "red"
    } else {
        $_ | out-host
    }
}