# Especificação: Integração Dinâmica e Configuração com Obsidian

Esta especificação define o comportamento e a arquitetura da funcionalidade de integração direta e automática com o Obsidian durante o fluxo de inicialização (`setup.ps1` / `setup.sh`).

## Motivação
Anteriormente, a estrutura de pastas do Obsidian (`00_Global`, `01_Projects`) necessitava de um caminho absoluto físico local e dependia exclusivamente de escritas em disco. Se o usuário inserisse o caminho com pequenas divergências ou utilizasse um ambiente híbrido, a sincronização inicial falhava. Além disso, o suporte direto para o **Antigravity IDE** como opção de bridge principal precisava de destaque.

## Nova Arquitetura de Setup

### 1. Detecção e Seleção de IDE
* **Antigravity IDE** foi adicionado como a opção **[1] (Recomendada)** no fluxo interativo de instalação.
* Quando selecionado, ele cria automaticamente um arquivo de ponte `.cursorrules` na raiz do projeto contendo as diretivas de comportamento.

### 2. Integração com Obsidian REST API
* A entrada do caminho físico (`VaultPath`) tornou-se **opcional**.
* Se o usuário optar por habilitar o Obsidian e fornecer o **Vault ID** e o **Bearer Token**, o instalador efetuará requisições HTTPS `PUT` locais diretamente na API:
  * URL Base: `https://127.0.0.1:27124`
  * Endpoints utilizados:
    * `/vault/00_Global/global_rules.md` (Escreve e sincroniza as regras globais)
    * `/vault/01_Projects/{ProjectName}/memory/.gitkeep`
    * `/vault/01_Projects/{ProjectName}/modules/.gitkeep`
    * `/vault/01_Projects/{ProjectName}/tasks/.gitkeep`
* Se a requisição HTTP for bem-sucedida, a estrutura é integrada via API imediatamente sem necessitar de caminho físico.
* Em caso de falha de conexão (ex: Obsidian fechado), o script tenta usar o caminho físico do disco como *fallback*. Se este também não existir ou falhar, o instalador prossegue orientando o usuário.

## Exemplos de Uso no Setup

### PowerShell (`setup.ps1`)
O script desabilita temporariamente a verificação SSL (`ServerCertificateValidationCallback = {$true}`) para aceitar o certificado autoassinado do plugin do Obsidian e executa `Invoke-RestMethod`.

### Bash (`setup.sh`)
O script utiliza o comando `curl -s -k` para ignorar problemas de certificado e efetua o upload direto da estrutura de pastas.
