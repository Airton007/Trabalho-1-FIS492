module est_basic_mod
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64, i4=>int32
    implicit none

contains
    
    ! Subrotina para o cálculo do Coeficiente de correlação (Pearson)
    subroutine coef_pearson_xy(x,y,N,r_xy)
        integer(kind=i4), intent(in) :: N
        real(kind=dp), intent(in) :: x(1:N), y(1:N)
        real(kind=dp), intent(out) :: r_xy
        r_xy = SPD_xy(x, y, N) / sqrt(SQD(x, N) * SQD(y, N))
    end subroutine

        ! Subrotina para o cálculo do Coeficiente de Variação
    subroutine coef_var(x,N, desvio, Cv)
        integer(kind=i4), intent(in) :: N
        real(kind=dp), intent(in) :: x(1:N)
        real(kind=dp), intent(in) :: desvio
        real(kind=dp), intent(out) :: Cv

        Cv = (desvio/(sum(x)/N))* 100.0_dp
    end subroutine

    ! Função para o cálculo da soma dos quadrados dos desvios (SQD)
    function SQD(x, N) result(res)
        integer(kind=i4), intent(in) :: N
        real(kind=dp), intent(in) :: x(1:N)
        real(kind=dp) :: res, media_x
        media_x = sum(x) / N*1.0_dp
        res = sum((x - media_x)**2.0_dp)
    end function SQD

    ! Função para a soma dos produtos dos desvios (SPD_x)
    function SPD(x, N) result(res)
        integer(kind=i4), intent(in) :: N
        real(kind=dp), intent(in) :: x(1:N)
        real(kind=dp) :: res, media_x
        media_x = sum(x) / N*1.0_dp
        res = sum((x - media_x)**2.0_dp)
    end function SPD

    ! Função para a soma dos produtos dos desvios entre dois vetores (SPD_xy)
    function SPD_xy(x, y, N) result(res)
        integer(kind=i4), intent(in) :: N
        real(kind=dp), intent(in) :: x(1:N), y(1:N)
        real(kind=dp) :: res, media_x, media_y
        media_x = sum(x) / N*1.0_dp
        media_y = sum(y) / N*1.0_dp
        res = sum((x - media_x) * (y - media_y))
    end function SPD_xy

end module est_basic_mod
