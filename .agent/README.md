# 🤖 Agent Framework Híbrido

O **Agent Framework Híbrido** é uma estrutura ultra-organizada para agentes de IA locais. Ele foi projetado especialmente para desenvolvedores que necessitam de consistência arquitetural, memória persistente a longo prazo e guias modulares passo a passo para execução de tarefas complexas.

Este projeto resolve os problemas de **perda de contexto** e **código incompleto**, oferecendo uma divisão inteligente de responsabilidades (Orquestrador + Subagentes) e integração nativa com o **Obsidian** ou armazenamento local Git.

---

## 🛠️ Arquitetura do Sistema

A pasta `.agent` deve ser adicionada à raiz de qualquer projeto. Ela contém a inteligência e as regras de desenvolvimento que seu agente irá ler antes de executar:

```text
.agent/
├── config.json                 # Configurações de ambiente, fases e caminhos de memória
├── main.md                     # Agente Principal (Orquestrador e Ciclo de Execução)
├── README.md                   # Este arquivo de documentação
├── rules/
│   └── global.md               # Diretrizes globais de desenvolvimento (ex: Clean Code, SOLID)
├── subagents/
│   ├── architect.md            # Subagente Architect (Gera o plano técnico)
│   ├── coder.md                # Subagente Coder (Implementa código 100% completo)
│   └── reviewer.md             # Subagente Reviewer (Qualidade, testes e validação)
└── project/                    # Contexto específico deste repositório
    ├── rules/                  # Regras Locais (ex: regras específicas deste banco de dados)
    ├── specs/                  # Especificações técnicas e PRDs gerais do projeto
    ├── memory/                 # Histórico local de acertos/erros (usado sem Obsidian)
    └── modules/                # Trilhas de módulos (ex: login.md, integration.md)
```

---

## 💾 Gestão Híbrida de Memória (RAG)

O agente pode operar em duas modalidades de memória:

### 1. Modo Obsidian (Recomendado)
Mantém uma pasta centralizada fora do seu projeto para cruzar aprendizados entre diferentes repositórios:
1. No seu Obsidian, crie a seguinte estrutura:
   ```text
   Obsidian Vault/
   ├── 00_Global/                       # Regras globais e snippets reutilizáveis
   └── 01_Projects/                     # Projetos isolados
       └── [Nome-Do-Projeto]/           # Nome definido no config.json do repositório
           ├── memory/                  # Histórico de acertos e erros
           ├── modules/                 # Módulos e tarefas ativos
           └── tasks/                   # Logs de execuções
   ```
2. No seu projeto local, edite o `.agent/config.json` definindo o caminho absoluto do seu cofre em `rag_memory.obsidian_vault_path` e ative o `enabled: true`.

### 2. Modo Local (Fallback Git)
Se o caminho do Obsidian estiver vazio, o agente usará automaticamente a pasta `.agent/project/` local. O histórico de acertos e erros persistirá diretamente no repositório.

---

## 🔄 Ciclo de Execução Contínuo

A cada tarefa solicitada, o agente segue um ciclo estruturado para evitar defasagem:
1. **Sync Inicial:** Carrega regras globais, locais e a memória histórica.
2. **Plano (Architect):** Cria um `PLAN.md` na raiz mapeando quais arquivos alterar e o passo a passo.
3. **Escrita (Coder):** Aplica o código de forma estritamente completa (100% de integridade dos arquivos modificados - sem resumos ou omissões).
4. **Revisão (Reviewer):** Executa testes ou analisa a entrega. 
5. **Sync Final:** Atualiza o progresso das tarefas no módulo ativo, documenta novas lições aprendidas (acertos/erros) na pasta `memory/` e atualiza a esteira no `config.json`.

---

## 🧩 Como Criar Módulos e Trilhas

Para guiar o agente em implementações complexas (ex: criar um módulo de login ou integração):
1. Copie o arquivo `.agent/project/modules/template_module.md` e renomeie-o para o nome da funcionalidade (ex: `login.md`).
2. Defina os requisitos do PRD e o checklist na seção de tasks do arquivo.
3. Defina o módulo como ativo no `config.json` no campo `esteira.active_module`.
4. O agente lerá esse escopo e priorizará o checklist definido para o módulo.

---

## 📝 Licença
Distribuído sob a licença MIT. Veja o repositório principal no GitHub do autor para mais informações.
