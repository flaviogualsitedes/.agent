---
squad_id: sales
name: Squad de Vendas e Growth
description: Focada em estratégias de prospecção, scripts de vendas, análise de pipeline comercial, automação de CRM e growth hacking. Ideal para times comerciais.
icon: 💼
default: false
---

# SQUAD: SALES

Esta squad é ativada para projetos e tarefas voltados a vendas, growth,
prospecção outbound/inbound e otimização do pipeline comercial.

---

## Agentes Ativos nesta Squad

Os agentes abaixo possuem a tag `squads: [sales]` no seu frontmatter e serão
carregados pelo Orquestrador quando esta squad estiver ativa.

| Agente                      | Papel Principal                                              |
|-----------------------------|--------------------------------------------------------------|
| `OrchestratorAgent`         | Maestro — decompõe e roteia as tarefas                       |
| `Writer`                    | Scripts de cold call, e-mail de prospecção, propostas        |
| `BusinessLogicAgent`        | Análise de funis, churn, LTV, CAC e métricas de vendas       |
| `DataRetrievalAgent`        | Pesquisa de leads, concorrentes e oportunidades de mercado   |
| `ResponseFormatterAgent`    | Relatórios de pipeline, dashboards e resumos executivos      |
| `MemoryAndContextAgent`     | Mantém o contexto de leads, objeções e histórico de follow-up|

---

## Escopo de Atuação

- **Foco:** Prospecção, qualificação de leads, scripts de vendas, análise de funil
- **Artefatos Comuns:** `pitch.md`, `email_sequence.md`, `pipeline_report.md`, `objection_handling.md`
- **Skills Core Implícitas:** `context_audit`, `search_skills`, `project_advisor`

---

## Como Ativar

Via setup interativo ou pelo menu `/automatize-agent`:
```
Opção 6 → Configurar Preferências → Escopo: Vendas e Growth
```

Ou diretamente no `config.json`:
```json
"preferences": {
  "active_squad": "sales"
}
```
