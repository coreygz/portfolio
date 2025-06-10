!Corey Zhang
!Use finite difference method to solve
!y''=-2/xy'+2/x^2y+sin(lnx)/x^2,for 1<x<2 with y(1)=1 and y(2)=2
!And calls Crout Factorization method to solving tridiagonal linear system
!And Jacobi Method

Program BVP_Solver


integer,parameter::N=79
real::h,alpha,beta,p,q,r,x,lb,ub,l2
real,dimension(N)::a,b,c,d
real,dimension(0:N+1)::y


! interval lb<x<ub, y(lb)=alpha, y(ub)= beta
lb = 1.0
ub = 2.0
alpha = 1.0
beta = 2.0

h=(ub-lb)/(N+1.0)

!exact solution
do i = 0 , N+1
    x= lb + i*h
    y(i) = 1.139207*x+(-0.039207)/x**2&
    -3.0/10*sin(log(x))-(1.0/10)*cos(log(x))
end do	

!step 1
x=lb+h*1.0
a(1) = 2.0+h**2.0*q(x)
b(1) = -1.0 + (h/2.0)*p(x)
d(1) = - h**2.0*r(x)+(1.0+(h/2.0)*p(x))*alpha

!step 2
do i=2,N-1
   x = lb + i*h*1.0
   a(i) = 2.0+h**2.0*q(x)
   b(i) = -1.0 + (h/2)*p(x)
   c(i) = -1.0 - (h/2)*p(x)
   d(i) = - h**2.0*r(x)
end do   

!step 3
x=ub-h
a(N)=2.0+h**2.0*q(x)
c(N)=-1.0-(h/2.0)*p(x)
d(N)=-h**2.0*r(x)+(1.0-(h/2.0)*p(x))*beta
  
!step 4-8
print*,"   xi        wi            y(xi)"
call crout(a,b,c,d,N,alpha,beta,lb,h,y)
call jacobi(a,b,c,d,N,alpha,beta,lb,h,y)


Contains
! Solve tridiagonal system using Crout method
   subroutine crout(a,b,c,d,N,alpha,beta,lb,h,y)
      integer,intent(in)::N
      real,intent(in)::a(n),b(n),c(n),d(n),y(0:n+1),h,alpha,beta,lb
      real,dimension(N)::l,u,z
      real,dimension(0:N+1)::w
      real::r2=1
   !step 4
         l(1) = a(1)*1.0
         u(1) = b(1)/a(1)*1.0
         z(1) = d(1)/l(1)*1.0
   !step 5
      do i=2,N-1
         l(i)=a(i)-c(i)*u(i-1)*1.0
         u(i)=b(i)/l(i)*1.0
         z(i)=(d(i)-c(i)*z(i-1))/l(i)*1.0
         
         
      end do   
   !step 6   
      l(N)=a(N)-c(N)*u(N-1)*1.0
      z(N) = (d(N)-c(n)*z(n-1))/l(n)*1.0
      
   !step 7   
      w(0) = alpha
      w(N+1) = beta
      w(N) = z(N)
      
   !step 8  
      do i = N-1,1,-1
         w(i)=z(i)-u(i)*w(i+1)*1.0
         
      end do
      
      do i = 0,N+1  
         !print*, lb+i*h,w(i)
         print'(F6.1,5x,F9.6,5x,F9.6)',lb+i*h,w(i),y(i)
      end do   
         call l2error(w,y,n,r2)
         print*,"Using Crout Method r2 error = ",r2
   end subroutine

! Solve tridiagonal system using Jacobi method
    subroutine jacobi(a,b,c,d,N,alpha,beta,lb,h,y)
      integer,intent(in)::N
      real,intent(in)::a(n),b(n),c(n),d(n),y(0:n+1),h,alpha,beta,lb
      real,dimension(N)::l,u,z
      real,dimension(0:N+1)::w,wp
      real::r2 = 1,tol=3.54E-05
      w(0)=alpha
      w(N+1)=beta
      wp = w
      do i = 1,n
         w(i)= 0
      end do     
      
      
      wp(1)= -b(1)/a(1)*w(2)+d(1)/a(1)
      do while (r2 > tol .and. counter < 5000)
      do i = 1,N
         wp(i) = -c(i)/a(i)*w(i-1)-b(i)/a(i)*w(i+1)+d(i)/a(i)
      wp(n) = -c(n)/a(n)*w(n-1)+d(n)/a(n)
      end do
      call l2error(w,wp,n,r2)
      w = wp
      end do
      
	!print Results      
      do i = 0,N+1  
         !print*, lb+i*h,w(i)
         
         print'(F6.1,5x,F9.6,5x,F9.6)',lb+i*h,w(i),y(i)
      end do   
         call l2error(w,y,n,r2)
         print*,"using Jacobi method r2 error = ",r2      
      
   end subroutine

! Calculate L2 error between w and y
   subroutine l2error(v1,v2,n,r2)
      real,intent(in)::v1(0:n+1),v2(0:n+1)
      real,intent(inout)::r2
      total = 0
      do i = 1,n-1
         total = total + (abs(v1(i)-v2(i)))**2
      end do     
      r2=sqrt(total/(N-1))
      
   end subroutine

End Program BVP_Solver

function p(x)
    real:: x,p
    p = -2.0/x
    return
end

function q(x)
    real:: x,q
    q = 2.0/x**2.0
    return
end
    
function r(x)
    real:: x,r
    r = sin(log(x))/x**2.0
    return
end
 