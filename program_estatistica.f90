program estatistica
    use est_basic_mod  ! Importa o módulo com funções estatísticas básicas
    implicit none

    ! Declaração das variáveis
    type(calculo_estatistica) :: est
    integer(kind=i4) :: N                               ! Tamanho do vetor ou número total de amostras
    character(len=100) :: modo                          ! Escolha do modo de operação (manual"S" ou arquivo "N")
    real(kind=dp) :: media_x, media_y                   ! Variáveis para médias
    real(kind=dp) :: var_x, var_y, desvio_x, desvio_y   ! Variáveis para variâncias, desvios padrão
    real(kind=dp) :: r_xy, cv_x, cv_y                   ! Variáveias para coeficiente de correlação (Pearson) e coeficientes de variação

    ! Solicita ao usuário o modo de operação
    write(*,*)"Digite ""manual"" se deseja escrever os valores manualmente ou & 
    ""arquivo"" se deseja usar um arquido do tipo .dat"
    read(*,*) modo

    if (modo == "manual") then
        ! Escolha do modo de operação
        write(*,*) "Digite o número de termos ""N"" "
        read(*,*) N
        call est%inicializar(N)
        call est%ler_dados("manual")
    else if (modo == "arquivo") then
        call est%ler_dados("arquivo","dados.dat")
    end if
    
     ! Cálculos estatísticos
    media_x = est%calcular_media(est%x)
    media_y = est%calcular_media(est%y)
    print*, "Médias e x:", media_x
    print*, "Médias e y:", media_y

    var_x = est%calcular_variancia(est%x)
    var_y = est%calcular_variancia(est%y)
    print*, "Variâncias de x:", var_x
    print*, "Variâncias de y:", var_y

    desvio_x = est%calcular_desvio_padrao(est%x)
    desvio_y = est%calcular_desvio_padrao(est%y)
    print*, "Desvios padrão de x", desvio_x 
    print*, "Desvios padrão de y", desvio_y 

    call est%coeficiente_pearson(r_xy)
    print*, "Coeficiente de Pearson:", r_xy

    call est%coeficiente_var(est%x, desvio_x, cv_x)
    call est%coeficiente_var(est%y, desvio_y, cv_y)
    print*, "Coeficiente de Variação de x", cv_x
    print*, "Coeficiente de Variação de y", cv_y

end program estatistica