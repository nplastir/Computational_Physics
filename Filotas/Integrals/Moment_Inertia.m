clear all;
clc;
close all;

a=-1;      %Diasthmata sth z-oloklhrwsh
b=1;
tol=1e-3;
inte_z=0;

I=prosa_z(a,b,tol,inte_z);
sentence=sprintf('The integral is equal to I=%g',I);
disp(sentence)


function y=myfunc(r,z)
y=2*pi*r^3*(1+exp(sqrt(r^2+z^2)));    %Function 
end 

function dd=d(z)
dd=sqrt(1-z^2);                       %Boundary
end 

function integ=gaus_pi(a,b,zz)                %Gauss se ena diasthma sth r-exarthsh apo z                    
t=[-sqrt(3./5),0,sqrt(3/5.)];             
r=[0.5*((b-a)*t(1)+b+a),0.5*((b-a)*t(2)+b+a),0.5*((b-a)*t(3)+b+a)];
integ=0.5*(b-a)*(myfunc(r(1),zz)/1.8+myfunc(r(2),zz)/1.125+myfunc(r(3),zz)/1.8);
end 

function inte=prosa_pi(a,b,tol,inte,zz)         %Prosarmozomenh Gauss sth r- exarthsh z
g0=gaus_pi(a,b,zz);
g1=gaus_pi(a,0.5*(a+b),zz);
g2=gaus_pi(0.5*(a+b),b,zz);

if abs(g0-g1-g2)/31.<tol
    inte=inte+g1+g2;
else 
    inte=prosa_pi(a,0.5*(a+b),0.5*tol,inte,zz);
    inte=prosa_pi(0.5*(a+b),b,0.5*tol,inte,zz);
end
end 

function integ_pi=gaus_z(a,b)           %Gauss se ena diasthma sth z
tol=1e-3;
inte=0;
t=[-sqrt(3./5),0,sqrt(3/5.)]; 

z=[0.5*((b-a)*t(1)+b+a),0.5*((b-a)*t(2)+b+a),0.5*((b-a)*t(3)+b+a)];
integ_pi=0.5*(b-a)*(prosa_pi(0,d(z(1)),tol,inte,z(1))/1.8+prosa_pi(0,d(z(2)),tol,inte,z(2))/1.125+prosa_pi(0,d(z(3)),tol,inte,z(3))/1.8);
end 



function inte_z=prosa_z(a,b,tol,inte_z) %Prosarmozomenh Gauss sth z
g0=gaus_z(a,b);  
g1=gaus_z(a,0.5*(a+b));
g2=gaus_z(0.5*(a+b),b);

if abs(g0-g1-g2)/31.<tol
    inte_z=inte_z+g1+g2;
else
    inte_z=prosa_z(a,0.5*(a+b),0.5*tol,inte_z);
    inte_z=prosa_z(0.5*(a+b),b,0.5*tol,inte_z);
end 
end 


    
