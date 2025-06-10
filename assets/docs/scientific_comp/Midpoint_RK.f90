program ivp_solver
!Corey Zhang
!uses both the midpoint method and fourth-order Runge-Kutta method to solve the initial value problem (IVP)
!y' = y - t^2 + 1, 0 <= t <= 2, y(0) = 0.5
!and compare the solution to the exact solution y=(t+1)^2-0.5e^t  prints a table of the computed values
  
    implicit none
    real(kind=4)::tnow,dt,y1,y2,actual,error1,error2
    integer::i

    tnow = 0.0
    dt = 0.2
    y1 = 0.5
    y2 = 0.5
    
    do i = 0,9
        if (i == 0) then
            ! Print table header on first row
            write(*, '(A,F8.2,2X,A,F12.6,2X,A,F11.6,2X,A,F12.6,2X,A,F12.6)') &
    't', tnow, 'Midpt', y1, 'Err (M)', error1, 'RK4', y2, 'Err (RK4)', error2
        else
            call midpt(tnow,dt,y1)
            call rk4(tnow,dt,y2)
            tnow = tnow + dt
            actual = (tnow+1)**2-0.5*exp(tnow)
            error1 = abs(y1 - actual)
            error2 = abs(y2 - actual)
            
            ! Print table row
            write(*, '(F8.2,2X,F12.6,2X,F11.6,2X,F12.6,2X,F12.6)') &
                tnow, y1, error1, y2, error2
        end if
    end do

contains

    subroutine midpt(tnow,dt,y)
        implicit none
        real(kind=4), intent(inout)::tnow,dt,y
        real(kind=4)::k1,k2
        
        k1 = dt*(y - tnow**2 + 1.0)
        k2 = dt*((y + k1/2.0) - (tnow + dt/2.0)**2 + 1.0)
        
        y = y + k2
        
    end subroutine midpt

    subroutine rk4(tnow,dt,y)
        implicit none
        real(kind=4), intent(inout)::tnow,dt,y
        real(kind=4)::k1,k2,k3,k4
        
        k1 = dt*(y - tnow**2 + 1.0)
        k2 = dt*((y + k1/2.0) - (tnow + dt/2.0/2.0)**2 + 1.0)
        k3 = dt*((y + k2/2.0) - (tnow + dt/2.0/2.0)**2 + 1.0)
        k4 = dt*((y + k3) - (tnow + dt)**2 + 1.0)
        
        y = y + (k1 + 2.0*k2 + 2.0*k3 + k4)/6.0
        
    end subroutine rk4
    
end program ivp_solver
