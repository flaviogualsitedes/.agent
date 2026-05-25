# DIRETRIZES GLOBAIS DE DESENVOLVIMENTO (GLOBAL RULES)

Este documento é a lei máxima deste repositório. Todos os agentes e subagentes devem obedecer cegamente a estas regras. Nenhuma linha de código deve ser gerada ou aprovada se violar os pontos abaixo.

---

## 1. Padrões de Arquitetura e Engenharia
* **Foco do Sistema:** Este repositório hospeda aplicações com arquitetura SaaS multi-tenant ou esteiras de automação críticas. O código deve ser escalável, isolado e seguro.
* **Clean Code e SOLID:** Métodos e funções devem ser curtos e ter responsabilidade única. Se uma função faz mais de uma coisa, ela deve ser modularizada e dividida.
* **Tratamento de Erros (Fail-Fast):** Valide todas as entradas, parâmetros e variáveis de ambiente logo no início da execução. Levante exceções ou retorne erros imediatamente para evitar execuções fantasmas.
* **Injeção de Dependência:** Evite acoplamento rígido. Sempre que possível, passe dependências (instâncias de banco, serviços externos, configurações) via construtor ou parâmetros de função para permitir testabilidade de forma isolada.

---

## 2. Protocolo de Redução de Carga Cognitiva (Rigoroso - TDAH)
O desenvolvedor deste projeto opera sob restrições estritas de atenção (TDAH). Para mitigar erros de montagem, esquecimentos e confusão mental, os agentes de escrita devem seguir este protocolo:
* **PROIBIÇÃO DE CÓDIGO PARCIAL:** É terminantemente proibido omitir trechos de código usando comentários como `// ... restante do código`, `// mantenha a lógica anterior` ou `/* código original aqui */`.
* **CÓDIGO 100% COMPLETO:** Toda resposta que modifique ou crie um arquivo deve fornecer o código integral do arquivo do início ao fim. Sem exceções. Se o arquivo modificado tiver centenas de linhas, todas devem ser reescritas com as devidas alterações incorporadas.
* **IDENTIFICAÇÃO DE CAMINHO:** Todo bloco de código deve ser imediatamente precedido por uma linha indicando o nome e o caminho exato do arquivo (ex: `src/backend/webhooks/gateway.ts`).

---

## 3. Comportamento e Alinhamento Técnico (Anti-Sycophancy)
* **Não seja conivente:** Se o usuário solicitar uma implementação rápida que quebre os padrões de modularização, crie débitos técnicos graves ou introduza falhas de segurança, você DEVE discordar e propor a abordagem correta.
* **Interrupção por Inconsistência:** Se o input do usuário carecer de dados fundamentais (como chaves de API, variáveis de ambiente, ou definições de tipos), admita a falha e interrompa a execução da pipeline até que os dados fornecidos sejam corrigidos.

---

## 4. Priorização de Regras (Regras Locais vs Globais)
* **Regras Locais:** O agente sempre deve ler a pasta `.agent/project/rules/` (ou a equivalente no Obsidian).
* Se houver algum conflito de escopo ou implementação específica da tecnologia do projeto, as **Regras Locais do Projeto têm precedência** sobre as diretrizes deste arquivo global, contanto que não violem a regra de "Código 100% Completo".