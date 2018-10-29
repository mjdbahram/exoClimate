subroutine paramters_update
    use systemparams
    implicit none
    real :: ang,sind,cosd,delta,tand,spin_obliquity_rad
    real :: C_atm,f_l=0.9
    real :: mu, fi , ao, ac , part1 , part2 , part3 , part4
	real :: tt_1
	tt_1 = f_l*(p/p0)!-(1-f_l)*(p/p0)**4
    spin_obliquity_rad = spin_obliquity *(pi/180)
  !tau_0(:) = 0.79 +(0.15 - 0.79)*(sin(lat(:) - spin_obliquity_rad)**(2))
    boil = -0.055*p**6 + 1.2502*p**5 - 11.111*p**4 + 48.87*p**3-112.46*p**2+144.07*p+31.096 + 273
    phidot = 2.0*pi*(h_ang/(r*r))/year
    angular_position  = angular_position + phidot*dt
    if(angular_position>2.0*pi) then
         angular_position = mod(angular_position,2.0*pi)
    end if

    r = a*(1.0-e*e)/(1.0+e*cos(angular_position-phi_peri))
    insol(:) = (q0*star_lum)/(pi*r*r) 
    sind = -sin(spin_obliquity)*cos(angular_position-phi_peri - azim_obliquity)     
    delta = asin(sind)
    cosd = sqrt(1.0-sind*sind)
    tand = tan(delta)

    do i=1,nx+1   
        cos_H(i) = -tan(lat(i))*tand
        if(abs(cos_H(i))>1.0) cos_H(i) = cos_H(i)/abs(cos_H(i))
        h = ACOS(cos_H(i))
        insol(i) = insol(i)*(H*sin(lat(i))*sind + cos(lat(i))*cosd*sin(H))
        f_ice(i) = 1.0 - exp(-(freeze-T(i))/10.0)

        if(f_ice(i)<0.0) then
            f_ice(i) =0.0
        end if

        C_atm = (p/p0)*C_atm0
        C_land = 1.0d9+C_atm
        C_ocean = 2.1d11+C_atm

        if(T(i)>=freeze) then
            C_ice = 0.0
        else if (T(i)<freeze.and. T(i)> freeze-10.0) then
            C_ice = 53.1d9
        else if(T(i)<=freeze-10.0) then
            C_ice = 11.1d9
        end if

        C_tot(i) = f_land*C_land + ocean_fraction*(f_ice(i)*C_ice + (1.0-f_ice(i))*C_ocean)

		if (H>0) then
			mu = sin(lat(i))*sind + (cos(lat(i))*cosd*sin(H))/H
		else if (H==0) then
			mu = 0.5
		end if
	    mu = 0.92*mu
        ao = (0.026/(1.1*mu**1.7+0.065))+0.15*(mu-0.1)*(mu-0.5)*(mu-1)
        fi = max(0.0,(1-exp((T(i)-273.0)/10.0)))
        ac = max(0.19,-0.07+8.d-3*ACOS(mu)*57.2957799513)
        part1 = (1-fi)*(ao*(0.33)+ac*0.67)
        part2 = fi*(0.62*(0.5)+ac*0.5)
        part3 = (1-fi)*(0.2*(0.5)+ac*0.5)
        part4 = fi*(0.85*(0.5)+ac*0.5)
        albedo(i) =(ocean_fraction)*(part1+part2)+(1-ocean_fraction)*(part3 + part4)
        tau_ir(i) = 0.9*(f_l*(p/p0)**(1.6)-(1-f_l)*(p/p0)**4)*(T(i)/freeze)**3
        infrared(i) = sigma_SB*(T(i)*T(i)*T(i)*T(i))/(1.0 + 0.79*tau_ir(i))
        Q(i) = insol(i)*(1.0-albedo(i)) - infrared(i)
        hab(i) = 0.0

        if (T(i)>=freeze.and.T(i)<=boil) then
            hab(i)=1.0
        end if

    end do

end subroutine paramters_update


