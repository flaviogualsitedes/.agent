---
squad_id: devops
name: Squad de DevOps e Infraestrutura
description: Focada em pipelines CI/CD, containerização, monitoramento, provisionamento de infraestrutura, segurança de ambientes e automação de operações.
icon: ⚙️
default: false
---

# SQUAD: DEVOPS

Esta squad é ativada para projetos com foco em infraestrutura, operações,
segurança de ambientes, automação de deploy e observabilidade.

---

## Agentes Ativos nesta Squad

Os agentes abaixo possuem a tag `squads: [devops]` no seu frontmatter e serão
carregados pelo Orquestrador quando esta squad estiver ativa.

| Agente                              | Papel Principal                                        |
|-------------------------------------|--------------------------------------------------------|
| `OrchestratorAgent`                 | Maestro — decompõe e roteia as tarefas                 |
| `DevOps`                            | CI/CD, Docker, Kubernetes, Terraform, scripts shell    |
| `GuardrailAgent`                    | Validação de segurança e conformidade (SAST/DAST)      |
| `ObservabilityAndTelemetryAgent`    | Logs, métricas, alertas e dashboards                   |
| `SelfHealingAndFallbackAgent`       | Recuperação automática de falhas e rollback            |
| `ActionExecutionAgent`              | Execução segura de comandos e scripts                  |
| `Reviewer`                          | Revisão de IaC (Terraform, Ansible, Helm Charts)       |
| `Syncer`                            | Sincronização de estado e artefatos de config          |

---

## Escopo de Atuação

- **Foco:** Pipeline CI/CD, IaC, containers, segurança, SRE, observabilidade
- **Artefatos Comuns:** `Dockerfile`, `docker-compose.yml`, `.github/workflows/*.yml`, `terraform/`
- **Skills Core Implícitas:** `audit_security`, `context_audit`, `clean_code`

---

## Como Ativar

Via setup interativo ou pelo menu `/automatize-agent`:
```
Opção 6 → Configurar Preferências → Escopo: DevOps e Infraestrutura
```

Ou diretamente no `config.json`:
```json
"preferences": {
  "active_squad": "devops"
}
```
