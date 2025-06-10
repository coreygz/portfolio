program jacobi
! Corey Zhang
! Calculate the systems of equations 
! 4x_1-x_2+x_3=8,2x_1+5x_2+2x_3=3,x_1+2x_2+4x_3=11 
! tolerance 10^-5
implicit none

integer, parameter :: n = 3 ! number of equations
real, dimension(n) :: x, x_old, b ! unknowns, previous approximation, and right-hand side
real, dimension(n,n) :: a ! coefficient matrix
real, parameter :: tol = 1.0E-5 ! tolerance
integer :: iter, i, j ! iteration counters
logical :: converged ! convergence flag
real :: diff_norm ! difference between two consecutive approximations
real :: l_inf_norm ! L-infinity norm of the vector difference

! initialize the coefficient matrix and right-hand side
a(1,1) = 4.0
a(1,2) = -1.0
a(1,3) = 1.0
a(2,1) = 2.0
a(2,2) = 5.0
a(2,3) = 2.0
a(3,1) = 1.0
a(3,2) = 2.0
a(3,3) = 4.0
b = [8,3,11]

! initialize the unknowns and previous approximation
x = [0,0,0]
x_old = [0,0,0]

! begin iteration
iter = 0
converged = .false.
do while (.not. converged)
    ! update the previous approximation
    x_old = x
    iter = iter + 1

    ! perform one Jacobi iteration
    do i = 1, n
        x(i) = b(i)
        do j = 1, n
            if (i /= j) then
                x(i) = x(i) - a(i,j)*x_old(j)
            end if
        end do
        x(i) = x(i) / a(i,i)
    end do

    ! check for convergence
    if (iter > 1) then
        diff_norm = 0.0
        do i = 1, n
            diff_norm = diff_norm + abs(x(i) - x_old(i))
        end do
        l_inf_norm = diff_norm
        if (l_inf_norm <= tol) then
            converged = .true.
        end if
    end if
end do

! print the final solution and number of iterations
print *, "Solution after ", iter, " iterations:"
do i = 1, n
    print *, "x(", i, ") = ", x(i)
end do

end program jacobi
