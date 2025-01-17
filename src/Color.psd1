@{
	# Script module or binary module file associated with this manifest.
	RootModule = 'Color.psm1'

	# Version number of this module.
	ModuleVersion = '2.1.0'

	# ID used to uniquely identify this module
	GUID = '2dcc5b24-f45b-47a4-b91d-6c4f1da05054'

	# Author of this module
	Author = 'Bruno Vieira'

	# Copyright statement for this module
	Copyright = '(c) 2021 Bruno Vieira. All rights reserved.'

	# Description of the functionality provided by this module
	Description = 'Fork of Davlind''s PSColor module, providing basic highlighting for default PowerShell Cmdlets.'

	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '7.2'

	# PrivateData = @{
	# 	PSData = @{
	# 		Prerelease = 'beta'
	# 	}
	# }

	# Functions to export from this module
	FunctionsToExport = @(
		"Out-Default"
	)

	# Cmdlets to export from this module
	CmdletsToExport = @()

	# Variables to export from this module
	VariablesToExport = '*'

	# Aliases to export from this module
	AliasesToExport = @()
}
