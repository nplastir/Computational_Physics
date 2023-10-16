clear all;
clc;
close all;

%Main function

e=-1; f=1; tol=1e-4;
inte3=0;

I=prosa_z(e,f,tol,inte3);
sentence=sprintf('The integral is equal to I=%g',I);
disp(sentence)




function ff=myfunc(x,y,z)
ff=1+x^2+2*y^2+3*z^2;
end 

function int_x=gausx(a,b,yy,zz)

t=[-sqrt(3./5),0,sqrt(3/5.)];
x=[0.5*((b-a)*t(1)+b+a),0.5*((b-a)*t(2)+b+a),0.5*((b-a)*t(3)+b+a)];
int_x=0.5*(b-a)*(myfunc(x(1),yy,zz)/1.8+myfunc(x(2),yy,zz)/1.125+myfunc(x(3),yy,zz)/1.8);
end 

function inte1=prosa_x(a,b,tol,inte1,yy,zz)
g0=gausx(a,b,yy,zz);
g1=gausx(a,0.5*(a+b),yy,zz);
g2=gausx(0.5*(a+b),b,yy,zz);

if abs(g0-g1-g2)/31.<tol 
    
    inte1=inte1+g1+g2;
    
else
    inte1=prosa_x(a,0.5*(a+b),tol,inte1,yy,zz);
    intel=prosa_x(0.5*(a+b),b,tol,inte1,yy,zz);
    
end 
end 

function int_y=gausy(c,d,zz)
a=-1; b=1; tol=1e-4; inte1=0; 

t=[-sqrt(3./5),0,sqrt(3/5.)];
y=[0.5*((d-c)*t(1)+d+c),0.5*((d-c)*t(2)+d+c),0.5*((d-c)*t(3)+d+c)];
int_y=0.5*(d-c)*(prosa_x(a,b,tol,inte1,y(1),zz)/1.8+prosa_x(a,b,tol,inte1,y(2),zz)/1.125+prosa_x(a,b,tol,inte1,y(3),zz)/1.8);
end 

function inte2=prosa_y(c,d,tol,inte2,zz)
h0=gausy(c,d,zz);
h1=gausy(c,0.5*(c+d),zz);
h2=gausy(0.5*(c+d),d,zz);

if abs(h0-h1-h2)<tol
    inte2=inte2+h1+h2;
    
else
    
    inte2=prosa_y(c,0.5*(c+d),tol,inte2,zz);
    inte2=prosa_y(0.5*(c+d),d,tol,inte2,zz);
    
end 
end 

function int_z=gausz(e,f)
c=-1; d=1; tol=1e-4; inte2=0; 

t=[-sqrt(3./5),0,sqrt(3/5.)];
z=[0.5*((f-e)*t(1)+f+e),0.5*((f-e)*t(2)+f+e),0.5*((f-e)*t(3)+f+e)];
int_z=0.5*(f-e)*(prosa_y(c,d,tol,inte2,z(1))/1.8+prosa_y(c,d,tol,inte2,z(2))/1.125+prosa_y(c,d,tol,inte2,z(3))/1.8);
end 

function inte3=prosa_z(e,f,tol,inte3)
j0=gausz(e,f);
j1=gausz(e,0.5*(e+f));
j2=gausz(0.5*(e+f),f);

if abs(j0-j1-j2)<tol 
    inte3=inte3+j1+j2;
else
    inte3=prosa_z(e,0.5*(e+f),tol,inte3);
    inte3=prosa_z(0.5*(e+f),f,tol,inte3);
end 
end 

