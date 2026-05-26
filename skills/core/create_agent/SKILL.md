# SKILL NATIVA: CRIADOR DE SUBAGENTES (create_agent)

Esta skill orienta o orquestrador principal a projetar e configurar subagentes especializados, estabelecendo instruções robustas, definições de persona e controle rígido de qualidade no ecossistema do **Automatize Agent**.

---

## 1. Gatilhos de Ativação
Esta skill deve ser executada quando o usuário manifestar a intenção de:
* "Criar um subagente especialista em [X]"
* "Adicionar uma persona de [Y] para o time"
* "Dividir a tarefa criando um agente ajudante"
* `/criar-agente` ou `/create-agent`

---

## 2. Protocolo de Ação (O que fazer)

### Passo 1: Entrevista de Persona e Capacidades
Pergunte ao usuário de forma estruturada:
1. **Perfil Exclusivo:** Qual a missão e foco principal deste subagente?
2. **Contexto de Entrada:** O que ele deve ler para iniciar sua tarefa (arquivos, diretórios, variáveis)?
3. **Ferramentas e Skills:** Quais ferramentas ou skills (nativas ou locais organizadas por categoria) ele terá permissão para utilizar?
   * *Nota estrutural:* Mapeie as skills utilizando o formato `[categoria]/[nome_da_skill]` (ex: `development/create_skill`).
4. **Entregável Esperado:** Qual o output final ou artefato esperado (código, relatório, infra)?

### Passo 2: Estrutura Rigorosa da Persona do Agente
Gere o arquivo do subagente em `.agent/subagents/[nome_do_agente].md` seguindo o padrão abaixo:
* **Cabeçalho (Frontmatter YAML):**
  ```yaml
  name: NomeDoAgente
  role: Papel técnico principal (ex: DevOps, DatabaseExpert)
  version: 1.0.0
  description: Breve descrição da utilidade e missão do agente.
  ```
* **Perfil e Missão:** O papel dele no time de forma detalhada e em tom imperativo.
* **Princípios Decisórios:** No mínimo **4 regras de decisão claras** que o subagente deve seguir ao escrever código ou analisar sistemas (ex: "Sempre priorize performance sobre simplicidade", "Sempre verifique permissões antes de ler").
* **Diretrizes de Entrada e Fluxo:** O passo a passo lógico do que ele faz do início ao fim.
* **Anti-padrões (Comportamentos Proibidos):**
  * Liste pelo menos 3 coisas que o subagente **NUNCA** deve fazer (ex: "Nunca utilize placeholders ou comentários ocultando código", "Nunca execute comandos destrutivos sem avisar").
  * Liste pelo menos 2 coisas que ele **SEMPRE** deve garantir.
* **Critérios de Qualidade (DoD):** Checklist prático com `- [ ]` para que o subagente auto-avalie sua própria entrega antes de finalizar.

### Passo 3: Versionamento Semântico (SemVer)
Sempre que o usuário solicitar uma alteração ou ajuste nas regras de um subagente existente, aplique a regra de versionamento no frontmatter:
* **Patch (x.x.X):** Correções de digitação, pequenos ajustes textuais ou esclarecimento de regras secundárias.
* **Minor (x.X.0):** Adição de novos princípios decisórios, novas permissões de ferramentas ou novos exemplos.
* **Major (X.0.0):** Mudança completa do escopo do subagente, reestruturação da persona ou fusão com outro agente.

### Passo 4: Registro e Feedback
* Crie o arquivo e notifique o usuário exibindo o caminho absoluto.
* Explique a lógica por trás da persona criada para garantir o alinhamento com a visão de desenvolvimento dele.
