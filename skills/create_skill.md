# SKILL NATIVA: CRIADOR DE SKILLS (create_skill)

Esta skill orienta o orquestrador principal a interagir com o usuário e gerar novas habilidades customizadas no formato markdown estruturado.

---

## 1. Protocolo de Ação (O que fazer)
Quando o usuário solicitar para "Criar uma nova skill", você deve seguir esta sequência:
1. **Entrevista de Escopo:**
   * Pergunte qual o objetivo ou funcionalidade da nova skill (ex: "Skill de integração com o gateway de pagamento Stripe").
   * Pergunte quais variáveis de ambiente ou dependências externas ela necessita.
2. **Definição da Estrutura:**
   * Crie o arquivo markdown correspondente dentro da pasta de skills ativa do projeto (Obsidian ou local em `.agent/project/skills/[nome_da_skill].md`).
   * A skill deve ser escrita em Português do Brasil e conter:
     * **Objetivo:** Descrição do que a skill faz.
     * **Parâmetros/Inputs:** Variáveis exigidas.
     * **Protocolo de Ação:** Passo a passo lógico das ações que ela executa.
     * **Exemplo de Uso:** Bloco de código exemplificando como chamar.
3. **Registro:** Confirme a criação e apresente o caminho do novo arquivo.
