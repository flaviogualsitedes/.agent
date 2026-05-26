---
squad_id: developer
name: Squad de Desenvolvimento de Software
description: Focada em arquitetura, engenharia de software, código limpo, revisão e qualidade técnica. Ideal para projetos de criação ou manutenção de aplicações.
icon: 🛠️
default: true
---

# SQUAD: DEVELOPER

Esta squad é ativada por padrão para projetos de desenvolvimento de software.
Ela reúne os especialistas em arquitetura, implementação, qualidade e deploy.

---

## Agentes Ativos nesta Squad

Os agentes abaixo possuem a tag `squads: [developer]` no seu frontmatter e serão
carregados automaticamente pelo Orquestrador quando esta squad estiver ativa.

| Agente                      | Papel Principal                                      |
|-----------------------------|------------------------------------------------------|
| `OrchestratorAgent`         | Maestro — decompõe e roteia as tarefas               |
| `Architect`                 | Planeja a arquitetura e o PLAN.md                    |
| `Coder`                     | Implementa o código de forma transacional            |
| `Reviewer`                  | Audita qualidade, segurança e cobertura de testes    |
| `Tester`                    | Define e executa estratégias de teste                |
| `Designer`                  | UI/UX e design system                                |
| `DevOps`                    | Infraestrutura, CI/CD e deploy                       |
| `Syncer`                    | Sincronização de memória e estado com Obsidian       |
| `GuardrailAgent`            | Validação de integridade e segurança                 |
| `SelfHealingAndFallback`    | Recuperação de erros e fallbacks automáticos         |

---

## Escopo de Atuação

- **Linguagens:** Todas (detectado automaticamente via `config.json/detected_environment`)
- **Foco:** Qualidade de código, arquitetura limpa, testes automatizados, CI/CD
- **Skills Core Implícitas:** `clean_code`, `audit_security`, `context_audit`

---

## Como Ativar

Via setup interativo ou pelo menu `/automatize-agent`:
```
Opção 6 → Configurar Preferências → Escopo: Desenvolvimento de Software
```

Ou diretamente no `config.json`:
```json
"preferences": {
  "active_squad": "developer"
}
```
