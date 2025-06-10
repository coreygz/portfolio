
!Corey Zhang
!Use Jacobi and Grout Method solves the BVP problem
!Defection of the beam

Program Def_Beam
integer,parameter::N=119
real::h,alpha,beta,p,q,r,x,lb,ub,l2
real,dimension(N)::a,b,c,d
real,dimension(0:N+1)::cr,ja
real::c2


! interval lb<x<ub, y(lb)=alpha, y(ub)= beta
lb = 0
ub = 120
alpha = 0
beta = 0

h=(ub-lb)/(N+1.0)


!set up matrix A
x=lb+h*1.0
a(1) = 2.0+h**2.0*q(x)
b(1) = -1.0 + (h/2.0)*p(x)
d(1) = - h**2.0*r(x)+(1.0+(h/2.0)*p(x))*alpha


do i=2,N-1
   x = lb + i*h*1.0
   a(i) = 2.0+h**2.0*q(x)
   b(i) = -1.0 + (h/2)*p(x)
   c(i) = -1.0 - (h/2)*p(x)
   d(i) = - h**2.0*r(x)
end do   

x=ub-h
a(N)=2.0+h**2.0*q(x)
c(N)=-1.0-(h/2.0)*p(x)
d(N)=-h**2.0*r(x)+(1.0-(h/2.0)*p(x))*beta
  
!Solving Ax=b by calling different methods.

call crout(a,b,c,d,N,alpha,beta,lb,h,cr)
call jacobi(a,b,c,d,N,alpha,beta,lb,h,ja)
print*,"   x       crout method       jacob method"
      do i = 0,N+1  
           print'(F6.1,5x,F9.6,5x,F9.6)',lb+i*h,cr(i),ja(i)
      end do   



Contains

   subroutine crout(a,b,c,d,N,alpha,beta,lb,h,y)
      integer,intent(in)::N
      real,intent(in)::a(n),b(n),c(n),d(n),h,alpha,beta,lb
	  real,intent(inout)::y(0:n+1)
      real,dimension(N)::l,u,z
      real,dimension(0:N+1)::w
      real::r2=1
   !LU decomposition
         l(1) = a(1)*1.0
         u(1) = b(1)/a(1)*1.0
         z(1) = d(1)/l(1)*1.0
   !substitution
      do i=2,N-1
         l(i)=a(i)-c(i)*u(i-1)*1.0
         u(i)=b(i)/l(i)*1.0
         z(i)=(d(i)-c(i)*z(i-1))/l(i)*1.0
      end do   
    
      l(N)=a(N)-c(N)*u(N-1)*1.0
      z(N) = (d(N)-c(n)*z(n-1))/l(n)*1.0
      
    
      w(0) = alpha
      w(N+1) = beta
      w(N) = z(N)
      
      do i = N-1,1,-1
         w(i)=z(i)-u(i)*w(i+1)*1.0
         
      end do
         y=w


   end subroutine


    subroutine jacobi(a,b,c,d,N,alpha,beta,lb,h,y)
      integer,intent(in)::N
      real,intent(in)::a(n),b(n),c(n),d(n),h,alpha,beta,lb
	  real,intent(inout)::y(0:n+1)
      real,dimension(N)::l,u,z
      real,dimension(0:N+1)::w,wp
      real::r2 = 1,tol=3.54E-08
      w(0)=alpha
      w(N+1)=beta
      wp = w
      do i = 1,n
         w(i)= 0
      end do     
         y=w
      
      wp(1)= -b(1)/a(1)*w(2)+d(1)/a(1)
      do while (r2 > tol .and. counter < 5000)
      do i = 1,N
         wp(i) = -c(i)/a(i)*w(i-1)-b(i)/a(i)*w(i+1)+d(i)/a(i)
      wp(n) = -c(n)/a(n)*w(n-1)+d(n)/a(n)
      end do
      call l2error(w,wp,n,r2)
      w = wp
	  y=w
      end do
            

      
   end subroutine


   subroutine l2error(v1,v2,n,r2)
      real,intent(in)::v1(0:n+1),v2(0:n+1)
      real,intent(inout)::r2
      total = 0
      do i = 1,n-1
         total = total + (abs(v1(i)-v2(i)))**2
      end do     
      r2=sqrt(total/(N-1))
   end subroutine
End Program Def_Beam

!functions
function p(x)
    real:: x,p
    p = 0
    return
end

function q(x)
    real:: x,q
    q = 5.33E-8
    return
end
    
function r(x)
    real:: x,r
    r = 2.67E-9*(x*(x-120))
    return
end