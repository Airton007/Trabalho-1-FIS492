program estatistica
    use est_basic_mod  ! Importa o módulo com funções estatísticas básicas
    use rndgen_mod     ! Importa o módulo para geração de números aleatórios
    use, intrinsic :: iso_fortran_env, only: sp => real32, dp => real64, i4 => int32
    implicit none

    ! Declaração das variáveis
    integer(kind=i4) :: arquivo, arquivo2, i, k   ! Variáveis para controle de arquivos e loops
    integer(kind=i4) :: N                         ! Número de pontos (pares x e y)
    character(len=100) :: escolha                 ! Escolha do modo de operação (manual, arquivo ou aleatório)

    ! Vetores para os pares de valores (x, y)
    real(kind=dp), allocatable :: x(:), y(:)

    ! Variáveis para médias
    real(kind=dp) :: media_x, media_y
    
    ! Variáveis para variâncias, desvios padrão e coeficiente de correlação
    real(kind=dp) :: S_x, S_y, desvio_x, desvio_y, r_xy, Cv_x, Cv_y
    
    ! Variáveis e geradores para números pseudoaleatórios
    integer(kind=i4) :: seed1, seed2
    type(rndgen) :: gerador1, gerador2

    ! Solicita ao usuário o modo de operação
    write(*,*)"Digite ""S"" se deseja escrever os valores manualmente, ""N"" se deseja usar um arquido &
    do tipo .dat ou ""A"" se deseja que os pares sejam gerados aleatoriamente"
    read(*,*) escolha
    
    ! Condicional para o modo manual
    if (escolha == "S" .or. escolha == "s") then
        write(*,*) "Escreva o número de termos ""N"" "
        read(*,*) N

        allocate(x(N), y(N))  ! Aloca memória para os vetores x e y

        write(*, *) "Escreva os pares de valores x e y(x)"
    
        ! Abre arquivo para salvar os dados inseridos manualmente
        open(newunit=arquivo, file="dados_manual.dat", action="write", status="replace")

        do i = 1, N
            ! Solicita ao usuário os valores de x e y
            write(*,'(A,I0,A)') "Digite o valor de x(", i, "): "
            read(*,*) x(i)
            write(*,'(A,I0,A)') "Digite o valor de y(", i, "): "
            read(*,*) y(i)

            ! Salva os pares no arquivo
            write(arquivo, *) x(i), y(i)
        end do
        close(arquivo)

    ! Condicional para o modo de leitura de arquivo
    else if (escolha == "N" .or. escolha == "n") then
        open(newunit=arquivo, file="dados.dat", action="read")  ! Abre o arquivo de dados
        
        ! Conta o número de linhas no arquivo
        N = 0
        do
            read(arquivo, *, iostat=i)
            if (i /= 0) exit
            N = N + 1
        end do
        close(arquivo)

        allocate(x(1:N), y(1:N))  ! Aloca memória com base no número de pares

        open(newunit=arquivo, file="dados.dat", action="read")
        do i = 1, N
            read(arquivo, *) x(i), y(i)  ! Lê os valores do arquivo
        end do
        close(arquivo)

    ! Condicional para o modo de geração aleatória
    else if (escolha == "A" .or. escolha == "a") then
        write(*,*) "Escreva o número de termos ""N"" "
        read(*,*) N    
        
        write(*,*) "Escreva a primeira semente, para os valores de x, qualquer número entre 1-100"
        read(*,*) seed1    
        
        write(*,*) "Escreva a segunda semente, para os valores de y, qualquer número entre 1-100"
        read(*,*) seed2    

        call gerador1%init(seed1)  ! Inicializa o gerador para x
        call gerador2%init(seed2)  ! Inicializa o gerador para y

        open(newunit=arquivo2, file="dados_pseudoaleatorios.dat", action="write")
        
        allocate(x(N), y(N))
        do k = 1, N
            x(k) = gerador1%real(real(10, kind=dp), real(100, kind=dp))
            y(k) = gerador2%real(real(10, kind=dp), real(100, kind=dp))            
            write(arquivo2, *) x(k), y(k)  ! Salva os valores gerados
        end do
        close(arquivo2)
    end if

    ! Calcula e exibe as estatísticas
    media_x = sum(x)/N  
    media_y = sum(y)/N
    print*, "A media de x é:", media_x
    print*, "A media de y é:", media_y

    S_x = SQD(x,N)/(N-1)
    S_y = SQD(y,N)/(N-1)
    print*, "A variância de x é:", S_x
    print*, "A variância de y é:", S_y

    desvio_x = sqrt(S_x)
    desvio_y = sqrt(S_y)
    print*, "O desvio padrão de x é:", desvio_x
    print*, "O desvio padrão de y é:", desvio_y

    call coef_pearson_xy(x,y,N,r_xy)
    print*, "O coeficiente de Pearson é:", r_xy

    call coef_var(x,N,desvio_x, Cv_x)
    print*, "O coeficiente de Variação é:", Cv_x

    call coef_var(y,N,desvio_y, Cv_y)
    print*, "O coeficiente de Variação é:", Cv_y

end program estatistica
