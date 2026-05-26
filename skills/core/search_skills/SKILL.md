# SKILL NATIVA: BUSCADOR DE SKILLS (search_skills)

Esta skill orienta o orquestrador principal a buscar e instalar habilidades especializadas e reutilizáveis do ecossistema, evitando que o usuário reinvente a roda ou reescreva comportamentos já existentes.

---

## 1. Gatilhos de Ativação
Esta skill é ativada quando o usuário solicitar explicitamente ou der indícios de:
* "Buscar uma skill para [funcionalidade]"
* "Procurar uma ferramenta de [tarefa]"
* "Como eu faço [X]?" (se não houver uma skill local que já resolva)
* `/buscar-skill <termo>` ou `/find-skill <termo>`

---

## 2. Protocolo de Ação (O que fazer)

### Passo 1: Busca e Pesquisa
1. **Verificação Local (Recursiva):** Procure na pasta de skills do projeto atual (geralmente `.agent/skills/` ou no diretório configurado do Obsidian `00_Global/code_snippets/`) realizando uma varredura recursiva de diretórios e subpastas de categorias.
   * Identifique e leia cada arquivo `SKILL.md` ou arquivos `.md` na raiz para mapear os nomes e as descrições no frontmatter.
2. **Busca Global:** Oriente o usuário a buscar novas habilidades no diretório central e ecossistema aberto utilizando o comando CLI:
   ```bash
   automatize-agent search <termo_pesquisa>
   ```
   *(Substitua `<termo_pesquisa>` pela palavra-chave do objetivo do usuário).*

### Passo 2: Avaliação e Recomendação
Quando encontrar correspondências de skills no diretório central ou local, analise e sugira ao usuário com base em:
* **Categoria/Localização:** Exiba em qual categoria a skill está alocada (ex: `devops/setup_coolify`).
* **Escopo:** Se atende especificamente ao problema técnico ou de negócio solicitado.
* **Complexidade:** Se a skill requer dependências externas (como APIs pagas, tokens, etc.) e informe ao usuário.

### Passo 3: Instrução de Instalação
Apresente a skill encontrada de forma clara e informe o comando exato que o usuário deve rodar no terminal para adicioná-la ao projeto:
```bash
automatize-agent install <categoria>/<nome_da_skill>
```
*Após a instalação, oriente o usuário a executar um reset ou sincronização de contexto para que a nova skill passe a atuar no projeto.*
