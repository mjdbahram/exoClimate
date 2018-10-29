module systemparams
    implicit none
    save
    integer :: i,nx,snapshot
	integer :: counter = 0 , old_counter, temp_int
    real, parameter :: pi = 3.141592653
    real, parameter :: freeze = 273.0	
    real, parameter :: sun_mass = 1.99d33
    real, parameter :: AU = 1.496e13
    real, parameter :: sun_luminosity = 3.826e33
    real, parameter :: q0 = sun_luminosity/(4.0*pi*AU*AU)	
    real, parameter :: G = 6.673d-8
    real, parameter :: C_atm0 = 10.1d9
    real, parameter :: year = 3.1556926d7 
    real, parameter :: sigma_SB = 5.6704d-5
    real, parameter :: D = 5.394d2
    real, parameter :: p0 = 1 
    real :: a, e, angular_position, period, orb_period,orb_freq, spin_obliquity,azim_obliquity, C_ice
    real :: ocean_fraction, f_land, initial_temp, time, sim_time, dlat,dt,h_ang, phi_peri
	real :: habfraction = 0.0 , mean_hab = 0.0 , mean2_hab = 0.0
	real :: old_mean_hab , old_mean2_hab
	real :: T_mean_new , T_mean_old, D_co
    real :: r,H,Fj,Fj1,star_mass,star_lum,diff,freq,timeyr
    real :: hh = 0.0
	real :: hc = 0.0
    real :: meanT, phidot, r_p, habfrac, p,C_land ,C_ocean, boil
    real :: yr10 = 3.1556926d8
	real :: T_min = 220, T_max 
	character(100)::parameter_file,parameter_path, result_path
    character(100)::run_status, fileno, temp_str , filename
    real, allocatable :: f_time(:)
    real, allocatable :: T(:), T_old(:), insol(:),cos_H(:),tt(:),tau_ir_1(:), tau_0(:)
    real, allocatable :: lat(:), x(:), albedo(:),tau_ir(:),hab(:),latdeg(:)
    real, allocatable :: infrared(:), Q(:),deltax(:), f_ice(:), C_tot(:)
end module systemparams
