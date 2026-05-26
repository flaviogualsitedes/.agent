# Script de Inicializacao Rapida do Automatize Agent (.agent)
# Compativel com Windows (PowerShell 5.1+)

Clear-Host

Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host "         AUTOMATIZE AGENT - SETUP LOCAL                  " -ForegroundColor Cyan
Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Definicao do Diretorio de Execucao e Destino de forma flexivel
$ScriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$ScriptDirName = Split-Path -Path $ScriptPath -Leaf

if ($ScriptDirName -eq ".agent") {
    $AgentPath = $ScriptPath
    $ProjPath = Split-Path -Path $ScriptPath -Parent
} else {
    # Caso seja executado de dentro da pasta clonada mas por caminhos relativos
    $AgentPath = Join-Path -Path $PSScriptRoot -ChildPath ".agent"
    if (Test-Path -Path $AgentPath) {
        $ProjPath = $PSScriptRoot
    } else {
        $AgentPath = $PSScriptRoot
        $ProjPath = Split-Path -Path $PSScriptRoot -Parent
    }
}

$ProjDirName = Split-Path -Path $ProjPath -Leaf

# 2. Entrevista Interativa de Configuracao
Write-Host "-> Vamos configurar o seu assistente local. Responda as perguntas abaixo:" -ForegroundColor Yellow
Write-Host ""

# Pergunta: Nome do Projeto
$ProjName = Read-Host "1. Nome do Projeto (Padrao: $ProjDirName)"
if ([string]::IsNullOrEmpty($ProjName)) { $ProjName = $ProjDirName }

# Pergunta: Caminho do Projeto
$CustomProjPath = Read-Host "2. Caminho Fisico do Projeto (Padrao: $ProjPath)"
if ([string]::IsNullOrEmpty($CustomProjPath)) { $CustomProjPath = $ProjPath }

# Pergunta: IDE Alvo
Write-Host ""
Write-Host "3. Qual IDE ou Harness de IA voce utilizara no chat deste projeto?" -ForegroundColor Cyan
Write-Host "   [1] Cursor / Windsurf (.cursorrules)"
Write-Host "   [2] Claude Code CLI (CLAUDE.md)"
Write-Host "   [3] Copilot / Custom Instructions (.github)"
Write-Host "   [4] Outra / Sem arquivo de ponte"
$IdeChoice = Read-Host "Escolha a opcao (1-4)"
$IdeTarget = "cursor"
if ($IdeChoice -eq "2") { $IdeTarget = "claude-code" }
elseif ($IdeChoice -eq "3") { $IdeTarget = "copilot" }
elseif ($IdeChoice -eq "4") { $IdeTarget = "generic" }

# Pergunta: Idioma de Preferencia
Write-Host ""
Write-Host "4. Qual idioma de preferencia para os relatorios da IA (PLAN.md, status, etc.)?" -ForegroundColor Cyan
Write-Host "   [1] Portugues do Brasil (pt-BR)"
Write-Host "   [2] Ingles (en-US)"
Write-Host "   [3] Espanhol (es-ES)"
$LangChoice = Read-Host "Escolha a opcao (1-3)"
$Language = "pt-BR"
if ($LangChoice -eq "2") { $Language = "en-US" }
elseif ($LangChoice -eq "3") { $Language = "es-ES" }

# Pergunta: Framework de Estilos Padrao
Write-Host ""
Write-Host "5. Qual padrao de estilizacao a IA deve seguir no Frontend?" -ForegroundColor Cyan
Write-Host "   [1] Vanilla CSS (Sem frameworks - Altamente Recomendado)"
Write-Host "   [2] Tailwind CSS"
Write-Host "   [3] styled-components"
$StyleChoice = Read-Host "Escolha a opcao (1-3)"
$StyleFramework = "vanilla-css"
if ($StyleChoice -eq "2") { $StyleFramework = "tailwind-css" }
elseif ($StyleChoice -eq "3") { $StyleFramework = "styled-components" }

# Pergunta: Canal de Memoria (Obsidian vs Local)
Write-Host ""
Write-Host "6. Deseja habilitar a persistencia de memorias no Obsidian?" -ForegroundColor Cyan
Write-Host "   [1] Nao, manter memoria apenas local no Git (Local)"
Write-Host "   [2] Sim, salvar notas no cofre do Obsidian (Obsidian)"
$MemChoice = Read-Host "Escolha a opcao (1-2)"
$UseObsidian = $false
$VaultPath = ""
if ($MemChoice -eq "2") {
    $UseObsidian = $true
    $VaultPath = Read-Host "Digite o caminho absoluto do seu cofre do Obsidian (ex: E:\Obsidian\MeuVault)"
}

# 3. Criando as Pastas Fisicas Necessarias
Write-Host ""
Write-Host "-> Criando estrutura de pastas de trabalho locais..." -ForegroundColor Gray
$Folders = @(
    "project\rules",
    "project\memory",
    "project\modules",
    "skills\development",
    "skills\devops",
    "skills\custom"
)

foreach ($folder in $Folders) {
    $FullFolderPath = Join-Path -Path $AgentPath -ChildPath $folder
    if (-not (Test-Path -Path $FullFolderPath)) {
        New-Item -ItemType Directory -Path $FullFolderPath -Force | Out-Null
        New-Item -ItemType File -Path (Join-Path -Path $FullFolderPath -ChildPath ".gitkeep") -Force | Out-Null
    }
}

# 4. Atualizando/Gravando config.json
$ConfigPath = Join-Path -Path $AgentPath -ChildPath "config.json"
$Config = @{}

if (Test-Path -Path $ConfigPath) {
    Write-Host "-> Mesclando configuracoes no config.json existente..." -ForegroundColor Gray
    try {
        $Config = Get-Content -Raw -Path $ConfigPath | ConvertFrom-Json
    } catch {}
} else {
    Write-Host "-> Criando novo arquivo config.json..." -ForegroundColor Gray
}

# Grava preferencias coletadas
$Config.project_name = $ProjName
$Config.project_path = $CustomProjPath
$Config.preferences = @{
    language = $Language
    styling_framework = $StyleFramework
    ide_target = $IdeTarget
}
$Config.rag_memory = @{
    enabled = $UseObsidian
    obsidian_vault_path = $VaultPath
    project_subfolder = if ($UseObsidian) { "01_Projects\$ProjName" } else { "" }
}

$Config | ConvertTo-Json -Depth 5 | Out-File -FilePath $ConfigPath -Encoding utf8 -Force

# 5. Criando a Ponte na Raiz do Projeto (Com Seguranca de Backup)
$BridgeFile = ""
$BridgeContent = ""

if ($IdeTarget -eq "cursor") {
    $BridgeFile = Join-Path -Path $CustomProjPath -ChildPath ".cursorrules"
    $BridgeContent = @"
# ATENCAO AGENTE DE IA
Este projeto utiliza o framework Automatize Agent para orquestracao.
Antes de responder ou escrever qualquer codigo:
1. LEIA OBRIGATORIAMENTE o arquivo de regras e comportamento em: .agent/main.md
2. Siga as instrucoes do orquestrador principal e dos subagentes correspondentes.
"@
}
elseif ($IdeTarget -eq "claude-code") {
    $BridgeFile = Join-Path -Path $CustomProjPath -ChildPath "CLAUDE.md"
    $BridgeContent = @"
# CLAUDE DEVELOPER ENVIRONMENT
Este projeto utiliza o framework Automatize Agent para orquestracao.
Antes de responder ou executar qualquer tarefa:
1. LEIA OBRIGATORIAMENTE o arquivo de regras e comportamento em: .agent/main.md
2. Coordene as acoes seguindo as especificacoes da squad de subagentes.
"@
}
elseif ($IdeTarget -eq "copilot") {
    $BridgeFile = Join-Path -Path $CustomProjPath -ChildPath ".copilot-instructions"
    $BridgeContent = @"
# COPILOT ENVIRONMENT INSTRUCTIONS
Este projeto utiliza o framework Automatize Agent para orquestracao.
Antes de responder ou escrever codigo:
1. LEIA OBRIGATORIAMENTE o arquivo de regras em: .agent/main.md
2. Respeite as regras globais e o fluxo de subagentes.
"@
}

if (-not [string]::IsNullOrEmpty($BridgeFile)) {
    if (Test-Path -Path $BridgeFile) {
        $Timestamp = (Get-Date).ToString("yyyyMMdd-HHmmss")
        $BackupFile = "$BridgeFile.bak-$Timestamp"
        Write-Host "-> Arquivo de regras da IDE existente detectado em: $BridgeFile" -ForegroundColor Yellow
        Write-Host "-> Gerando backup de seguranca em: $BackupFile" -ForegroundColor Yellow
        Rename-Item -Path $BridgeFile -NewName (Split-Path -Path $BackupFile -Leaf) -Force
    }

    Write-Host "-> Gerando arquivo de ponte com a IDE na raiz..." -ForegroundColor Gray
    $BridgeContent | Out-File -FilePath $BridgeFile -Encoding utf8 -Force
}

Write-Host ""
Write-Host "=========================================================" -ForegroundColor Green
Write-Host "     AUTOMATIZE AGENT CONFIGURADO COM SUCESSO!           " -ForegroundColor Green
Write-Host "=========================================================" -ForegroundColor Green
Write-Host "Projeto: $ProjName" -ForegroundColor White
Write-Host "IDE Alvo: $IdeTarget" -ForegroundColor White
Write-Host "Idioma: $Language" -ForegroundColor White
Write-Host "Estilos: $StyleFramework" -ForegroundColor White
if ($UseObsidian) {
    Write-Host "Memoria: Obsidian ($VaultPath)" -ForegroundColor White
} else {
    Write-Host "Memoria: Local (.agent/project/)" -ForegroundColor White
}
Write-Host "=========================================================" -ForegroundColor Green
Write-Host "Abra o chat do seu editor e digite /automatize-agent para iniciar." -ForegroundColor Yellow
Write-Host ""
