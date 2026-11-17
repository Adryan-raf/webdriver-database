[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateSet("install", "reset-db", "start", "all", "help")]
    [string]$Mode = "all",

    [switch]$SkipInstall,
    [switch]$SkipDb,
    [switch]$NoEnv,

    [string]$DbUser = "",
    [string]$DbPassword = "",
    [string]$DbName = "web_driver",
    [string]$MysqlPath = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $repoRoot

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logFile = Join-Path $repoRoot "setup_local.log"

function Write-Log {
    param([string]$Message)
    $line = "[$timestamp] $Message"
    Write-Host $Message
    Add-Content -Path $logFile -Value $line
}

function Show-Help {
    @"
Uso:
  setup_local.bat install      Cria .env, instala dependencias e prepara o banco
  setup_local.bat reset-db     Recria o banco web_driver
  setup_local.bat start        Inicia a aplicacao Flask
  setup_local.bat all          Executa install + reset-db + start
  setup_local.bat help         Mostra este texto

Opcoes extras:
  -SkipInstall
  -SkipDb
  -NoEnv
  -DbUser "usuario"
  -DbPassword "senha"
  -DbName "web_driver"
  -MysqlPath "C:\caminho\para\mysql.exe"
"@ | Write-Host
}

function Ensure-EnvFile {
    $envPath = Join-Path $repoRoot ".env"
    if (-not (Test-Path $envPath)) {
        if (Test-Path (Join-Path $repoRoot ".env.example")) {
            Copy-Item (Join-Path $repoRoot ".env.example") $envPath
            Write-Log "Arquivo .env criado a partir de .env.example."
        }
        else {
            @"
MYSQL_HOST=127.0.0.1
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=root
MYSQL_DATABASE=web_driver
"@ | Set-Content -Path $envPath
            Write-Log "Arquivo .env criado com valores padrao."
        }
    }

    if ($DbUser -ne "") {
        $content = Get-Content $envPath
        $newContent = @()
        foreach ($line in $content) {
            if ($line -match "^MYSQL_USER=") {
                $newContent += "MYSQL_USER=$DbUser"
            }
            elseif ($line -match "^MYSQL_PASSWORD=") {
                $newContent += "MYSQL_PASSWORD=$DbPassword"
            }
            elseif ($line -match "^MYSQL_DATABASE=") {
                $newContent += "MYSQL_DATABASE=$DbName"
            }
            else {
                $newContent += $line
            }
        }
        Set-Content -Path $envPath -Value $newContent
        Write-Log "Arquivo .env atualizado com configuracoes do setup."
    }
}

function Ensure-Venv {
    $venvDir = Join-Path $repoRoot ".venv"
    if (-not (Test-Path $venvDir)) {
        Write-Log "Criando ambiente virtual .venv"
        & python -m venv $venvDir
        if ($LASTEXITCODE -ne 0) {
            throw "Falha ao criar ambiente virtual."
        }
    }

    $venvPython = Join-Path $venvDir "Scripts\python.exe"
    if (-not (Test-Path $venvPython)) {
        throw "Ambiente virtual incompleto: $venvPython"
    }

    Write-Log "Instalando dependencias do Python"
    & $venvPython -m pip install --upgrade pip
    & $venvPython -m pip install -r (Join-Path $repoRoot "requirements.txt")
    if ($LASTEXITCODE -ne 0) {
        throw "Erro ao instalar as dependencias do projeto."
    }
}

function Ensure-Database {
    $mysqlExe = $MysqlPath
    if (-not (Test-Path $mysqlExe)) {
        throw "mysql.exe nao encontrado em: $mysqlExe. Instale o MySQL Server e ajuste -MysqlPath."
    }

    $scriptDb = Join-Path $repoRoot "database\executar_tudo.ps1"
    if (-not (Test-Path $scriptDb)) {
        throw "Script de banco nao encontrado: $scriptDb"
    }

    Write-Log "Executando restauracao do banco com script de setup do MySQL"
    & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptDb
    if ($LASTEXITCODE -ne 0) {
        throw "Erro ao executar scripts SQL do banco."
    }
}

function Start-App {
    $venvPython = Join-Path $repoRoot ".venv\Scripts\python.exe"
    if (-not (Test-Path $venvPython)) {
        throw "Ambiente virtual nao encontrado em $venvPython. Rode install primeiro."
    }

    $logApp = Join-Path $repoRoot "app_local.log"
    $proc = Start-Process -FilePath $venvPython -ArgumentList "web\app.py" -WorkingDirectory $repoRoot -RedirectStandardOutput $logApp -RedirectStandardError $logApp -PassThru
    Write-Log "Aplicacao iniciada em processo PID $($proc.Id). Log: $logApp"
}

if ($Mode -eq "help") {
    Show-Help
    exit 0
}

if (-not $NoEnv) {
    Ensure-EnvFile
}

if (-not $SkipInstall) {
    Ensure-Venv
}

if (-not $SkipDb) {
    Ensure-Database
}

if ($Mode -eq "install" -or $Mode -eq "all") {
    Write-Log "Setup concluido."
}

if ($Mode -eq "start" -or $Mode -eq "all") {
    Start-App
}

if ($Mode -eq "reset-db") {
    Write-Log "Banco resetado com sucesso."
}

Write-Log "Fim do setup local."
