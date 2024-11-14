module calculo_est
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64, i4=>int32
    implicit none
    
    !Somatoria dos termos
    contains
     function soma_termos(x,N) result(res)
        integer(kind=i4) :: i
        integer(kind=i4), intent(in) :: N
        real(kind=dp) :: soma, res
        real(kind=dp) :: x(1:N)
        soma = 0.0_dp
        do i = 1, N
            soma = soma + x(i)
        end do
        res = soma
     end function

    !Cálculo da Soma dos Quadrados dos desvios "SQD_x", onde x pode ser uma variável qualquer
    function SQD(x,N) result(res)
        integer(kind=i4) :: i
        integer(kind=i4), intent(in) :: N
        real(kind=dp) :: soma, res
        real(kind=dp) :: x(1:N)
        soma = 0.0_dp
        do i = 1, N
            soma = soma + (x(i) - soma_termos(x,N)/N)**2.0_dp
        end do
        res = soma 
    end function

    !Cálculo da Soma dos Produtos dos desvios "SPD_x"
    function SPD(x,N) result(res)
        integer(kind=i4) :: i
        integer(kind=i4), intent(in) :: N
        real(kind=dp) :: soma, res
        real(kind=dp) :: x(1:N)
        soma = 0.0_dp
        do i = 1, N
            soma = soma + (x(i) - soma_termos(x,N)/N)
        end do
        res = soma 
    end function

    !Cálculo da Soma dos Produtos dos desvios "SPD_xy", de x e y
    function SPD_xy(x,y,N) result(res)
        integer(kind=i4) :: i
        integer(kind=i4), intent(in) :: N
        real(kind=dp) :: soma, res
        real(kind=dp) :: x(1:N), y(1:N)
        soma = 0.0_dp
        do i = 1, N
            soma = soma + ((x(i) - soma_termos(x,N)/N)*(y(i) - soma_termos(y,N)/N))
        end do
        res = soma 
    end function

end module calculo_est
