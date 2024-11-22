program estatistica
    use est_basic_mod
    use rndgen_mod
        use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64, i4=>int32
    implicit none

    !!!!!!!!!!Declaração das variáveis!!!!!!!!!!! 
    !Variáveis auxiliares
    integer(kind=i4) :: arquivo, i
    integer(kind=i4) :: N
    character(len=100) :: escolha
    !Pares de pontos e medias
    real(kind=dp), allocatable :: x(:),y(:)

    !Pares de pontos e medias
    real(kind=dp) :: media_x, media_y, soma_x, soma_y
    
    !Vairancias, desvios padrão e coeficiente de correlação
    real(kind=dp) :: S_x, S_y, desvio_x, desvio_y, r_xy
    
    write(*,*)"Digite ""S"" se deseja escrever os valores manualmente ou ""N"" &
                se deseja usar um arquido do tipo .dat "
    read(*,*) escolha

    if (escolha == "S" .or. escolha == "s") then
   
        Write(*,*) "Escreva o número de termos ""N"" "
        read(*,*) N

        allocate(x(N), y(N))

        write(*, *) "Escreva os pares de valores x e y(x)"
    
        open(newunit=arquivo, file="dados_testes.dat", action="write", status="replace")

        do i=1, N
            write(*,'(A,I0,A)') "Digite o valor de x(",i, "): "
            read(*,*) x(i)

            write(*,'(A,I0,A)') "Digite o valor de y(",i, "): "
            read(*,*) y(i)

            ! Escrever os pares no arquivo
            write(arquivo,*) x(i), y(i)
        end do
        close(arquivo)

    else if (escolha == "N" .or. escolha == "n") then

            !Conta o número de linhas do arquivo
            N = 0
            do
                read(arquivo, *, iostat=i) !"iostat" retorna o status da leitura dos dados. Caso exista i = 0 caso não i/=0
                   if ( i/=0 ) exit
                   N = N + 1
            end do
            close(arquivo)
            
            !Aloca nos pares de varáveis a quantidades de ponto
            allocate(x(1:N),y(1:N))    
        
            soma_x = 0.0_dp
            soma_y = 0.0_dp
        
            open(newunit=arquivo, file="dados.dat", action="read")
            
            !Le os pontos x e y do arquivo dados.dat
            do i = 1, N
               read(arquivo, *) x(i), y(i)
            end do
            close(arquivo)
    end if

    !Cálculo das médias
    media_x = media(x,N)  
    media_y = media(y,N)
    print*, "A media de x é:", media_x
    print*, "A media de y é:", media_y

    !Cálculo das variâncias
    S_x = SQD(x,N)/(N-1)
    S_y = SQD(y,N)/(N-1)
    print*, "A variância de x é:", S_x
    print*, "A variância de y é:", S_y

    !Cálculo dos desvios
    desvio_x = sqrt(S_x)
    desvio_y = sqrt(S_y)
    print*, "O desvio padrão de x é:", desvio_x
    print*, "O desvio padrão de y é:", desvio_y

    !Cálculo do coeficiente de correlação (Pearson)
    r_xy = SPD_xy(x,y,N)/sqrt(SQD(x,N)*SQD(y,N))
    print*, "O coeficiente de Pearson é:", r_xy

deallocate(x, y)

end program estatistica