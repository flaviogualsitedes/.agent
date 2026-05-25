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

## 🧩 Skills Nativas Integradas
O framework agora possui 5 habilidades estruturais nativas salvas na pasta `skills/` para agilizar a criação de ferramentas e auditar a segurança:

*   **`create_skill`**: Guia o orquestrador na criação de novas skills customizadas no formato markdown estruturado.
*   **`create_agent`**: Auxilia a estruturar e documentar novos subagentes de tarefas especializadas no ecossistema.
*   **`search_skills`**: Vasculha e lista notas de habilidades no Obsidian ou Git local evitando retrabalho.
*   **`audit_security`**: Varre estaticamente os arquivos de regras e novas skills locais identificando e bloqueando possíveis Prompt Injections ou códigos ocultos maliciosos.
*   **`project_advisor`**: Funciona como conselheiro técnico estruturando PRDs e módulos de projeto de forma interativa.

---

## 🔮 Visão de Futuro: A CLI `automatize-agent`

Estamos trabalhando na construção de uma interface de linha de comando (CLI) distribuída globalmente. A experiência será simplificada para:

*   **Instalação global única:** `npm install -g automatize-agent`
*   **Inicializar projeto local:** `automatize-agent init` (criará apenas as configurações locais e pastas de contexto, consumindo a inteligência dos subagentes globalmente).

---

## 📝 Licença
Distribuído sob a licença MIT. Veja o repositório principal no GitHub para mais informações.
