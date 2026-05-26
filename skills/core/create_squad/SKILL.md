# SKILL NATIVA: CRIAÇÃO E CONFIGURAÇÃO DE SQUADS (create_squad)

Esta skill orienta o orquestrador principal a guiar o usuário na criação e configuração de novas squads e subagentes personalizados no projeto, garantindo conformidade com os padrões arquiteturais do Automatize Agent.

---

## 1. Diretriz de Ação (Fluxo do Orquestrador)

Quando o usuário solicitar "Criar nova squad", "Configurar squad" ou acionar a **Opção 6** do menu de controle, a IA deve guiar o usuário através dos seguintes passos:

### Passo 1: Definição do Escopo e Nome
1. Pergunte o **Nome da Squad** (ex: `marketing`, `financas`, `vendas`).
2. Solicite uma breve descrição da responsabilidade principal desta squad.
3. Pergunte quais subagentes existentes (ex: `Coder`, `DataRetrieval`, `Guardrail`) devem fazer parte desta nova squad.

### Passo 2: Registro de Configuração
1. Atualize o arquivo `config.json` do projeto, garantindo que o nome da nova squad seja registrado nos históricos de preferências, se necessário.
2. Defina no `config.json` a squad recém-criada como a squad ativa (`preferences.active_squad`) se o usuário solicitar sua ativação imediata.

### Passo 3: Criação e Associação de Subagentes
1. Para cada subagente selecionado que pertencerá à nova squad:
   * Abra o arquivo markdown correspondente em `.agent/subagents/[nome_do_agente].md`.
   * Adicione a tag da nova squad no frontmatter (metadados) do arquivo:
     ```yaml
     ---
     squads:
       - developer
       - nova_squad
     ---
     ```
2. Se o usuário desejar um novo subagente especialista customizado para esta squad:
   * Gere o arquivo `.agent/subagents/[nome_do_agente].md` utilizando como base a especificação de estrutura padrão (Entrada, Protocolo Crítico, Saída).
   * Adicione o frontmatter com a tag da squad correspondente.

### Passo 4: Registro da Especificação (Auto-Documentação)
*   Gere um arquivo explicativo em `.agent/specs/squad_[nome_da_squad].md` listando todos os agentes participantes, responsabilidade principal e fluxo de controle daquela squad.

---

## 2. Validações e Regras de Segurança
*   **Isolamento de RAG de Projetos:** Certifique-se de que a nova squad leia apenas o contexto e histórico da pasta do projeto ativo (`01_Projects/[project_name]`), nunca cruzando dados com outras pastas do cofre do Obsidian para manter o isolamento absoluto.
*   **Integridade dos Arquivos:** Nunca delete ou substitua agentes globais essenciais (como `orchestrator_agent.md` ou `guardrail_agent.md`) sem consentimento explícito.
