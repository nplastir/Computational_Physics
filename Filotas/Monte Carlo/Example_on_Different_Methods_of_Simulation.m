
%% Μέθοδος Απόρριψης 
clear all;
close all;
clc;

i=1; %Initialize index i

for n=1:40000
    
xx=2*rand()-1;
u=2*rand();

if u<=1+xx^2
    x(i)=xx;    
    i=i+1;
end

end 

numBins=40;
figure(1)
histogram(x,numBins)
ylabel('Absolute Frequency $f_X$','Interpreter','latex','Fontsize',20);

%% Μέθοδος Μετασχηματισμού 
clear x;

for n=1:10000
    
 u=8*rand()/3.;
  
%  roots_array=roots([1/3 0 1 4/3-u]);  %Ενσωματωμένη Εντολή Matlab για
%  ευρεση ριζών της εξίσωσης
% x1(n)=roots_array(3);    %Στη θεση 3 αποθηκεύεται η πραγματική λύση

s=sqrt(9*u^2-24*u+20);
A=nthroot(s+3*u-4,3)/(2^(1/3));

x(n)=A-inv(A);
end 


numBins=40;
figure(2)
histogram(x,numBins)

%% Σύνθετη Μέθοδος
clear x;

for n=1:10000
    
    v=rand();
    
    if v<=0.75
        u=rand();
        x(n)=2*u-1;
    else   
        u=2*rand()/3.;
        x(n)=nthroot(3*u-1,3);
        
    end 
    
end 
figure(3)
numbins=40;
histogram(x,numbins)

        





function zz=z(x)

zz=1+x^2; 

end 