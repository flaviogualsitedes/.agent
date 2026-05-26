# SKILL NATIVA: CRIADOR DE SKILLS (create_skill)

Esta skill orienta o orquestrador principal a interagir com o usuário para projetar, codificar, testar e documentar novas habilidades personalizadas de forma rigorosa e profissional para o ecossistema do **Automatize Agent**.

---

## 1. Gatilhos de Ativação
Ative esta skill quando o usuário manifestar intenção de:
* "Criar uma nova skill para [X]"
* "Escrever uma ferramenta ou habilidade de [Y]"
* "Como crio uma skill personalizada?"
* `/criar-skill` ou `/create-skill`

---

## 2. Ciclo de Vida de Criação da Skill

### Passo 1: Entrevista de Escopo, Categoria e Tipo
Antes de escrever qualquer código, entreviste o usuário de forma sucinta para obter as seguintes definições:
1. **Objetivo:** O que a skill habilitará os agentes a fazer?
2. **Contexto de Ativação:** Quais gatilhos específicos ativam essa skill?
3. **Categoria da Skill:** Em qual categoria/pasta ela se encaixa? (ex: `development`, `devops`, `security`, `database`, `utils` ou uma nova categoria sugerida).
4. **Tipo de Skill:**
   * **Prompt:** Instruções comportamentais puras (sem scripts ou dependências).
   * **Script:** Executa um script local (Node.js, Python, Bash) para processamento determinístico.
   * **API/MCP:** Integra com serviços externos (ex: APIs HTTP, servidores MCP).
   * **Híbrida:** Mistura código local com chamadas de rede/MCP.
5. **Variáveis e Dependências:** Quais segredos (`env_vars`), dependências de pacotes ou permissões são exigidos?

### Passo 2: Estrutura Modular da Habilidade (Subpastas de Categoria)
A habilidade criada deve ser armazenada em seu diretório isolado sob `.agent/skills/[categoria]/[nome_da_skill]/` (ou no caminho configurado do Obsidian) contendo a seguinte estrutura:

1. **`SKILL.md` (Arquivo Principal):**
   * **Cabeçalho YAML (Frontmatter):**
     ```yaml
     name: nome-da-skill
     category: categoria-da-skill
     description: Descrição curta do que ela faz, focada nos gatilhos de ativação.
     type: prompt | script | mcp | hybrid
     version: 1.0.0
     ```
   * **Corpo em Markdown:**
     * **Objetivo Geral:** O que ela resolve.
     * **Gatilhos de Ativação:** Situações claras de quando utilizá-la.
     * **Protocolo de Ação (Passo a Passo):** Instruções lógicas e sequenciais detalhadas para o agente executar.
     * **Anti-padrões (O que NÃO fazer):** Pelo menos 2 comportamentos a serem evitados durante a execução desta skill.
     * **Exemplos de Entrada/Saída:** Pelo menos 1 caso realista demonstrando o comportamento correto esperado.

2. **Arquivos Auxiliares (Opcional):**
   * Se a skill contiver scripts executáveis, coloque-os na mesma pasta (ex: `helper.js`, `runner.py`).

### Passo 3: Criação de Testes e Evals (Validação Rígida)
Para garantir que a skill funciona corretamente, crie um conjunto de testes de validação:
1. Proponha ao usuário **2 casos de teste realistas** com base em prompts que um usuário final utilizaria.
2. Escreva as asserções de sucesso que descrevem objetivamente como verificar se a saída está correta.
3. Se o tipo da skill envolver código, monte um script simples de validação rápida na subpasta da própria skill para validar o output do agente.

### Passo 4: Registro no Catálogo Local
* Crie a pasta da categoria e da skill no diretório de destino e salve os arquivos correspondentes.
* Oriente o usuário a atualizar o planejamento (`.agent/planning.md`) ou executar o comando de sincronização de contexto para validar o novo agente de forma funcional.
