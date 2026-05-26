#!/bin/bash
# Script de Inicialização Rápida e Inteligente do Automatize Agent (.agent)
# Compatível com Linux / macOS (Bash)

clear

echo -e "\e[36m=========================================================\e[0m"
echo -e "\e[36m         🤖 AUTOMATIZE AGENT - SETUP LOCAL 🤖            \e[0m"
echo -e "\e[36m=========================================================\e[0m"
echo ""

# 1. Definição do Diretório de Execução e Destino
CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_PATH="$(dirname "$CURRENT_PATH")"
PARENT_DIR_NAME="$(basename "$PARENT_PATH")"

# Verifica se o script está rodando dentro de uma pasta chamada .agent
if [ "$(basename "$CURRENT_PATH")" != ".agent" ]; then
    echo -e "\e[31m❌ Erro: Este script deve ser executado de dentro da pasta .agent.\e[0m"
    echo -e "\e[31mPor favor, clone o repositório como a pasta .agent na raiz do seu projeto.\e[0m"
    exit 1
fi

# 2. Entrevista Interativa de Configuração
echo -e "\e[33m💬 Vamos configurar o seu assistente local. Responda as perguntas abaixo:\e[0m"
echo ""

# Pergunta: Nome do Projeto
read -p "1. Nome do Projeto (Padrão: $PARENT_DIR_NAME): " PROJ_NAME
if [ -z "$PROJ_NAME" ]; then
    PROJ_NAME="$PARENT_DIR_NAME"
fi

# Pergunta: Caminho do Projeto
read -p "2. Caminho Físico do Projeto (Padrão: $PARENT_PATH): " PROJ_PATH
if [ -z "$PROJ_PATH" ]; then
    PROJ_PATH="$PARENT_PATH"
fi

# Pergunta: IDE Alvo
echo ""
echo -e "\e[36m3. Qual IDE ou Harness de IA você utilizará no chat deste projeto?\e[0m"
echo "   [1] Cursor / Windsurf (.cursorrules)"
echo "   [2] Claude Code CLI (CLAUDE.md)"
echo "   [3] Copilot / Custom Instructions (.github)"
echo "   [4] Outra / Sem arquivo de ponte"
read -p "Escolha a opção (1-4): " IDE_CHOICE

IDE_TARGET="cursor"
if [ "$IDE_CHOICE" == "2" ]; then
    IDE_TARGET="claude-code"
elif [ "$IDE_CHOICE" == "3" ]; then
    IDE_TARGET="copilot"
elif [ "$IDE_CHOICE" == "4" ]; then
    IDE_TARGET="generic"
fi

# Pergunta: Idioma de Preferência
echo ""
echo -e "\e[36m4. Qual idioma de preferência para os relatórios da IA (PLAN.md, status, etc.)?\e[0m"
echo "   [1] Português do Brasil (pt-BR)"
echo "   [2] Inglês (en-US)"
echo "   [3] Espanhol (es-ES)"
read -p "Escolha a opção (1-3): " LANG_CHOICE

LANGUAGE="pt-BR"
if [ "$LANG_CHOICE" == "2" ]; then
    LANGUAGE="en-US"
elif [ "$LANG_CHOICE" == "3" ]; then
    LANGUAGE="es-ES"
fi

# Pergunta: Framework de Estilos Padrão
echo ""
echo -e "\e[36m5. Qual padrão de estilização a IA deve seguir no Frontend?\e[0m"
echo "   [1] Vanilla CSS (Sem frameworks - Altamente Recomendado)"
echo "   [2] Tailwind CSS"
echo "   [3] styled-components"
read -p "Escolha a opção (1-3): " STYLE_CHOICE

STYLE_FRAMEWORK="vanilla-css"
if [ "$STYLE_CHOICE" == "2" ]; then
    STYLE_FRAMEWORK="tailwind-css"
elif [ "$STYLE_CHOICE" == "3" ]; then
    STYLE_FRAMEWORK="styled-components"
fi

# Pergunta: Canal de Memória (Obsidian vs Local)
echo ""
echo -e "\e[36m6. Deseja habilitar a persistência de memórias no Obsidian?\e[0m"
echo "   [1] Não, manter memória apenas local no Git (Local)"
echo "   [2] Sim, salvar notas no cofre do Obsidian (Obsidian)"
read -p "Escolha a opção (1-2): " MEM_CHOICE

USE_OBSIDIAN=false
VAULT_PATH=""
if [ "$MEM_CHOICE" == "2" ]; then
    USE_OBSIDIAN=true
    read -p "Digite o caminho absoluto do seu cofre do Obsidian (ex: /Users/usuario/Obsidian/MeuVault): " VAULT_PATH
fi

# 3. Criando as Pastas Físicas Necessárias
echo ""
echo -e "\e[90m📂 Criando estrutura de pastas de trabalho locais...\e[0m"
folders=(
    "project/rules"
    "project/memory"
    "project/modules"
    "skills/development"
    "skills/devops"
    "skills/custom"
)

for folder in "${folders[@]}"; do
    full_folder_path="$CURRENT_PATH/$folder"
    if [ ! -d "$full_folder_path" ]; then
        mkdir -p "$full_folder_path"
        # Cria arquivo .gitkeep para persistência no Git
        touch "$full_folder_path/.gitkeep"
    fi
done

# 4. Atualizando/Gravando config.json
CONFIG_PATH="$CURRENT_PATH/config.json"
echo -e "\e[90m⚙️  Gravando configurações em config.json...\e[0m"

# Gera o JSON usando templates no Bash
cat <<EOF > "$CONFIG_PATH"
{
    "agent_version": "1.5.0",
    "project_name": "$PROJ_NAME",
    "project_path": "$PROJ_PATH",
    "current_phase": "BOOTSTRAP",
    "max_iterations_per_task": 3,
    "preferences": {
        "language": "$LANGUAGE",
        "styling_framework": "$STYLE_FRAMEWORK",
        "ide_target": "$IDE_TARGET"
    },
    "rag_memory": {
        "enabled": $USE_OBSIDIAN,
        "obsidian_vault_path": "$VAULT_PATH",
        "project_subfolder": "$([ "$USE_OBSIDIAN" = true ] && echo "01_Projects/$PROJ_NAME" || echo "")"
    },
    "obsidian_api": {
        "enabled": false,
        "vault_id": "",
        "url": "https://127.0.0.1:27124",
        "token": ""
    },
    "project_lifecycle": {
        "1_bootstrap": {
            "status": "pending",
            "description": "Mapear o projeto, carregar regras locais e conectar à memória (Obsidian ou Local)."
        },
        "2_spec": {
            "status": "pending",
            "description": "Mapear os módulos ativos e desenhar o plano arquitetural (PLAN.md)."
        },
        "3_execution": {
            "status": "pending",
            "description": "Escrever código e executar as esteiras planejadas."
        },
        "4_review": {
            "status": "pending",
            "description": "Auditoria de qualidade, testes e salvamento de novos aprendizados na memória."
        }
    },
    "esteira": {
        "active_module": "",
        "current_task": "",
        "status": "idle"
    },
    "detected_environment": {
        "language": "unknown",
        "framework": "unknown",
        "package_manager": "unknown"
    }
}
EOF

# 5. Criando a Ponte na Raiz do Projeto (Com Segurança de Backup)
BRIDGE_FILE=""
BRIDGE_CONTENT=""

if [ "$IDE_TARGET" == "cursor" ]; then
    BRIDGE_FILE="$PROJ_PATH/.cursorrules"
    BRIDGE_CONTENT="# ATENÇÃO AGENTE DE IA
Este projeto utiliza o framework Automatize Agent para orquestração.
Antes de responder ou escrever qualquer código:
1. LEIA OBRIGATORIAMENTE o arquivo de regras e comportamento em: .agent/main.md
2. Siga as instruções do orquestrador principal e dos subagentes correspondentes."
elif [ "$IDE_TARGET" == "claude-code" ]; then
    BRIDGE_FILE="$PROJ_PATH/CLAUDE.md"
    BRIDGE_CONTENT="# CLAUDE DEVELOPER ENVIRONMENT
Este projeto utiliza o framework Automatize Agent para orquestração.
Antes de responder ou executar qualquer tarefa:
1. LEIA OBRIGATORIAMENTE o arquivo de regras e comportamento em: .agent/main.md
2. Coordene as ações seguindo as especificações da squad de subagentes."
elif [ "$IDE_TARGET" == "copilot" ]; then
    BRIDGE_FILE="$PROJ_PATH/.copilot-instructions"
    BRIDGE_CONTENT="# COPILOT ENVIRONMENT INSTRUCTIONS
Este projeto utiliza o framework Automatize Agent para orquestração.
Antes de responder ou escrever código:
1. LEIA OBRIGATORIAMENTE o arquivo de regras em: .agent/main.md
2. Respeite as regras globais e o fluxo de subagentes."
fi

if [ ! -z "$BRIDGE_FILE" ]; then
    if [ -f "$BRIDGE_FILE" ]; then
        TIMESTAMP=$(date +"%Y%md-%H%M%S")
        BACKUP_FILE="$BRIDGE_FILE.bak-$TIMESTAMP"
        echo -e "\e[33m⚠️  Arquivo de regras da IDE existente detectado em: $BRIDGE_FILE\e[0m"
        echo -e "\e[33m📦 Gerando backup de segurança em: $BACKUP_FILE\e[0m"
        mv "$BRIDGE_FILE" "$BACKUP_FILE"
    fi

    echo -e "\e[90m⚡ Gerando arquivo de ponte com a IDE na raiz...\e[0m"
    echo "$BRIDGE_CONTENT" > "$BRIDGE_FILE"
fi

echo ""
echo -e "\e[32m=========================================================\e[0m"
echo -e "\e[32m 🎉 AUTOMATIZE AGENT CONFIGURADO COM SUCESSO! 🎉         \e[0m"
echo -e "\e[32m=========================================================\e[0m"
echo "Projeto: $PROJ_NAME"
echo "IDE Alvo: $IDE_TARGET"
echo "Idioma: $LANGUAGE"
echo "Estilos: $STYLE_FRAMEWORK"
if [ "$USE_OBSIDIAN" = true ]; then
    echo "Memória: Obsidian ($VAULT_PATH)"
else
    echo "Memória: Local (.agent/project/)"
fi
echo -e "\e[32m=========================================================\e[0m"
echo -e "\e[33mAbra o chat do seu editor e digite /automatize-agent para iniciar.\e[0m"
echo ""
