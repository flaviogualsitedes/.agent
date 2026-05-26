#!/bin/bash
# Script de Inicializacao Rapida do Automatize Agent (.agent)
# Compativel com Linux / macOS (Bash)

clear

echo -e "\e[36m=========================================================\e[0m"
echo -e "\e[36m         AUTOMATIZE AGENT - SETUP LOCAL                  \e[0m"
echo -e "\e[36m=========================================================\e[0m"
echo ""

# 1. Definicao do Diretorio de Execucao e Destino
CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_PATH="$(dirname "$CURRENT_PATH")"
PARENT_DIR_NAME="$(basename "$PARENT_PATH")"

if [ "$(basename "$CURRENT_PATH")" != ".agent" ]; then
    # Ajusta caso o bash chame a partir de pasta superior
    if [ -d "$CURRENT_PATH/.agent" ]; then
        AGENT_PATH="$CURRENT_PATH/.agent"
        PROJ_PATH="$CURRENT_PATH"
    else
        AGENT_PATH="$CURRENT_PATH"
        PROJ_PATH="$PARENT_PATH"
    fi
else
    AGENT_PATH="$CURRENT_PATH"
    PROJ_PATH="$PARENT_PATH"
fi

PROJ_DIR_NAME="$(basename "$PROJ_PATH")"

# 2. Entrevista Interativa de Configuracao
echo -e "\e[33m-> Vamos configurar o seu assistente local. Responda as perguntas abaixo:\e[0m"
echo ""

# Pergunta: Nome do Projeto
read -p "1. Nome do Projeto (Padrao: $PROJ_DIR_NAME): " PROJ_NAME
if [ -z "$PROJ_NAME" ]; then
    PROJ_NAME="$PROJ_DIR_NAME"
fi

# Pergunta: Caminho do Projeto
read -p "2. Caminho Fisico do Projeto (Padrao: $PROJ_PATH): " CUSTOM_PROJ_PATH
if [ -z "$CUSTOM_PROJ_PATH" ]; then
    CUSTOM_PROJ_PATH="$PROJ_PATH"
fi

# Pergunta: IDE Alvo
echo ""
echo -e "\e[36m3. Qual IDE ou Harness de IA voce utilizara no chat deste projeto?\e[0m"
echo "   [1] Cursor (.cursorrules)"
echo "   [2] Windsurf (.windsurfrules)"
echo "   [3] VS Code / VS Code Insiders (.vscode)"
echo "   [4] Claude Code CLI (CLAUDE.md)"
echo "   [5] Copilot / Custom Instructions (.github)"
echo "   [6] Outra / Sem arquivo de ponte"
read -p "Escolha a opcao (1-6): " IDE_CHOICE

IDE_TARGET="cursor"
if [ "$IDE_CHOICE" == "2" ]; then
    IDE_TARGET="windsurf"
elif [ "$IDE_CHOICE" == "3" ]; then
    IDE_TARGET="vscode"
elif [ "$IDE_CHOICE" == "4" ]; then
    IDE_TARGET="claude-code"
elif [ "$IDE_CHOICE" == "5" ]; then
    IDE_TARGET="copilot"
elif [ "$IDE_CHOICE" == "6" ]; then
    IDE_TARGET="generic"
fi

# Pergunta: Idioma de Preferencia
echo ""
echo -e "\e[36m4. Qual idioma de preferencia para os relatorios da IA (PLAN.md, status, etc.)?\e[0m"
echo "   [1] Portugues do Brasil (pt-BR)"
echo "   [2] Ingles (en-US)"
echo "   [3] Espanhol (es-ES)"
read -p "Escolha a opcao (1-3): " LANG_CHOICE

LANGUAGE="pt-BR"
if [ "$LANG_CHOICE" == "2" ]; then
    LANGUAGE="en-US"
elif [ "$LANG_CHOICE" == "3" ]; then
    LANGUAGE="es-ES"
fi

# Pergunta: Framework de Estilos Padrao
echo ""
echo -e "\e[36m5. Qual padrao de estilizacao a IA deve seguir no Frontend?\e[0m"
echo "   [1] Vanilla CSS (Sem frameworks - Altamente Recomendado)"
echo "   [2] Tailwind CSS"
echo "   [3] Shadcn UI + Tailwind"
echo "   [4] styled-components"
echo "   [5] Bootstrap"
echo "   [6] Material UI (MUI)"
read -p "Escolha a opcao (1-6): " STYLE_CHOICE

STYLE_FRAMEWORK="vanilla-css"
if [ "$STYLE_CHOICE" == "2" ]; then
    STYLE_FRAMEWORK="tailwind-css"
elif [ "$STYLE_CHOICE" == "3" ]; then
    STYLE_FRAMEWORK="shadcn-ui"
elif [ "$STYLE_CHOICE" == "4" ]; then
    STYLE_FRAMEWORK="styled-components"
elif [ "$STYLE_CHOICE" == "5" ]; then
    STYLE_FRAMEWORK="bootstrap"
elif [ "$STYLE_CHOICE" == "6" ]; then
    STYLE_FRAMEWORK="material-ui"
fi

# Pergunta: Canal de Memoria (Obsidian vs Local)
echo ""
echo -e "\e[36m6. Deseja habilitar a persistencia de memorias no Obsidian?\e[0m"
echo "   [1] Nao, manter memoria apenas local no Git (Local)"
echo "   [2] Sim, salvar notas no cofre do Obsidian (Obsidian)"
read -p "Escolha a opcao (1-2): " MEM_CHOICE

USE_OBSIDIAN=false
VAULT_PATH=""
USE_OBSIDIAN_API=false
VAULT_ID=""
OBSIDIAN_TOKEN=""

if [ "$MEM_CHOICE" == "2" ]; then
    USE_OBSIDIAN=true
    echo ""
    echo -e "\e[33m⚠️  ATENCAO: Para integracao automatica com Obsidian, instale e habilite\e[0m"
    echo -e "\e[33m   o plugin de comunidade 'Local REST API & MCP Server' no seu Obsidian.\e[0m"
    echo ""
    read -p "Digite o caminho absoluto do seu cofre do Obsidian (ex: /Users/usuario/Obsidian/MeuVault): " VAULT_PATH
    
    read -p "Deseja configurar a integracao de API em tempo real agora? (s/n): " API_CHOICE
    if [ "$API_CHOICE" == "s" ] || [ "$API_CHOICE" == "sim" ]; then
        USE_OBSIDIAN_API=true
        read -p "Digite o Vault ID gerado pelo plugin REST API: " VAULT_ID
        read -p "Digite o Bearer Token gerado pelo plugin: " OBSIDIAN_TOKEN
    fi
fi

# 3. Criando as Pastas Fisicas Necessarias
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
    full_folder_path="$AGENT_PATH/$folder"
    if [ ! -d "$full_folder_path" ]; then
        mkdir -p "$full_folder_path"
        touch "$full_folder_path/.gitkeep"
    fi
done

# 4. Atualizando/Gravando config.json
CONFIG_PATH="$AGENT_PATH/config.json"
echo -e "\e[90m⚙️  Gravando configurações em config.json...\e[0m"

cat <<EOF > "$CONFIG_PATH"
{
    "agent_version": "1.5.0",
    "project_name": "$PROJ_NAME",
    "project_path": "$CUSTOM_PROJ_PATH",
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
        "enabled": $USE_OBSIDIAN_API,
        "vault_id": "$VAULT_ID",
        "url": "https://127.0.0.1:27124",
        "token": "$OBSIDIAN_TOKEN"
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
    BRIDGE_FILE="$CUSTOM_PROJ_PATH/.cursorrules"
    BRIDGE_CONTENT="# ATENCAO AGENTE DE IA
Este projeto utiliza o framework Automatize Agent para orquestracao.
Antes de responder ou escrever qualquer codigo:
1. LEIA OBRIGATORIAMENTE o arquivo de regras e comportamento em: .agent/main.md
2. Siga as instrucoes do orquestrador principal e dos subagentes correspondentes."
elif [ "$IDE_TARGET" == "windsurf" ]; then
    BRIDGE_FILE="$CUSTOM_PROJ_PATH/.windsurfrules"
    BRIDGE_CONTENT="# ATENCAO AGENTE DE IA (WINDSURF)
Este projeto utiliza o framework Automatize Agent para orquestracao.
Antes de responder ou escrever qualquer codigo:
1. LEIA OBRIGATORIAMENTE o arquivo de regras e comportamento em: .agent/main.md
2. Siga as instrucoes do orquestrador principal e dos subagentes correspondentes."
elif [ "$IDE_TARGET" == "vscode" ]; then
    BRIDGE_FILE="$CUSTOM_PROJ_PATH/.github/copilot-instructions.md"
    BRIDGE_CONTENT="# COPILOT DEVELOPER INSTRUCTIONS
Este projeto utiliza o framework Automatize Agent para orquestracao.
Antes de responder ou escrever qualquer codigo:
1. LEIA OBRIGATORIAMENTE o arquivo de regras em: .agent/main.md
2. Siga as instrucoes do orquestrador principal e dos subagentes correspondentes."
    mkdir -p "$CUSTOM_PROJ_PATH/.github"
elif [ "$IDE_TARGET" == "claude-code" ]; then
    BRIDGE_FILE="$CUSTOM_PROJ_PATH/CLAUDE.md"
    BRIDGE_CONTENT="# CLAUDE DEVELOPER ENVIRONMENT
Este projeto utiliza o framework Automatize Agent para orquestracao.
Antes de responder ou executar qualquer tarefa:
1. LEIA OBRIGATORIAMENTE o arquivo de regras e comportamento em: .agent/main.md
2. Coordene as acoes seguindo as especificacoes da squad de subagentes."
elif [ "$IDE_TARGET" == "copilot" ]; then
    BRIDGE_FILE="$CUSTOM_PROJ_PATH/.copilot-instructions"
    BRIDGE_CONTENT="# COPILOT ENVIRONMENT INSTRUCTIONS
Este projeto utiliza o framework Automatize Agent para orquestracao.
Antes de responder ou escrever codigo:
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
    echo "Memoria: Obsidian ($VAULT_PATH)"
    if [ "$USE_OBSIDIAN_API" = true ]; then
        echo "REST API: Habilitada (Vault: $VAULT_ID)"
    fi
else
    echo "Memoria: Local (.agent/project/)"
fi
echo -e "\e[32m=========================================================\e[0m"
echo -e "\e[33mAbra o chat do seu editor e digite /automatize-agent para iniciar.\e[0m"
echo ""
EOF
