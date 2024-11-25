
# Estatísticas Básicas em Fortran

Este programa é uma aplicação desenvolvida em Fortran que realiza cálculos estatísticos básicos sobre pares de valores `(x, y)`. Ele suporta entrada manual ou leitura de arquivo de dados. O módulo principal (`est_basic_mod`) encapsula funcionalidades para cálculos estatísticos.

---

## Funcionalidades

1. **Modos de Operação**:
   - **Manual (`manual`)**: O usuário insere manualmente os valores de `x` e `y`.
   - **Arquivo (`arquivo`)**: Os valores são lidos de um arquivo (`dados.dat`).

2. **Cálculos Estatísticos**:
   - Média de `x` e `y`.
   - Variância de `x` e `y`.
   - Desvio padrão de `x` e `y`.
   - Coeficiente de correlação de Pearson entre `x` e `y`.
   - Coeficiente de variação de `x` e `y`.

---

## Estrutura do Programa

O programa utiliza o módulo `est_basic_mod` para encapsular as operações de cálculo. Este módulo inclui as seguintes subrotinas e funções:

- **Subrotina `inicializar`**: Aloca memória para os vetores `x` e `y`.
- **Subrotina `ler_dados`**: Lê dados de entrada manualmente ou de arquivo.
- **Função `calcular_media`**: Retorna a média de um vetor.
- **Função `calcular_variancia`**: Calcula a variância de um vetor.
- **Função `calcular_desvio_padrao`**: Calcula o desvio padrão de um vetor.
- **Subrotina `coeficiente_pearson`**: Calcula o coeficiente de correlação de Pearson.
- **Subrotina `coeficiente_var`**: Calcula o coeficiente de variação.

---

## Exemplo de Execução

### 1. Modo Manual
Neste modo, o usuário insere os valores manualmente.

#### Exemplo de Código:
```fortran
program exemplo_manual
    use est_basic_mod
    implicit none

    type(calculo_estatistica) :: est
    integer :: N
    real(dp) :: r_xy

    write(*,*) "Digite o número de pares (N): "
    read(*,*) N
    call inicializar(est, N)
    call ler_dados(est, "manual")

    ! Calcular coeficiente de correlação de Pearson
    call coeficiente_pearson(est, r_xy)
    write(*,*) "Coeficiente de correlação (Pearson): ", r_xy
end program exemplo_manual
```

#### Saída Esperada:
```
Digite o número de pares (N):
3
Digite os valores de x e y:
Digite o valor de x(1): 
1.0
Digite o valor de y(1): 
2.0
Digite o valor de x(2): 
3.0
Digite o valor de y(2): 
4.0
Digite o valor de x(3): 
5.0
Digite o valor de y(3): 
6.0
Coeficiente de correlação (Pearson): 1.00000000000000
```

---

### 2. Modo Arquivo
Os dados são lidos de um arquivo (`dados.dat`).

#### Formato de Arquivo (`dados.dat`):
```
1.0 2.0
3.0 4.0
5.0 6.0
```

#### Exemplo de Código:
```fortran
program exemplo_arquivo
    use est_basic_mod
    implicit none

    type(calculo_estatistica) :: est
    real(dp) :: r_xy

    ! Ler dados de arquivo
    call ler_dados(est, "arquivo", "dados.dat")

    ! Calcular coeficiente de correlação de Pearson
    call coeficiente_pearson(est, r_xy)
    write(*,*) "Coeficiente de correlação (Pearson): ", r_xy
end program exemplo_arquivo
```

#### Saída Esperada:
```
Coeficiente de correlação (Pearson): 1.00000000000000
```

---

## Histórico

- **Base Teórica**: Inspirado em técnicas de análise estatística básica e na estruturação de programas modulares em Fortran.
- **Implementação**: Construído com foco na simplicidade e clareza, para aplicações educacionais e científicas.

---

## Licença

Este código é licenciado sob a **Apache License 2.0**. Consulte o arquivo `LICENSE` para mais detalhes.
