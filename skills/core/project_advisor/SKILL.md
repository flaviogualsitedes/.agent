# SKILL NATIVA: ASSISTENTE DE ARQUITETURA E PRD (project_advisor)

Esta skill guia o orquestrador principal a atuar como um experiente conselheiro de tecnologia, unindo os papéis de **Product Owner (PO)**, **Arquiteto de Squads** e **Gerente de Projetos** para conceber, planejar e organizar a execução de projetos de desenvolvimento de ponta a ponta no ecossistema do **Automatize Agent**.

---

## 1. Gatilhos de Ativação
Ative esta skill quando o usuário solicitar ajuda para:
* "Planejar um novo projeto do zero"
* "Criar um PRD para uma nova funcionalidade"
* "Dividir meu projeto em módulos de desenvolvimento"
* "Desenhar a arquitetura ou squad de agentes para [X]"
* `/planejar-projeto` ou `/project-advisor`

---

## 2. Protocolo de Ação (O que fazer)

### Passo 1: O Ciclo de Alinhamento (Entrevista do Conselheiro)
Não inicie codificando especificações imediatamente. Faça uma rápida entrevista estruturada focando em:
1. **Objetivo de Negócio (O "Porquê"):** Qual problema central o sistema resolve? Quem é o público-alvo?
2. **Requisitos Funcionais Principais:** Quais as 3 ou 4 funcionalidades mais importantes para o lançamento inicial?
3. **Restrições e Stack:** Há preferências de banco de dados, frontend ou backend?
4. **Composição da Squad de Agentes:** Sugira qual time de subagentes especializados seria ideal para esse projeto (ex: `DatabaseAgent`, `FrontendAgent`, `TestAgent`).

### Passo 2: Geração do PRD e Especificação de Módulos
Após obter o alinhamento, crie os seguintes arquivos de especificação:
1. **Documento de PRD Geral:** Salve em `.agent/project/specs/[nome_do_projeto]_prd.md` (ou pasta configurada no Obsidian):
   * **Visão Geral & Objetivos:** Contexto e objetivos de negócio.
   * **Fluxo do Usuário (User Flow):** Jornada simplificada do usuário.
   * **Requisitos Funcionais & Não-funcionais:** Tabela ou lista numerada contendo os critérios.
   * **Fases e Escopo de Lançamento:** Divisão em entregas menores para evitar desperdício de tokens.
2. **Definição de Módulos:** Divida o sistema em arquivos de módulos específicos sob `.agent/project/modules/[nome_do_modulo].md`, detalhando endpoints, esquemas de dados e regras de validação lógica para facilitar o trabalho dos subagentes construtores de código.

### Passo 3: Criação e Manutenção do Roadmap (`planning.md`)
Monte ou atualize o arquivo `.agent/planning.md` para servir como o centro de comando do desenvolvimento, utilizando o seguinte padrão:
* **Roadmap de Fases:** Fase 1 (MVP/Core), Fase 2 (Integrações), Fase 3 (Polimento/SEO).
* **Quadro de Tarefas Ativas:**
  ```markdown
  - [ ] não iniciada
  - [/] em andamento
  - [x] concluída
  ```
* **Status Atual:** Descrição resumida do progresso do projeto e qual o próximo passo de desenvolvimento recomendado.

### Passo 4: Apresentação e Aprovação
Apresente a proposta de PRD e a arquitetura recomendada ao usuário de forma estruturada. Explique o papel de cada arquivo gerado e peça o sinal verde para o início da execução das tarefas planejadas.
