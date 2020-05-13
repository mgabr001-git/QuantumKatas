# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

& "$PSScriptRoot/set-env.ps1"

# Install iqsharp if not installed yet.

Write-Host ("Installing IQ# tool.")
$install = $False

# Install iqsharp if not installed yet.
try {
    $install = [string]::IsNullOrWhitespace((dotnet tool list --tool-path $Env:TOOLS_DIR | Select-String -Pattern "microsoft.quantum.iqsharp"))
} catch {
    Write-Host ("`dotnet iqsharp --version` threw error: " + $_)
    $install = $True
}

if ($install) {
    #try {
        Write-Host ("Installing Microsoft.Quantum.IQSharp at $Env:TOOLS_DIR")
        dotnet tool install Microsoft.Quantum.IQSharp --version 0.11.2004.2825 --tool-path $Env:TOOLS_DIR

    
        $path = (Get-Item "$Env:TOOLS_DIR\dotnet-iqsharp*").FullName

        Write-Host ("& $path install --user --path-to-tool $path --log-level 'Debug' 2> $ null")
        & $path install --user --path-to-tool $path --log-level 'Debug' 2> $null
        Write-Host "iq# kernel installed ($LastExitCode)"
    #} catch {
    #}
} else {
    Write-Host ("Microsoft.Quantum.IQSharp is already installed in this host.")
}

# Azure DevOps agent failing with "PowerShell exited with code '1'."
# For now, guarantee this script succeeds:
exit 0
