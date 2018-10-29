subroutine step_forwards
  use systemparams
  implicit none
  tt(:) = 0.0
  do i=1,nx+1
     if(i/=1.and.i/=nx+1) then
        tt(i) = (deltax(i)*deltax(i)*C_tot(i))/(2.0*0.5*diff*((1.0-x(i+1)*x(i+1)) + (1.0-x(i)*x(i))))
     else
        tt(i) = 1.0e30
     end if
  end do
 dt=0.9*minval(tt) 
end subroutine step_forwards
