program estatistica
    use calculo_est
        use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64, i4=>int32
    implicit none
    !!!!!!!!!!Declaração das variáveis!!!!!!!!!!! 
    !Variáveis auxiliares
    integer(kind=i4) :: arquivo, i
    integer(kind=i4) :: N

    !Pares de pontos e medias
    real(kind=dp), allocatable :: x(:),y(:)
    
    !Pares de pontos e medias
    real(kind=dp) :: media_x, media_y, soma_x, soma_y
    
    !Vairancias, desvios padrão e coeficiente de correlação
    real(kind=dp) :: S_x, S_y, desvio_x, desvio_y, r_xy
    
    open(newunit=arquivo, file="dados.dat", action="read")

    !Conta o número de linhas do arquivo
    N = 0
    do
        read(arquivo, *, iostat=i)
        if ( i/=0 ) exit
            N = N + 1
    end do
    close(arquivo)

    !Aloca nos pares de varáveis a quantidades de ponto
    allocate(x(1:N),y(1:N))

    open(newunit=arquivo, file="dados.dat", action="read")
    
    soma_x = 0.0_dp
    soma_y = 0.0_dp
    !Le os pontos x e y do arquivo dados.dat
    do i = 1, N
       read(arquivo, *) x(i), y(i)
    end do
    close(arquivo)

    media_x = soma_termos(x,N)/N   
    media_y = soma_termos(y,N)/N
    S_x = SQD(x,N)/N-1
    S_y = SQD(y,N)/N-1
    desvio_x = (S_x)**0.5_dp
    desvio_y = (S_y)**0.5_dp

    !Calculo do coeficiente de correlação (Pearson)
    r_xy = SPD_xy(x,y,N)/(SQD(x,N)*SQD(y,N))**0.5_dp

    !if ( r_xy ) then
        
    !end if
   !!!!!!!!!Programa principal!!!!!!!!!!!!!

print*, "A media de x é:", media_x
print*, "A media de y é:", media_y
print*, "A variância de x é:", S_x
print*, "A variância de y é:", S_y
print*, "O desvio padrão de x é:", desvio_x
print*, "O desvio padrão de y é:", desvio_y
print*, "O coeficiente de Pearson é:", r_xy


end program estatistica