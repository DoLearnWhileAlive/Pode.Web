function Get-PodeWebTemplatePath
{
    $path = Split-Path -Parent -Path ((Get-Module -Name 'Pode.Web').Path)
    return (Join-Path $path 'Templates')
}

function Write-PodeWebViewResponse
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Path,

        [Parameter()]
        [hashtable]
        $Data = @{}
    )

    Write-PodeViewResponse -Path "$($Path).pode" -Data $Data -Folder 'pode.web.views' -FlashMessages
}

function Use-PodeWebPartialView
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Path,

        [Parameter()]
        [hashtable]
        $Data = @{}
    )

    Use-PodePartialView -Path "$($Path).pode" -Data $Data -Folder 'pode.web.views'
}

function Set-PodeWebState
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Name,

        [Parameter()]
        [object]
        $Value
    )

    Set-PodeState -Name "pode.web.$($Name)" -Value $Value -Scope 'pode.web' | Out-Null
}

function Get-PodeWebState
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Name
    )

    return (Get-PodeState -Name "pode.web.$($Name)")
}

function Get-PodeWebRandomName
{
    param(
        [Parameter()]
        [int]
        $Length = 5
    )

    $value = (65..90) | Get-Random -Count $Length | ForEach-Object { [char]$_ }
    return [String]::Concat($value)
}

function Test-PodeWebPage
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Name
    )

    return (Get-PodeWebState -Name 'pages' | Where-Object { $_.Name -ieq $Name } | Measure-Object).Count -ne 0
}