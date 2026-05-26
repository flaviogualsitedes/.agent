# SKILL NATIVA: BOAS PRÁTICAS DE DESENVOLVIMENTO (clean_code)

Esta skill orienta o orquestrador principal e os subagentes (especialmente Coder e Reviewer) a aplicar diretrizes universais de engenharia de software de alta performance, cobrindo Clean Code, arquitetura SOLID, documentação no idioma correto e segurança defensiva.

---

## 1. Padrão de Idioma e Documentação
*   **Comentários de Código (Docstrings e inline):** Devem seguir estritamente o idioma padrão e as práticas de especificação da linguagem de programação utilizada (ex: JSDoc para Javascript/Typescript, PSR-5/PHPDoc para PHP, PEP 257 para Python). 
    *   *Regra de Ouro:* Os comentários em si (texto explicativo das funções e variáveis) devem ser escritos no idioma nativo da linguagem em que ela foi projetada (geralmente **Inglês**) para manter a padronização do código fonte internacional.
*   **Relatórios e Documentos Externos:** Todas as saídas de texto destinadas ao desenvolvedor (como `PLAN.md`, `review_feedback.md`, relatórios de erros, diagramas explicativos e respostas de chat) devem ser escritas no idioma de preferência configurado pelo usuário em `config.json` (ex: **Português do Brasil**).

---

## 2. Princípios de Clean Code e Engenharia
*   **Responsabilidade Única (SRP):** Funções e classes devem ter um único motivo para mudar. Limite funções a no máximo 20 a 30 linhas de código lógico. Se ultrapassar, quebre em funções auxiliares isoladas.
*   **Legibilidade sobre Espertismo:** Escreva código autoexplicativo. Nomes de variáveis devem ser descritivos (ex: `isUserAuthenticated` em vez de `auth`). Evite abreviações confusas ou lógicas de uma única linha complexas demais.
*   **Princípio de Menor Surpresa:** O comportamento de uma função deve ser exatamente o sugerido pelo seu nome. Se a função `calculateTotal()` também salva o valor no banco, isso é um efeito colateral ruim (side-effect). Separe a lógica.

---

## 3. Segurança Defensiva e Casos de Borda
*   **Sanitização de Inputs:** Sempre trate dados fornecidos pelo usuário externo (inputs de formulário, parâmetros de URL) como potencialmente maliciosos. Aplique escape, sanitização ou validação rigorosa de tipo.
*   **Fail-Fast (Falha Rápida):** Valide a existência de dependências e variáveis de ambiente cruciais logo na inicialização. Nunca execute lógica de negócios se os pré-requisitos estiverem corrompidos ou ausentes.
*   **Tratamento de Exceções Sem Silenciamento:** Nunca utilize blocos `try-catch` vazios. Se um erro for capturado, ele deve ser devidamente tratado, logado ou relançado. Silenciar erros dificulta o diagnóstico em produção.

---

## 4. Estrutura de Testes Associados
*   **Isolamento de Testes:** Garanta que testes unitários não dependam de conexões reais de rede ou estado compartilhado de banco de dados. Utilize stubs/mocks de forma limpa.
*   **Nomeação de Cenários:** O nome do caso de teste deve descrever claramente: o cenário sob teste, a ação realizada e o resultado esperado (ex: `shouldReturnErrorWhenApiTokenIsMissing`).
