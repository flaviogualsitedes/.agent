# 🤖 Agent Framework Híbrido

O **Agent Framework Híbrido** é uma estrutura ultra-organizada para agentes de IA locais. Ele foi projetado especialmente para desenvolvedores que necessitam de consistência arquitetural, memória persistente a longo prazo e guias modulares passo a passo para execução de tarefas complexas.

Este projeto resolve os problemas de **perda de contexto** e **código incompleto**, oferecendo uma divisão inteligente de responsabilidades (Orquestrador + Subagentes) e integração nativa com o **Obsidian** ou armazenamento local Git.

---

## 🛠️ Instalação no seu Projeto

Para integrar este framework ao seu repositório de desenvolvimento, basta clonar este repositório diretamente em uma pasta chamada `.agent` na raiz do seu projeto:

```bash
git clone https://github.com/flaviogualsitedes/.agent.git .agent
```

Ao fazer isso, a sua pasta `.agent` terá a seguinte estrutura:

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
└── project/                    # Contexto específico deste repositório (Não é sobrescrito no update)
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
Se o caminho do Obsidian estiver vazio, o agente usará automaticamente a pasta `project/` local interna do framework. O histórico de acertos e erros persistirá diretamente no repositório do seu projeto.

---

## 🔄 Ciclo de Execução Contínuo e Comandos

### Gatilho `/setup-agent`
Configure e crie a estrutura de pastas inicial no Obsidian ou local interativamente através do chat de inteligência enviando: `/setup-agent`.

### Gatilho `/update-agent`
Atualize a inteligência e os subagentes sem perder nenhuma configuração de projeto ou histórico com o comando: `/update-agent`.

---

## 📝 Licença
Distribuído sob a licença MIT. Veja o repositório principal no GitHub do autor para mais informações.
