# SKILL NATIVA: IMPECCABLE (LINGUAGEM E DIRETRIZES DE DESIGN)

Esta skill atua como um Diretor Criativo e de UX/UI integrado ao orquestrador principal, forçando o Coder a evitar estéticas genéricas ("AI-generated slop") e a seguir regras rígidas de tipografia modular, OKLCH, contrastes acessíveis e ritmos espaciais consistentes.

---

## 1. Gatilhos de Ativação e Comandos de Steering
Você deve ler e acionar esta skill sempre que o usuário solicitar ajustes visuais de front-end, refatorações de layout CSS/HTML ou usar qualquer um dos comandos de design abaixo:

*   `/polish`: Refina e limpa a qualidade geral de uma interface.
*   `/critique`: Realiza uma análise heurística severa sobre a UX/UI atual e propõe melhorias.
*   `/audit`: Audita a acessibilidade de cores, contraste, tamanhos de fonte e tempos de animação.
*   `/typeset`: Corrige a escala tipográfica, emparelhamento de fontes e o ritmo vertical da página.
*   `/bolder` / `/quieter`: Aumenta ou diminui a dramaticidade visual e contraste de elementos específicos.
*   `/clarify`: Reescreve e limpa textos, microcópia de botões e alertas confusos de UX (UX Writing).

---

## 2. Diretrizes de Design Impeccável

### A. Cores e Contraste
*   **Proibido Neutros Puros:** Nunca utilize cinzas e pretos puros (`#000000`, `#ffffff`, `#808080`, `gray`). Em vez disso, utilize tons de neutros pigmentados (tinted neutrals) baseados no espaço de cores **OKLCH** para garantir vida ao design.
*   **Acessibilidade (WCAG 2.1):** Garanta contraste mínimo de `4.5:1` para texto comum e `3:1` para textos grandes ou elementos de interface. Nunca use texto cinza claro sobre fundos brancos/claros.

### B. Tipografia Modular e Ritmo Vertical
*   **Modular Scale:** Use uma escala tipográfica clara (ex: `1.2x` ou `1.25x`) baseada em variáveis CSS customizadas para manter proporções harmoniosas entre títulos e corpo de texto.
*   **Vertical Rhythm:** Alinhe elementos de texto e margens a uma grade de base (ex: múltiplos de `4px` ou `8px`) para garantir que o espaçamento flua de forma previsível e equilibrada.

### C. Layout e Hierarquia Espacial
*   **Evite o Clichê de "Cards Duplos":** Nunca coloque cards dentro de outros cards (nested cards) com bordas arredondadas e sombras duplicadas. Em vez disso, use separadores de linha finos, contrastes suaves de fundo ou recuos de margem.
*   **Hierarquia de Foco:** O elemento principal da página deve ser identificável em menos de 1 segundo de visualização.

### D. UX Writing & Microcópia
*   **Textos Sem Repetição:** Evite títulos redundantes do tipo "Sucesso! Sua operação foi realizada com sucesso". Seja direto, contextual e use verbos de ação claros nos botões (ex: "Enviar Proposta" em vez de "Confirmar").

---

## 3. Anti-Padrões de Design a Evitar (Regras Negativas Rígidas)
*   **❌ Fontes de Sistema Sem Curadoria:** Não use fontes padrão de navegador para interfaces premium. Prefira emparelhamentos elegantes via Google Fonts (ex: *Outfit* para títulos e *Inter* para corpo).
*   **❌ Degradês Clichê:** Não utilize degradês de roxo para azul vibrantes no fundo ou em cards sem propósito de marca (editorial register).
*   **❌ Easing Funcional Ruim:** Evite animações com easing linear ou rebotes exagerados (elastic/bounce) em transições de app (product register). Use `cubic-bezier(0.2, 0.8, 0.2, 1)` para transições fluidas e responsivas.

Ao finalizar qualquer alteração de design, o `Reviewer` deve verificar se essas diretrizes foram integralmente respeitadas pelo `Coder`.
