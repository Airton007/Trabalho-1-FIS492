# Estatísticas e Gerador de Números Aleatórios com Fortran

Este programa é uma aplicação que realiza cálculos estatísticos básicos sobre pares de valores `(x, y)` fornecidos manualmente, lidos de um arquivo ou gerados aleatoriamente. Ele utiliza módulos para funções estatísticas (`est_basic_mod`) e para geração de números pseudoaleatórios (`rndgen_mod`).

---

## Funcionalidades

1. **Modos de Operação**:
   - **Manual (S)**: O usuário insere manualmente os valores de `x` e `y`.
   - **Arquivo (N)**: Os valores são lidos de um arquivo (`dados.dat`).
   - **Aleatório (A)**: Os valores são gerados pseudoaleatoriamente.

2. **Cálculos Estatísticos**:
   - **Médias**: Calcula a média de `x` e `y`.
   - **Variâncias**: Determina a variância de `x` e `y`.
   - **Desvios Padrão**: Calcula os desvios padrão de `x` e `y`.
   - **Coeficiente de Correlação (Pearson)**: Avalia a correlação linear entre `x` e `y`.

3. **Geração de Números Aleatórios**:
   - Utiliza o gerador **KISS05** (Keep It Simple Stupid), baseado em um algoritmo eficiente e de alta periodicidade.
   - Os números podem ser ajustados para um intervalo específico, como `[100, 1000]`.

---

## Estrutura do Programa

### 1. Declaração de Módulos
- `est_basic_mod`: Funções para cálculo de médias, variâncias, desvios padrão e coeficiente de Pearson.
- `rndgen_mod`: Classe para geradores pseudoaleatórios, baseada no KISS05.

### 2. Fluxo de Execução
- Solicita ao usuário o modo de operação (`S`, `N` ou `A`).
- Realiza as seguintes operações, dependendo do modo:
  - **Manual**:
    - O usuário insere o número de pares `N` e os valores de `x` e `y`.
    - Os dados são salvos no arquivo `dados_manual.dat`.
  - **Arquivo**:
    - Lê os valores do arquivo `dados.dat`.
    - Conta o número de pares e aloca memória para os vetores.
  - **Aleatório**:
    - Gera `N` pares `(x, y)` pseudoaleatórios no intervalo especificado.
    - Os valores são salvos no arquivo `dados_pseudoaleatorios.dat`.

### 3. Estatísticas
- As estatísticas (média, variância, desvio padrão e correlação) são calculadas e exibidas para os pares `(x, y)`.


## Exemplo de Execução

### Modo Manual (S)
1. O usuário escolhe o número de pares `N`.
2. Insere os valores de `x` e `y` manualmente.
3. O programa calcula as estatísticas e salva os dados no arquivo `dados_manual.dat`.

### Modo Arquivo (N)
1. O programa lê os valores de `dados.dat`.
2. Calcula as estatísticas com os dados lidos.

### Modo Aleatório (A)
1. O usuário especifica `N` e as sementes para os geradores de `x` e `y`.
2. Os pares são gerados aleatoriamente e salvos em `dados_pseudoaleatorios.dat`.

---

## Histórico e Referências do Gerador KISS05

- Desenvolvido com base na sugestão de George Marsaglia no grupo **sci.crypt.random-numbers** em 1999.
- Implementação Fortran criada por Thomas Vojta.
- Algoritmo e teoria detalhados em:
  - Grupo de discussão **sci.math.num-analysis**, novembro de 2005.

---

## Licença
Este código é distribuído para fins educacionais e científicos, com base nas implementações compartilhadas por Thomas Vojta e a comunidade Fortran.
