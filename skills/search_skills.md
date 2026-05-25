# SKILL NATIVA: BUSCADOR DE SKILLS (search_skills)

Esta skill orienta o orquestrador principal a vasculhar o diretório de skills local e global em busca de funções reutilizáveis, evitando que o usuário reescreva habilidades que já existem no ecossistema.

---

## 1. Protocolo de Ação (O que fazer)
Quando o usuário solicitar "Buscar uma skill" ou "Verificar se há skill para X", execute:
1. **Coleta de Palavras-Chave:**
   * Extraia os termos e objetivos da pesquisa do usuário.
2. **Busca nos Diretórios de Skills:**
   * Se o Obsidian estiver ativo:
     * Vasculhe a pasta `00_Global/code_snippets/` e a pasta de skills específicas do projeto.
   * Se a memória for local:
     * Vasculhe a pasta `.agent/skills/` e `.agent/project/modules/` em busca de regras reutilizáveis.
3. **Apresentação dos Resultados:**
   * Retorne uma tabela markdown listando as skills encontradas, seu objetivo básico e o caminho do arquivo para o usuário.
