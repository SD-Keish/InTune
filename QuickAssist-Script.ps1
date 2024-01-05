if (Test-Path -Path "$env:TEMP\QuickAssist") { Remove-Item -Path "$env:TEMP\QuickAssist" -Recurse -Force }
New-Item -Path "$env:TEMP\QuickAssist" -ItemType Directory -Force

$splat = @{
    Uri     = 'https://bit.ly/DownloadQuickAssistBundle'
    OutFile = "$env:TEMP\QuickAssist\QuickAssist.AppxBundle"
}
Invoke-WebRequest @splat

$splat = @{
    Uri     = 'https://bit.ly/DownloadVCLibs'
    OutFile = "$env:TEMP\QuickAssist\VCLibs.Appx"
}
Invoke-WebRequest @splat

Add-AppPackage -Path "$env:TEMP\QuickAssist\VCLibs.Appx"
Add-AppxPackage -Path "$env:TEMP\QuickAssist\QuickAssist.AppxBundle"
$Package = Get-AppxPackage -Name 'MicrosoftCorporationII.QuickAssist'
Start-Process 'explorer.exe' -ArgumentList "shell:AppsFolder\$($Package.PackageFamilyName)!App"