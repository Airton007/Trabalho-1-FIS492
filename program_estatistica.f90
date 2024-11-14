program estatistica
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

end program estatistica