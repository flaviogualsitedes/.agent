---
squad_id: marketing
name: Squad de Marketing e Copywriting
description: Focada em estratégia de conteúdo, copywriting persuasivo, SEO, campanhas de e-mail, geração de imagens e assets de marca. Ideal para projetos de marketing digital.
icon: 📣
default: false
---

# SQUAD: MARKETING

Esta squad é ativada para projetos e tarefas voltados a marketing digital, branding,
produção de conteúdo, copywriting e estratégias de crescimento.

---

## Agentes Ativos nesta Squad

Os agentes abaixo possuem a tag `squads: [marketing]` no seu frontmatter e serão
carregados pelo Orquestrador quando esta squad estiver ativa.

| Agente                      | Papel Principal                                      |
|-----------------------------|------------------------------------------------------|
| `OrchestratorAgent`         | Maestro — decompõe e roteia as tarefas               |
| `Writer`                    | Copywriting, SEO, e-mails, roteiros e artigos        |
| `Designer`                  | Criação de assets visuais, banners e identidade      |
| `DataRetrievalAgent`        | Pesquisa de mercado, concorrentes e tendências       |
| `BusinessLogicAgent`        | Análise de KPIs, funis e métricas de conversão       |
| `ResponseFormatterAgent`    | Formata entregas (relatórios, briefings, pautas)     |
| `MemoryAndContextAgent`     | Mantém o tom de voz, brand guide e histórico         |

---

## Escopo de Atuação

- **Foco:** Conteúdo persuasivo, campanhas de ads, SEO on-page, e-mail marketing
- **Artefatos Comuns:** `copy.md`, `brief.md`, `seo_report.md`, `email_sequence.md`
- **Skills Core Implícitas:** `context_audit`, `search_skills`

---

## Como Ativar

Via setup interativo ou pelo menu `/automatize-agent`:
```
Opção 6 → Configurar Preferências → Escopo: Marketing e Copywriting
```

Ou diretamente no `config.json`:
```json
"preferences": {
  "active_squad": "marketing"
}
```
