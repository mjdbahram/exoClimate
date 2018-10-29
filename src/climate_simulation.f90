program climate_simulation
    use systemparams
    implicit none
	read(*,*) parameter_file
	read(*,*) run_status
	result_path = "./outputs/results/"//"result."//parameter_file
	parameter_path = "./outputs/parameters/"//parameter_file
    print*,
    print*,"simulating ",parameter_file
    open(61,file = result_path,status="replace") 
    allocate(f_time(nx+1))
    f_time = 0.0
    call system_setup 
    call paramters_update
    r_p = 2*pi / phidot

    dt = sim_time
    call step_forwards
    time =time+dt
    call paramters_update
    T_max = freeze + 0.9*(boil - freeze)
    timeyr = time/year	
    T_mean_old = sum(T)/size(T)
    do while (timeyr<sim_time)
        call grid_updator
        call paramters_update
        timeyr = time/year
        if (timeyr>freq*snapshot) then
            if(snapshot<=9) then
               write(fileno,'(I1)') snapshot
            else if(snapshot>9.and.snapshot<=99) then
               write(fileno,'(I2)') snapshot
            else if(snapshot>99.and.snapshot<=999) then
               write(fileno,'(I3)') snapshot
            else if(snapshot>999.and.snapshot<=9999) then
               write(fileno,'(I4)') snapshot
            else if(snapshot>9999.and.snapshot<=99999) then
               write(fileno,'(I5)') snapshot
            end if
            filename = './outputs/snapshots/'//trim(fileno)
            snapshot = snapshot +1
            
            open(12,file=filename, status='unknown')
            do i=1,nx
                write(12,*) timeyr, latdeg(i), T(i)
            end do
                write(12,*)
            close(12)  
  
         end if
         call step_forwards
         time =time+dt
        if (timeyr >= yr10/year - r_p/year) then
            do i=1,nx+1
                f_time(i) = f_time(i) + hab(i)*dt/r_p
            end do
        end if

        do i=1,nx+1
            habfraction = habfraction + 0.5*hab(i)*cos(lat(i))*dlat
        end do
        counter = counter + 1
        mean_hab = mean_hab + habfraction
        mean2_hab = mean2_hab + habfraction*habfraction

        if (timeyr >= yr10/year) then 
            old_mean_hab = mean_hab
			old_mean2_hab = mean2_hab 
			old_counter = counter
			mean_hab = 0.0
			mean2_hab = 0.0
			counter = 0
			T_mean_new = sum(T)/size(T)
			temp_int = yr10/year   
            yr10 = yr10 + year*10
            if (run_status == "multi_planet") then
                if (abs(T_mean_new-T_mean_old) < 0.01.or. (timeyr >= sim_time - yr10/year)) then
                    exit
                else 
                f_time = 0.0
                end if
		    end if
        end if
        T_mean_new = sum(T)/size(T)
        T_mean_old = T_mean_new
	    habfraction = 0.0
      
    end do  


    if ( T_mean_new > T_min .or. T_mean_new < T_max ) then
	    do i=1,nx+1
            hh = hh + 0.5*f_time(i)*COS(lat(i))*dlat
		end do
        do i=1,nx+1
            if (f_time(i) > 0.98 ) then
                hc = hc + 0.5*f_time(i)*COS(lat(i))*dlat
            else
                hc = hc + 0.0
            end if
        end do
	else 
		 hh = 0.0
		 hc = 0.0
    end if  

    write(temp_str,*) habfrac
    write(61,*) adjustl(trim(temp_str))
    write(temp_str,*) meanT  
    write(61,*) adjustl(trim(temp_str)) 

	old_mean_hab = old_mean_hab/(old_counter+0.01)
	old_mean2_hab = old_mean2_hab/(old_counter+0.01)
	old_mean2_hab = sqrt(old_mean2_hab-old_mean_hab**2)


	if (old_mean_hab < 0.1) then
		if (sum(T)/size(T) >= 373) then
			write(temp_str,*) 1  ! for hot
			write(61,'(a)') adjustl(trim(temp_str))
		else
			write(temp_str,*) -1 ! for snowball
			write(61,'(a)') adjustl(trim(temp_str))
		end if
	else if (old_mean_hab > 0.1 .and. old_mean2_hab <  0.1*old_mean_hab)  then
	  write(temp_str,*) 0 ! for habitable
			write(61,'(a)') adjustl(trim(temp_str))
	else if (old_mean_hab > 0.1 .and. old_mean2_hab > 0.1*old_mean_hab) then
		write(temp_str,*) 10  !for tansient
		write(61,'(a)') adjustl(trim(temp_str))
	end if
    write(temp_str,*) maxval(T)
    write(61,*) adjustl(trim(temp_str)) 
    write(temp_str,*) minval(T)
    write(61,*) adjustl(trim(temp_str)) 
    close(76)
	close(61)
end program climate_simulation
