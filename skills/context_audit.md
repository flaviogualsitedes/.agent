# SKILL NATIVA: AUDITORIA DE CONTEXTO E CONSUMO (context_audit)

Esta skill orienta o orquestrador principal a auditar e corrigir o desperdício de tokens e o uso ineficiente da janela de contexto no chat de IA / IDE do desenvolvedor, tornando a IA mais rápida e barata.

---

## Os 9 Padrões de Desperdício (Adaptados para Automatize Agent)

| # | Padrão | Impacto no Custo | Correção rápida |
|---|--------|-----------|-----------------|
| 1 | `main.md` e regras locais gigantes | ~15% | Manter regras combinadas < 1.500 palavras |
| 2 | Releitura de histórico longo | ~13% | Sessões < 25 mensagens; usar comandos de resumo |
| 3 | Injeções e hooks duplicados | ~11% | Manter apenas um hook de status ativo |
| 4 | Notas de RAG inchadas no Obsidian | ~10% | Notas de memória em `memory/` devem focar em apenas 1 bug/acerto |
| 5 | Skills carregadas sem necessidade | ~8% | Manter 3–4 skills na pasta ativa; mover o resto para backup |
| 6 | Servidores MCP inativos consumindo schema | ~6% | Desativar MCPs que não estão em uso na sessão |
| 7 | Pensamento estendido em tarefas simples | ~5% | Desativar raciocínio profundo para tarefas de refatoração simples ou explicação |
| 8 | Respostas em direções erradas | ~4% | Interromper a IA nos primeiros 5s caso perceba desvio técnico |
| 9 | Registros de tasks gigantes no Git | ~3% | Dividir PRDs e checklists em arquivos de módulos separados em `modules/` |

---

## Fluxo de Auditoria e Diagnóstico

Quando o usuário solicitar "Auditar contexto", "Verificar consumo" ou "Deixar o agente mais rápido", o orquestrador principal deve:

1. **Checar arquivos locais:**
   * Contar palavras do `main.md` e `rules/global.md`. (Meta combinado: < 1.500 palavras).
   * Contar palavras de todas as regras ativas na pasta `project/rules/`. (Meta individual: < 400 palavras por arquivo).
2. **Checar Módulos e Memórias:**
   * Validar se a pasta `project/memory/` ou `project/modules/` possui arquivos muito extensos. Se possuir arquivos com mais de 3.000 palavras, recomendar a divisão.
3. **Checar Conexões MCP (Obsidian API):**
   * Verificar se `obsidian_api.enabled` está ativo e notificar se o servidor REST API/MCP está rodando de forma limpa.
4. **Recomendar as Ações de Ajuste:**
   * Apresentar o relatório em tabela e sugerir a otimização dos arquivos correspondentes para economizar tokens.
