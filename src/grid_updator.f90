subroutine grid_updator
    use systemparams
    implicit none
    real :: xhalf,xhalf1,Tplus1,T1,Tminus1,dx,Dplus,Dminus,dx1
    T_old(:) = T(:)
    do i=1,nx+1
        if(i==1) then
            Tminus1 = T_old(i)
        end if
        if(i/=1) then 
            Tminus1 = T_old(i-1)
        end if
        if(i==nx+1) then
            Tplus1 = T_old(i)
        end if
        if(i/=nx+1) then
            Tplus1 = T_old(i+1)
        end if
        T1 = T_old(i)
        if(i==1) then
            Dminus = diff*(1.0-x(i)*x(i))
        end if
        if(i/=1) then
            Dminus = 0.5*diff*((1.0-x(i-1)*x(i-1)) + (1.0-x(i)*x(i)))
        end if
        if(i==nx+1) then
            Dplus = diff*(1.0-x(i)*x(i))
        end if
        if(i/=nx+1) then
            Dplus = 0.5*diff*((1.0-x(i+1)*x(i+1)) + (1.0-x(i)*x(i)))
        end if
        if(i==1) then
            dx1 = deltax(i)
            dx = 0.5*(deltax(i+1)+deltax(i))
        else if(i==nx+1) then      
            dx1 = 0.5*(deltax(i-1)+deltax(i))
            dx = deltax(i)
        else      
            dx = 0.5*(deltax(i) + deltax(i+1))
            dx1 = 0.5*(deltax(i-1)+ deltax(i))
        end if
        T(i) = T1 + (dt/C_tot(i))*(Q(i) + (Dplus*(Tplus1-T1)/dx - Dminus*(T1-Tminus1)/dx1)/(0.5*(dx1+dx)) )
    end do
end subroutine grid_updator
