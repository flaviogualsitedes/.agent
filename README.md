# 🤖 Automatize Agent

O **Automatize Agent** é uma estrutura de squads de IA locais e orquestração de desenvolvimento de alta performance. Ele foi projetado especialmente para desenvolvedores que necessitam de consistência arquitetural, memória persistente a longo prazo e guias modulares passo a passo para execução de tarefas complexas, mitigando a sobrecarga cognitiva e evitando códigos incompletos.

Este projeto resolve os problemas de **perda de contexto** e **código incompleto**, oferecendo uma divisão inteligente de responsabilidades (Orquestrador + 7 Subagentes especialistas) e integração nativa com o **Obsidian** ou armazenamento local Git.

---

## 🛠️ Guia de Inicialização Híbrida (CLI Global ou Git Clone)

Você pode instalar o framework globalmente via CLI ou inicializá-lo de forma local pura clonando o repositório diretamente na raiz do seu projeto.

### Opção A: Instalação Local Pura (Git Clone)
Esta abordagem é ideal se você prefere não instalar dependências de Node globais em sua máquina.

1. No terminal, na raiz do seu projeto de desenvolvimento, execute o clone direcionando para a pasta `.agent`:
   ```bash
   git clone https://github.com/flaviogualsitedes/.agent.git .agent
   ```
2. Acesse a pasta `.agent/` e rode o script de setup correspondente ao seu sistema operacional:
   * **No Windows (PowerShell):**
     ```powershell
     powershell -ExecutionPolicy Bypass -File .\setup.ps1
     ```
   * **No Linux / macOS (Bash):**
     ```bash
     chmod +x setup.sh && ./setup.sh
     ```
3. O assistente interativo guiará você coletando o **Nome do Projeto**, **Caminho Físico**, a **IDE de preferência** (Cursor, Claude Code, etc.), **Idioma** e **Padrão de CSS/Estilização**, gerando automaticamente a ponte com a IDE e realizando o backup de regras pré-existentes na raiz de forma segura.

---

### Opção B: Instalação via CLI Global (`automatize-agent`)
A experiência simplificada usando nosso utilitário compilado de linha de comando:

1. Instale o pacote globalmente:
   ```bash
   npm install -g automatize-agent
   ```
2. Inicialize o projeto na raiz desejada:
   ```bash
   automatize-agent init
   ```
3. Gerencie as configurações, tokens do Obsidian e execute diagnósticos através do menu interativo de setas do teclado apenas digitando:
   ```bash
   automatize-agent
   ```

---

## 🔌 Integração Avançada: Obsidian Local REST API & MCP
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

## 🧩 Organização de Skills em Categorias
O framework possui habilidades estruturais nativas organizadas de forma modular em subpastas de categorias:

*   **`core/create_skill`**: Auxilia a IA a guiar você na criação de novas skills customizadas no formato markdown estruturado.
*   **`core/create_agent`**: Auxilia a estruturar e documentar novos subagentes de tarefas especializadas no ecossistema.
*   **`core/search_skills`**: Vasculha de forma recursiva e lista notas de habilidades.
*   **`core/audit_security`**: Varre recursivamente os arquivos de regras locais e novas notas identificando possíveis injeções de prompt ou códigos maliciosos.
*   **`core/clean_code`**: Regra transversal de boas práticas de engenharia, PSR/PEP e internacionalização de documentações.
*   **`design/impeccable`**: Diretrizes de design e UX (regras de cores OKLCH, contrastes acessíveis e ritmos espaciais).

---

## 📝 Licença
Distribuído sob a licença MIT. Veja o repositório principal no GitHub para mais informações.
