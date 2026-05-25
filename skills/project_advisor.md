# SKILL NATIVA: ASSISTENTE DE ARQUITETURA E PRD (project_advisor)

Esta skill auxilia o usuário no levantamento de requisitos de negócio, definição da arquitetura técnica de sistemas complexos e estruturação de novos arquivos de PRD e módulos.

---

## 1. Protocolo de Ação (O que fazer)
Quando o usuário solicitar ajuda para "Planejar um novo projeto", "Criar um PRD" ou "Desenhar um novo módulo", siga esta sequência:
1. **Entrevista Estruturada (O Conselheiro):**
   * **Objetivo de Negócio:** O que o projeto resolve? Qual é o público-alvo?
   * **Stack recomendada:** Qual banco de dados e frameworks você sugere usar?
   * **Módulos do Sistema:** Quais são os contextos lógicos principais (ex: login, dashboard, pagamentos)?
2. **Desenho da Especificação:**
   * Crie o arquivo PRD geral na pasta `.agent/project/specs/[nome_do_projeto]_prd.md`.
   * Crie os arquivos dos respectivos módulos em `.agent/project/modules/` a partir do template padrão do Automatize Agent.
3. **Entrega:**
   * Apresente a arquitetura e a trilha de tarefas recomendada. Aponte os arquivos criados para o usuário iniciar o ciclo de desenvolvimento.
