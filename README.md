# 🤖 Automatize Agent

O **Automatize Agent** é uma estrutura ultra-organizada para agentes de IA locais (copilotos de codificação). Ele foi projetado especialmente para desenvolvedores que necessitam de consistência arquitetural, memória persistente a longo prazo e guias modulares passo a passo para execução de tarefas complexas.

Este projeto resolve os problemas de **perda de contexto** e **código incompleto**, oferecendo uma divisão inteligente de responsabilidades (Orquestrador + Subagentes) e integração nativa com o **Obsidian** ou armazenamento local Git.

---

## 🛠️ Guia Passo a Passo: Do Zero ao Início do Desenvolvimento

Como este framework foi feito para se adaptar e aprender com o contexto específico de cada repositório, você deve realizar esta configuração básica para **cada projeto individual** onde deseja a ajuda do agente.

### 📋 Passo 1: Clonar o Framework no seu Projeto
Abra o terminal na raiz do projeto onde deseja usar o agente e execute o comando abaixo. Ele criará a pasta `.agent` isolando a inteligência para este escopo:

```bash
git clone https://github.com/flaviogualsitedes/.agent.git .agent
```

> [!IMPORTANT]
> **Isolamento de Projetos:** Sempre faça esse clone para cada novo projeto. Isso garante que cada projeto tenha suas próprias regras locais, módulos ativos e logs de histórico, evitando misturar dados de diferentes códigos.

---

### ⚙️ Passo 2: Executar o Setup e Painel de Controle
Com a pasta criada, abra o chat do seu editor ou assistente de IA preferido neste projeto e envie o comando abaixo para iniciar o menu de opções interativo:

```text
/automatize-agent
```

**Opções disponíveis no painel de controle `/automatize-agent`:**
1. **Configurar Sistema (`setup`):** Configura a memória local ou Obsidian.
2. **Redefinir Configurações (`reset`):** Limpa o arquivo de configurações retornando ao padrão.
3. **Sincronizar Histórico (`sync`):** Migra notas de memória, regras locais e módulos do Git para o Obsidian.
4. **Atualizar Inteligência (`update`):** Atualiza os subagentes e regras de Clean Code preservando seus dados de projeto.
5. **Desinstalar Framework (`remove`):** Apaga com segurança a pasta `.agent/` de forma recursiva.

---

### 🔌 Integração Avançada: Obsidian Local REST API & MCP
Caso escolha utilizar o Obsidian, você pode habilitar a comunicação em tempo real via API / protocolo MCP para que o agente leia e salve informações de forma integrada:

1. No Obsidian, vá em **Configurações > Plugins de Comunidade** e instale o plugin: **"Local REST API & MCP Server"**.
2. Ative o plugin.
3. Nas configurações do plugin, copie o **Bearer Token** e o **Vault ID** gerados.
4. No arquivo `.agent/config.json`, configure a integração:
   ```json
   "obsidian_api": {
       "enabled": true,
       "vault_id": "SEU_VAULT_ID_AQUI",
       "url": "https://127.0.0.1:27124",
       "token": "SEU_BEARER_TOKEN_AQUI"
   }
   ```
5. Com isso ativo, o agente criará as notas de histórico e módulos dentro da subpasta dedicada ao projeto sob:
   `Obsidian Vault/01_Projects/[nome-do-seu-projeto]/`
6. Isso garante que múltiplos projetos tenham pastas isoladas no seu cofre do Obsidian, permitindo a você gerenciar o RAG de cada sistema separadamente.

---

### 🧩 Passo 3: Definir e Executar uma Trilha de Módulos (Uso Diário)
Para colocar o agente para codificar uma funcionalidade complexa seguindo um planejamento rígido:

1. **Crie um Módulo:** Vá até a pasta `.agent/project/modules/`, duplique o arquivo `template_module.md` e renomeie-o com o nome da sua funcionalidade (ex: `login.md` ou `integration_n8n.md`).
2. **Escreva as Especificações (PRD):** Abra o arquivo criado e preencha os requisitos de negócio e o checklist técnico das tarefas a serem entregues.
3. **Defina como Ativo:** Abra o arquivo `.agent/config.json` e aponte no objeto `esteira` qual módulo e qual tarefa você quer iniciar:
   ```json
   "esteira": {
       "active_module": "login.md",
       "current_task": "Criar a rota POST /api/login para autenticação de usuários",
       "status": "idle"
   }
   ```
4. **Acione o Agente:** No chat do seu assistente de IA, envie qualquer comando de início (ex: *"Iniciar"* ou *"Rodar tarefa"*). O agente principal carregará as diretrizes globais, as especificações que você escreveu em `login.md` e a memória de erros passados do projeto, acionando os subagentes (`Architect`, `Coder`, `Reviewer`) para planejar, escrever o código 100% completo e validá-lo de forma automática.

---

## 🔮 Visão de Futuro: A CLI `@automatize/agent`

Estamos trabalhando na construção de uma interface de linha de comando (CLI) distribuída globalmente. A experiência será simplificada para:

*   **Instalação global única:** `npm install -g @automatize/agent`
*   **Inicializar projeto local:** `automatize-agent init` (criará apenas as configurações locais e pastas de contexto, consumindo a inteligência dos subagentes globalmente).

---

## 📝 Licença
Distribuído sob a licença MIT. Veja o repositório principal no GitHub para mais informações.
