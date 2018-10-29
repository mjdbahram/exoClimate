subroutine system_setup
    use systemparams
    implicit none
    open(3,file = parameter_path, status='unknown')
    read(3,*) nx		
    read(3,*) star_mass		
    read(3,*) star_lum             
    read(3,*) a		
    read(3,*) e		
    read(3,*) phi_peri          
    read(3,*) angular_position		
    read(3,*) period		
    read(3,*) spin_obliquity		
    read(3,*) azim_obliquity        
    read(3,*) ocean_fraction		
    read(3,*) initial_temp			
    read(3,*) sim_time		
    read(3,*) freq		
    read(3,*) p		
    close(3)
    allocate(T_old(nx+1))
    allocate(T(nx+1))
    allocate(tt(nx+1))
    allocate(x(nx+1))
    allocate(lat(nx+1))
    allocate(latdeg(nx+1))
    allocate(cos_H(nx+1))
    allocate(f_ice(nx+1))
    allocate(C_tot(nx+1))
    allocate(albedo(nx+1))
    allocate(insol(nx+1))
    allocate(tau_ir(nx+1))
    allocate(tau_ir_1(nx+1))
    allocate(tau_0(nx+1))
    allocate(infrared(nx+1))
    allocate(Q(nx+1))
    allocate(deltax(nx+1))
    allocate(hab(nx+1))
    dlat = pi/(1.0*nx)		
    T(:) = initial_temp
    T_old(:) = T(:)
    time = 0.0
     do i=1,nx+1
        lat(i) = -pi/2.0 + (i-1)*dlat
        x(i) = sin(lat(i))
     end do
    latdeg(:) = lat(:)*180.0/pi
    deltax(:) = cos(lat(:))*dlat
    tt(:) = 0.0
    if(star_lum <= 0.0) star_lum = star_mass**4.0
    orb_period = sqrt(a*a*a/star_mass)
    orb_freq = 2.0*pi/(orb_period*year) 
    h_ang = sqrt(star_mass*a*(1.0-e*e))
    phi_peri = phi_peri*pi/180.0
    spin_obliquity = spin_obliquity*pi/180.0
    azim_obliquity = azim_obliquity*pi/180.0
    angular_position = angular_position*pi/180.0
    r = a*(1.0-e*e)/(1.0+e*cos(angular_position-phi_peri))
    diff = D*period*period*(p/p0)
    if(ocean_fraction>1.0) ocean_fraction = 1.0
    if(ocean_fraction<0.0) ocean_fraction = 0.0
    f_land = 1.0-ocean_fraction
end subroutine system_setup
