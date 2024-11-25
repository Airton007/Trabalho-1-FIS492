module est_basic_mod
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64, i4=>int32
    implicit none


    type :: calculo_estatistica
        real(kind=dp), allocatable :: x(:), y(:)
        integer(kind=i4) :: N
    contains
    procedure :: inicializar            ! Inicializar os vetores e o tamanho N
    procedure :: ler_dados              ! Ler dados manualmente ou de arquivo
    procedure :: calcular_media         ! Calcular média
    procedure :: calcular_variancia     ! Calcular variância
    procedure :: calcular_desvio_padrao ! Calcular desvio padrão
    procedure :: coeficiente_pearson    ! Coeficiente de correlação (Pearson)
    procedure :: coeficiente_var        ! Coeficiente de Variação
    end type

contains

subroutine inicializar(est, N)
    class(calculo_estatistica), intent(inout) :: est
    integer(kind=i4), intent(in) :: N
    est%N = N
    allocate(est%x(N), est%y(N))
    
end subroutine

subroutine ler_dados(est, modo, nome_arquivo)
    class(calculo_estatistica), intent(inout) :: est
    character(len=*), intent(in) :: modo
    character(len=*), intent(in), optional :: nome_arquivo
    integer(kind=i4) :: i, arquivo

    if (modo == "manual") then
        write(*,*) "Digite os valores de x e y:"
        do i = 1, est%N
            write(*,'(A,I0,A)') "Digite o valor de x(", i, "): "
            read(*,*) est%x(i)
            write(*,'(A,I0,A)') "Digite o valor de y(", i, "): "
            read(*,*) est%y(i)
        end do
    else if (modo == "arquivo".and. present(nome_arquivo)) then
        open(newunit=arquivo, file=nome_arquivo, action="read")
        ! Conta o número de linhas no arquivo
        est%N = 0
        do
            read(arquivo, *, iostat=i)
            if (i /= 0) exit
            est%N = est%N + 1
        end do
        close(arquivo)

        call inicializar(est, est%N)

        ! Reabre o arquivo para ler os valores
        open(newunit=arquivo, file=nome_arquivo, action="read", status="old")
        do i = 1, est%N
            read(arquivo, *) est%x(i), est%y(i)  ! Lê os valores do arquivo
        end do
        close(arquivo)
    end if
end subroutine
    
    ! Subrotina para o cálculo do Coeficiente de correlação (Pearson)
    subroutine coeficiente_pearson(est,r_xy)
        class(calculo_estatistica) :: est
        real(kind=dp) :: media_x, media_y, SQD_x, SQD_y, SPD_xy
        real(kind=dp), intent(out) :: r_xy
        media_x = calcular_media(est, est%x)
        media_y = calcular_media(est, est%y)
        SQD_x = sum((est%x - media_x)**2.0_dp)
        SQD_y = sum((est%y - media_y)**2.0_dp)
        SPD_xy = sum((est%x - media_x) * (est%y - media_y))
        r_xy = SPD_xy / sqrt(SQD_x * SQD_y)
    end subroutine

    ! Subrotina para o cálculo do Coeficiente de Variação
    subroutine coeficiente_var(est,vetor,desvio,cv)
        class(calculo_estatistica) :: est
        real(kind=dp), intent(in) :: vetor(:), desvio
        real(kind=dp), intent(out) :: Cv
        cv = (desvio / calcular_media(est, vetor)) * 100.0_dp
    end subroutine

    ! Função para o cálculo da média
    function calcular_media(est,vetor) result(res)
        class(calculo_estatistica) :: est
        real(kind=dp), intent(in) :: vetor(:)
        real(kind=dp) :: res
        res = sum(vetor)/size(vetor)
    end function

    ! Função para o cálculo da variância
    function calcular_variancia(est,vetor) result(res)
        class(calculo_estatistica) :: est
        real(kind=dp), intent(in) :: vetor(:)
        real(kind=dp) :: res
        res = sum((vetor-calcular_media(est,vetor))**2.0_dp)/size(vetor-1)
    end function

    ! Função para o cálculo de desvio padrão
    function calcular_desvio_padrao(est,vetor) result(res)
        class(calculo_estatistica) :: est
        real(kind=dp),intent(in) :: vetor(:)
        real(kind=dp) :: res
        res = sqrt(calcular_variancia(est,vetor))
    end function

end module est_basic_mod