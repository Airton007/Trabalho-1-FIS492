module est_basic_mod
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64, i4=>int32
    implicit none

contains
    ! Função para a soma dos termos
    function soma_termos(x, N) result(res)
        integer(kind=i4), intent(in) :: N
        real(kind=dp), intent(in) :: x(1:N)
        real(kind=dp) :: res
        res = sum(x)
    end function soma_termos

    ! Função para a média dos termos
    function media(x, N) result(res)
        integer(kind=i4), intent(in) :: N
        real(kind=dp), intent(in) :: x(1:N)
        real(kind=dp) :: res
        res = sum(x) / N*1.0_dp
    end function media

    ! Função para o cálculo da soma dos quadrados dos desvios (SQD)
    function SQD(x, N) result(res)
        integer(kind=i4), intent(in) :: N
        real(kind=dp), intent(in) :: x(1:N)
        real(kind=dp) :: res, media_x
        media_x = media(x, N)
        res = sum((x - media_x)**2.0_dp)
    end function SQD

    ! Função para a soma dos produtos dos desvios (SPD_x)
    function SPD(x, N) result(res)
        integer(kind=i4), intent(in) :: N
        real(kind=dp), intent(in) :: x(1:N)
        real(kind=dp) :: res, media_x
        media_x = media(x, N)
        res = sum((x - media_x)**2.0_dp)
    end function SPD

    ! Função para a soma dos produtos dos desvios entre dois vetores (SPD_xy)
    function SPD_xy(x, y, N) result(res)
        integer(kind=i4), intent(in) :: N
        real(kind=dp), intent(in) :: x(1:N), y(1:N)
        real(kind=dp) :: res, media_x, media_y
        media_x = media(x, N)
        media_y = media(y, N)
        res = sum((x - media_x) * (y - media_y))
    end function SPD_xy

end module est_basic_mod
