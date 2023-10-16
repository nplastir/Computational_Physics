clear all 
close all
clc;

rng('shuffle');

T=300; Mr=28;
a=0; b=1500; 

A=(0.12e-3*Mr)/(2*T + 0.);
fmax = sqrt(8*(0.12e-3)*Mr/(pi*T*exp(2)+0.));

i=1;
for n=1:150000
    
    z=(b-a)*rand()+a;
    y=fmax*rand();
    
    if y<=4*pi*(A/pi)^(1.5)*z^2*exp(-A*z^2) 
        
        x(i)=z;
        i=i+1;
        
    end
    
end 

numBins=40;
histogram(x,numBins); 
ylabel('Absolute Frequency $f_X$','Interpreter','latex','Fontsize',20);
