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
echo "   [1] Antigravity IDE (Recomendado)"
echo "   [2] Cursor (.cursorrules)"
echo "   [3] Windsurf (.windsurfrules)"
echo "   [4] VS Code / VS Code Insiders (.vscode)"
echo "   [5] Claude Code CLI (CLAUDE.md)"
echo "   [6] Copilot / Custom Instructions (.github)"
echo "   [7] Outra / Sem arquivo de ponte"
read -p "Escolha a opcao (1-7): " IDE_CHOICE

IDE_TARGET="antigravity"
if [ "$IDE_CHOICE" == "2" ]; then
    IDE_TARGET="cursor"
elif [ "$IDE_CHOICE" == "3" ]; then
    IDE_TARGET="windsurf"
elif [ "$IDE_CHOICE" == "4" ]; then
    IDE_TARGET="vscode"
elif [ "$IDE_CHOICE" == "5" ]; then
    IDE_TARGET="claude-code"
elif [ "$IDE_CHOICE" == "6" ]; then
    IDE_TARGET="copilot"
elif [ "$IDE_CHOICE" == "7" ]; then
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

STYLE_FRAMEWORK="vanilla-css"

# Pergunta: Canal de Memoria (Obsidian vs Local)
echo ""
echo -e "\e[36m5. Deseja habilitar a persistencia de memorias no Obsidian?\e[0m"
echo "   [1] Nao, manter memoria apenas local no Git (Local)"
echo "   [2] Sim, configurar integracao com Obsidian (Obsidian)"
read -p "Escolha a opcao (1-2): " MEM_CHOICE

USE_OBSIDIAN=false
VAULT_PATH=""
USE_OBSIDIAN_API=false
VAULT_ID=""
OBSIDIAN_TOKEN=""

if [ "$MEM_CHOICE" == "2" ]; then
    USE_OBSIDIAN=true
    echo ""
    echo -e "\e[33m[!] IMPORTANTE: Se for utilizar a API em tempo real, certifique-se de ter o plugin\e[0m"
    echo -e "\e[33m    'Local REST API & MCP Server' instalado e ativo no seu Obsidian.\e[0m"
    echo ""
    read -p "Digite o Vault ID ou o caminho absoluto do seu cofre do Obsidian: " INPUT_VAULT
    
    if [[ "$INPUT_VAULT" == *"/"* || "$INPUT_VAULT" == *"\\"* || "$INPUT_VAULT" == *":"* ]]; then
        # É um caminho físico
        VAULT_PATH="$INPUT_VAULT"
        echo -e "\e[32m[OK] Detectado caminho fisico do cofre: $VAULT_PATH\e[0m"
    else
        # É um Vault ID
        VAULT_ID="$INPUT_VAULT"
        if [ ! -z "$VAULT_ID" ]; then
            read -p "Digite o Token (Bearer Token / API Key) do plugin REST API: " OBSIDIAN_TOKEN
            if [ ! -z "$OBSIDIAN_TOKEN" ]; then
                USE_OBSIDIAN_API=true
                echo -e "\e[32m[OK] Detectada configuracao de API (Vault: $VAULT_ID)\e[0m"
            fi
        fi
    fi
fi

# 3. Criando as Pastas Fisicas Necessarias no Projeto Local
echo ""
echo -e "\e[90m[Pastas] Criando estrutura de pastas de trabalho locais...\e[0m"
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

# 4. Criando Estrutura de Pastas e Arquivos no Obsidian se configurado
if [ "$USE_OBSIDIAN" = true ]; then
    API_SUCCESS=false
    
    if [ "$USE_OBSIDIAN_API" = true ]; then
        echo -e "\e[90m[!] Tentando criar e sincronizar pastas via Obsidian REST API...\e[0m"
        
        LOCAL_RULES_FILE="$AGENT_PATH/rules/global.md"
        RULES_CONTENT=""
        if [ -f "$LOCAL_RULES_FILE" ]; then
            RULES_CONTENT=$(cat "$LOCAL_RULES_FILE")
        fi
        
        HTTP_CODE_1=$(curl -s -k -o /dev/null -w "%{http_code}" -X PUT \
            -H "Authorization: Bearer $OBSIDIAN_TOKEN" \
            -H "Content-Type: text/markdown" \
            --data-binary "$RULES_CONTENT" \
            "https://127.0.0.1:27124/vault/00_Global/global_rules.md")
            
        HTTP_CODE_2=$(curl -s -k -o /dev/null -w "%{http_code}" -X PUT \
            -H "Authorization: Bearer $OBSIDIAN_TOKEN" \
            -H "Content-Type: text/plain" \
            --data-binary "" \
            "https://127.0.0.1:27124/vault/01_Projects/$PROJ_NAME/memory/.gitkeep")
            
        HTTP_CODE_3=$(curl -s -k -o /dev/null -w "%{http_code}" -X PUT \
            -H "Authorization: Bearer $OBSIDIAN_TOKEN" \
            -H "Content-Type: text/plain" \
            --data-binary "" \
            "https://127.0.0.1:27124/vault/01_Projects/$PROJ_NAME/modules/.gitkeep")
            
        HTTP_CODE_4=$(curl -s -k -o /dev/null -w "%{http_code}" -X PUT \
            -H "Authorization: Bearer $OBSIDIAN_TOKEN" \
            -H "Content-Type: text/plain" \
            --data-binary "" \
            "https://127.0.0.1:27124/vault/01_Projects/$PROJ_NAME/tasks/.gitkeep")
            
        if [ "$HTTP_CODE_1" = "200" ] || [ "$HTTP_CODE_1" = "204" ] || [ "$HTTP_CODE_1" = "201" ]; then
            echo -e "\e[32m[OK] Integracao via Obsidian REST API concluida com sucesso! Pastas criadas no cofre.\e[0m"
            API_SUCCESS=true
        else
            echo -e "\e[33m[!]  Chamadas da API falharam com status HTTP: $HTTP_CODE_1\e[0m"
        fi
    fi
    
    if [ "$API_SUCCESS" = false ] && [ ! -z "$VAULT_PATH" ]; then
        if [ -d "$VAULT_PATH" ]; then
            echo -e "\e[90m[Pastas] Criando pastas físicas diretamente no Obsidian...\e[0m"
            mkdir -p "$VAULT_PATH/00_Global"
            mkdir -p "$VAULT_PATH/01_Projects/$PROJ_NAME/memory"
            mkdir -p "$VAULT_PATH/01_Projects/$PROJ_NAME/modules"
            mkdir -p "$VAULT_PATH/01_Projects/$PROJ_NAME/tasks"
            
            if [ -f "$AGENT_PATH/rules/global.md" ]; then
                cp "$AGENT_PATH/rules/global.md" "$VAULT_PATH/00_Global/global_rules.md"
            fi
            echo -e "\e[32m[OK] Pastas do Obsidian geradas no disco e global_rules.md sincronizado!\e[0m"
        else
            echo -e "\e[33m[!]  Caminho do Obsidian não encontrado no disco e conexao API falhou. Pulando criacao.\e[0m"
        fi
    fi
fi

# 5. Atualizando/Gravando config.json
CONFIG_PATH="$AGENT_PATH/config.json"
echo -e "\e[90m[Config]  Gravando configurações em config.json...\e[0m"

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
        "ide_target": "$IDE_TARGET",
        "active_squad": "developer",
        "active_scope": "software_development"
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

# 6. Criando a Ponte na Raiz do Projeto (Com Segurança de Backup)
BRIDGE_FILE=""
BRIDGE_CONTENT=""

if [ "$IDE_TARGET" == "antigravity" ]; then
    BRIDGE_FILE="$CUSTOM_PROJ_PATH/.agentbridge.md"
    BRIDGE_CONTENT="# ATENCAO AGENTE DE IA (ANTIGRAVITY)
Este projeto utiliza o framework Automatize Agent para orquestracao.
Antes de responder ou escrever qualquer codigo:
1. LEIA OBRIGATORIAMENTE o arquivo de regras e comportamento em: .agent/main.md
2. Siga as instrucoes do orquestrador principal e dos subagentes correspondentes."
elif [ "$IDE_TARGET" == "cursor" ]; then
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
        TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
        BACKUP_FILE="$BRIDGE_FILE.bak-$TIMESTAMP"
        echo -e "\e[33m[!]  Arquivo de regras da IDE existente detectado em: $BRIDGE_FILE\e[0m"
        echo -e "\e[33m📦 Gerando backup de segurança em: $BACKUP_FILE\e[0m"
        mv "$BRIDGE_FILE" "$BACKUP_FILE"
    fi

    echo -e "\e[90m[!] Gerando arquivo de ponte com a IDE na raiz...\e[0m"
    echo "$BRIDGE_CONTENT" > "$BRIDGE_FILE"
fi

echo ""
echo -e "\e[32m=========================================================\e[0m"
echo -e "\e[32m [OK] AUTOMATIZE AGENT CONFIGURADO COM SUCESSO! [OK]         \e[0m"
echo -e "\e[32m=========================================================\e[0m"
echo "Projeto: $PROJ_NAME"
echo "IDE Alvo: $IDE_TARGET"
echo "Idioma: $LANGUAGE"
echo "Estilos: $STYLE_FRAMEWORK"
if [ "$USE_OBSIDIAN" = true ]; then
    if [ -z "$VAULT_PATH" ]; then
        echo "Memoria: Obsidian (API)"
    else
        echo "Memoria: Obsidian ($VAULT_PATH)"
    fi
    if [ "$USE_OBSIDIAN_API" = true ]; then
        echo "REST API: Habilitada (Vault: $VAULT_ID)"
    fi
else
    echo "Memoria: Local (.agent/project/)"
fi
echo -e "\e[32m=========================================================\e[0m"
echo -e "\e[33mAbra o chat do seu editor e digite /automatize-agent para iniciar.\e[0m"
echo ""
