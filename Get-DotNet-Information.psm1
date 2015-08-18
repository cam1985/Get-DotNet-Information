function Get-DotNet-LatestInstalledVersion {
    Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | 
    Get-ItemProperty -name Version -EA 0 | 
    Where-Object { $_.PSChildName -match '^(?!S)\p{L}'} | 
    Sort-Object version -Descending | 
    Select-Object -ExpandProperty Version -First 1
}
function Get-DotNet-LatestInstalledRelease {
    Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | 
    Get-ItemProperty -name Release -EA 0 | 
    Where-Object { $_.PSChildName -match '^(?!S)\p{L}'} | 
    Sort-Object version -Descending | 
    Select-Object -ExpandProperty Release -First 1
}
function Get-DotNet-InstalledVersions {
    Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | 
    Get-ItemProperty -name Version -EA 0 | 
    Where-Object { $_.PSChildName -match '^(?!S)\p{L}'} | 
    Sort-Object version -Descending | 
    Select-Object -ExpandProperty Version -Unique
}
function Get-DotNet-InstalledReleases {
    Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | 
    Get-ItemProperty -name Release -EA 0 | 
    Where-Object { $_.PSChildName -match '^(?!S)\p{L}'} | 
    Sort-Object version -Descending | 
    Select-Object -ExpandProperty Release -Unique
}

 function Get-DotNet-Information {
    New-Object -TypeName psObject -Property @{
        ComputerName =  $env:COMPUTERNAME 
        PowerShellVersion = $PSVersionTable.PSVersion
        DotNetVersions  = (Get-DotNet-InstalledVersions) -join ", "
        DotNetReleases  = (Get-DotNet-InstalledReleases) -join ", "
        LatestDotNetVersion = Get-DotNet-LatestInstalledVersion
        LatestDotNetRelease = Get-DotNet-LatestInstalledRelease
    } | select ComputerName, PowerShellVersion, DotNetVersions, DotNetReleases, LatestDotNetVersion, LatestDotNetRelease
}
Export-ModuleMember -Function '*'