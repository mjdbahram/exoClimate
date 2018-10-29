# -*- coding: utf-8 -*-
"""
Created on Thu Aug 31 18:35:47 2017

@author: majid
"""
import os
import sys
import numpy as np
#import matplotlib.pyplot as plt

run_status = "multi_planet"
root_path = os.popen("pwd").read()

mass = 0.970 # in solar mass unit
a = 0.849 # in A.U. unit
luminasity = 0.7967 # in solar luminasity

#====================== Eccentricity
e = 0.0
e_initial = 0.0
e_final = 1.0
e_step = 0.5

#===================== Rotational period (in days)
omega = 286.8623 # in days
omega_list = [0.5,0.75,1.0,1.25,1.5]

#==================== Spin Obliquity (in degrees)
spin = 89.97
spin_list = [0.0,22.5,45,67.5,90]

#=================== Ocean fraction from 0 to 1
ocean_fraction = 0.7
of_list = [0.1,0.3,0.5,0.7,0.9]

#=================== Pressure value in atm
p = 1.0
p_list =[0.5,1.5,2.5,3.5,4.5]



def header_string_maker(OF, omega, spin, p):
	name_string = "of="+str(OF)+ " "+"\nomega="+ str(omega) + " "+"\nspin="+ str(spin) + " "+"\np="+str(p)
	return name_string


file_name_template = "m="+str(mass)+"\ta="+str(a)+"\tl="+str(luminasity)


os.system("mkdir -p ./outputs/parameters")
os.system("rm -f ./outputs/parameter/*")
os.system("mkdir -p ./outputs/snapshots")
os.system("rm -f ./outputs/snapshots/*")

os.chdir("./outputs/parameters")



# loops for creating directory


for OF in of_list:
    OF_counter = of_list.index(OF) +1
    for omega in omega_list:
        omega_counter = omega_list.index(omega) +1
        for spin in spin_list:
            spin_counter = spin_list.index(spin) + 1
            for p in p_list:
                p_counter = p_list.index(p) +1
                file_name = str(OF_counter)+"_"+str(omega_counter)+"_"+str(spin_counter)+"_"+str(p_counter)
                footer = header_string_maker(OF, omega, spin, p)
                f = open(file_name,"w")
                f.write("n	Is this a restart? (y/n)\n")
                f.write("test.100	If a restart, specify the initial conditions file\n")
                f.write("a1e0p0		File prefix for this run\n")
                f.write("144		Number of grid points\n")
                f.write(str(mass)); f.write("		Star Mass in Solar Masses\n")
                f.write(str(luminasity)); f.write("		Star Luminosity in solar luminosities (set to zero for MS calc)\n")
                f.write(str(a)); f.write("   Semi Major Axis of Planet Orbit (in AU)\n")
                f.write(str(e)); f.write("		Eccentricity of Planet Orbit\n")
                f.write("0.0		Longitude of Periastron (in degrees)\n")
                f.write("0.0		Initial orbital longitude (in degrees, periastron=0)\n")
                f.write(str(omega));f.write(" 		Rotation period of Planet (in days)\n")
                f.write(str(spin)); f.write("		Spin Obliquity (in degrees)\n")
                f.write("0.0		Longitude of Winter Solstice (degrees, relative to periastron)\n")
                f.write(str(OF)); f.write("		Fraction of planet surface that is ocean\n")
                f.write("288.0		Initial Surface Temperature (in K)\n")
                f.write("1.0d2		Maximum Simulation Time (in years)\n")
                f.write("1.0d-1		Frequency at which simulation dumps data (in years)\n")
                f.write(str(p));f.write("   Pressure of atmosphere(in atms)\n")
                f.write("\n")
                f.write("\n")
                f.write("Parameters are:\n")
                f.write(footer)
                f.close()

			
			


mylist = os.popen('ls').read()
# import commands
#m=commands.getoutput('ls')
mylist = mylist.split('\n')
del mylist[-1]


os.chdir("..")
os.chdir("..")

for i in mylist:
	command = "./src/planet_1DEBM<<eof\n"+i+"\n"+run_status+"\n"+"eof"
	os.system(command)




def T_v(p):
    return -0.055*p**6 + 1.2502*p**5 - 11.111*p**4 + 48.87*p**3-112.46*p**2+144.07*p+31.096 + 273
    
	

horizon_counter=0
vertical_counter=0
x= []
y= []

shape=[]
color=[]
color_max = []
color_min = []
size=[]


for OF in of_list:
    OF_counter = of_list.index(OF) +1
    for omega in omega_list:
        omega_counter = omega_list.index(omega) +1
        for spin in spin_list:
            spin_counter = spin_list.index(spin) + 1
            for p in p_list:
                p_counter = p_list.index(p) +1
                horizon_counter =  0.85*(spin_counter-1)*(len(p_list) +1)+ p_counter  
                x.append((horizon_counter))
                vertical_counter = 0.85*(OF_counter-1)*(len(omega_list)+1)+ omega_counter
                y.append((vertical_counter))
                vertical_counter = 0
                  #  yy.append(str(p)+" "+str(spin)+" "+str(omega)+" "+str(OF))
                file_name = "./outputs/results/result."+str(OF_counter)+"_"+str(omega_counter)+"_"+str(spin_counter)+"_"+str(p_counter)
 #                   print x[-1],y[-1],str(OF_counter)+str(omega_counter)+str(spin_counter)+str(p_counter)
                
                m=np.loadtxt(file_name)
                color.append(m[1])
                if (m[1] < 220 or m[1] > 273 + 0.9*(T_v(p)-273) ):
                    size.append(0.05)
                else:
                    if m[0]== 0:
                        size.append(m[0]+0.01)
                    elif m[0]> 1:
                        size.append(0.02)
                    else:
                        size.append(m[0])    
                color_max.append(m[3])
                color_min.append(m[4])
                if (m[1] < 220 or m[1] > 273 + 0.9*(T_v(p)-273) ):
                    shape.append("1")
                else:
                    if (m[2] == 0):
                        shape.append("o")
                    elif (m[2]==1 or m[2]==-1):
                        shape.append("1")
                    elif (m[2]==10):
                        shape.append(">")


size = np.array(size)

index_co = 0
for i in shape:
    if i=="o":
        size[index_co] *= 30
    else:
        size[index_co] *= 10
    index_co += 1
    
                   


color = np.array(color)
#print shape

fig,ax = plt.subplots()
norm=plt.Normalize(np.min(color), 366.8)
plt.ylim(0.45,26)
plt.axis('off')
plt.xlim(0,30)
for xp,yp,mark,area,rang in zip(x,y,shape,size,color):
    sc = ax.scatter(xp , yp , c = rang, s = area , cmap = plt.cm.jet , marker = mark ,norm = norm,linewidth = 0.1)
plt.colorbar(sc)
sc = ax.scatter(27 , 7 ,s=30,c='w', marker = "o", facecolor='r',linewidth = 0.5 )
sc = ax.scatter(27 , 5 ,s=21,c='w', marker = "o", facecolor='r',linewidth = 0.5 )
sc = ax.scatter(27 , 3 ,s=12,c='w', marker = "o", facecolor='r',linewidth = 0.5 )
sc = ax.scatter(27 , 1 ,s=9,c='w', marker = "o", facecolor='r',linewidth = 0.5 )
sc = ax.scatter(29 , 7 ,s=15,c='w', marker = ">", facecolor='r',linewidth = 0.5 )
sc = ax.scatter(29 , 5 ,s=10.5,c='w', marker = ">", facecolor='r',linewidth = 0.5 )
sc = ax.scatter(29 , 3 ,s=6,c='w', marker = ">", facecolor='r',linewidth = 0.5 )
sc = ax.scatter(29 , 1 ,s=4.5,c='w', marker = ">", facecolor='r',linewidth = 0.5 )
ax.legend()
for i in np.arange(0,31,5.1):
    plt.axvline(x=i+0.45, linewidth=0.2, color='k')
for i in np.arange(0,31,5.1):
    plt.axhline(y=i+0.45, linewidth=0.2, color='k')
plt.savefig("hi_mean.pdf")


#==============================================================
color_max = np.array(color_max)
#print shape

fig,ax = plt.subplots()
norm=plt.Normalize(np.min(color_max), np.max(color_max))
#plt.ylim(0,13)
#plt.xlim(-1,12)
for xp,yp,mark,area,rang in zip(x,y,shape,size,color_max):
    sc = ax.scatter(xp , yp , c = rang, s = area , cmap = plt.cm.jet , marker = mark ,norm = norm,linewidth = 0.1)
plt.colorbar(sc)
for i in range(0,31,6):
    plt.axvline(x=i, linewidth=0.2, color='k')
for i in range(0,31,6):
    plt.axhline(y=i, linewidth=0.2, color='k')
plt.savefig("hi_max.pdf")

#==============================
color_min = np.array(color_min)
#print shape

fig,ax = plt.subplots()
norm=plt.Normalize(np.min(color_min), np.max(color_min))
#plt.ylim(0,13)
#plt.xlim(-1,12)
for xp,yp,mark,area,rang in zip(x,y,shape,size,color_min):
    sc = ax.scatter(xp , yp , c = rang, s = area , cmap = plt.cm.jet , marker = mark ,norm = norm,linewidth = 0.1)
plt.colorbar(sc)
for i in range(0,31,6):
    plt.axvline(x=i, linewidth=0.2, color='k')
for i in range(0,31,6):
    plt.axhline(y=i, linewidth=0.2, color='k')
plt.savefig("hi_min.pdf")


      
#====================================================
 
hab = np.ones(len(of_list))
T_mean = np.ones(len(of_list))
T_max = np.ones(len(of_list))
T_min = np.ones(len(of_list))
OF_counter = 1
omega_counter = 3
spin_counter = 5
p_counter = 2
for i in range(len(of_list)):
    file_name = "./outputs/results/result."+str(i+1)+"_"+str(omega_counter)+"_"+str(spin_counter)+"_"+str(p_counter)
    m = np.loadtxt(file_name)
    if m[0]== 0:
        hab[i] = m[0]+0.01
    elif m[0]> 1:
        hab[i] = 0.02
    else:
        hab[i] = m[0]-0.18
        
    T_mean[i] = m[1]
    T_max[i] = m[3]
    T_min[i] = m[4]
#============================= 
of_array = np.array(p_list)

fig,ax = plt.subplots(nrows=2, ncols=1)
fig.subplots_adjust(hspace=0.52)

plt.subplot(2, 1, 1)
plt.plot(of_array, T_max, 'r.-')
plt.plot(of_array, T_mean, 'g-')
plt.plot(of_array, T_min, 'b--')
plt.xlabel('Pressure (in atm) ')
plt.ylabel('Temperature in K')
#plt.ylim(180,330)
plt.legend(['max','mean', 'min'], loc='lower right',prop={'size':8})

plt.subplot(2, 1, 2)
plt.plot(of_array, hab, 'k.-')
plt.ylim(0.0,1.1)
plt.xlabel('Pressure (in atm) ')
plt.ylabel('Habitability')
#plt.show()
plt.savefig("of*_T3_S5_P1.pdf")
# Rotational Period (in earth day) 
# Ocean Fraction
# Obliquity if Spin in Degree 
# Pressure (in atm)

