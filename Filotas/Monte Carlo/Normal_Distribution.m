clear all 
close all
clc;


rng('shuffle');
fmax=1/sqrt(2*pi);

a=-3; b=3; c=fmax; 

i=1;
for n=1:10000
    
z=(b-a)*rand()+a;
y=fmax*rand();

if y<=fmax*exp(-0.5*z^2)
    
    x(i)=z;
    i=i+1;
end 
  
end 

numBins=20;
histogram(x,numBins)
ylabel('Absolute Frequency $f_X$','Interpreter','latex','Fontsize',20);
