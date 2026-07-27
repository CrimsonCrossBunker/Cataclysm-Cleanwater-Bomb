param(
    [Parameter(Mandatory)][string]$SolutionPath,
    [Parameter(Mandatory)][string]$Configuration,
    [string]$Platform = 'x64',
    [switch]$EnableTracy
)

$pf86 = [System.Environment]::GetEnvironmentVariable('ProgramFiles(x86)')
$vswhere = Join-Path $pf86 'Microsoft Visual Studio\Installer\vswhere.exe'
$msbuild = & $vswhere -latest -requires Microsoft.Component.MSBuild -find 'MSBuild\**\Bin\MSBuild.exe' |
    Select-Object -Last 1

if (-not $msbuild) {
    Write-Error 'MSBuild not found. Is Visual Studio installed?'
    exit 1
}

$msbuildArgs = @(
    $SolutionPath
    "/p:Configuration=$Configuration"
    "/p:Platform=$Platform"
    '/m'
)
if ($EnableTracy) {
    $msbuildArgs += '/p:CDDA_TRACY=1'
}

& $msbuild @msbuildArgs
exit $LASTEXITCODE
