# SKILL NATIVA: CRIADOR DE SUBAGENTES (create_agent)

Esta skill orienta o orquestrador principal a estruturar novos subagentes especializados, gerando arquivos de instruções limpos para novas personas no ecossistema.

---

## 1. Protocolo de Ação (O que fazer)
Quando o usuário solicitar "Criar um novo agente ou subagente", execute os passos:
1. **Entrevista de Persona:**
   * Pergunte qual o papel técnico principal do subagente (ex: `DevOpsEngineer`, `DatabaseAdministrator`).
   * Pergunte quais são as ferramentas recomendadas que ele deve usar.
2. **Definição da Instrução do Subagente:**
   * Crie o arquivo markdown em `.agent/subagents/[nome_do_agente].md` (ou pasta correspondente no Obsidian).
   * O subagente deve ter a seguinte estrutura padrão:
     * **Perfil:** Sua função exclusiva no sistema.
     * **Diretriz de Entrada (Input):** O que ele lê para iniciar a tarefa.
     * **Protocolo de Ação:** O que ele deve validar ou escrever.
     * **Diretriz de Saída (Output):** O formato final de entrega ou aprovação.
3. **Registro:** Notifique o usuário com o caminho do arquivo criado.
