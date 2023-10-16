clear all;
close all;
clc;

k1=0.1 ; k2=0.5 ; k3=1; V=10; 
Na=20; N=[0:1000]; 
N_mean=Na;


Nt=10000;

Dt=zeros(1,length(N)); % Αρχικοποίηση
t=zeros(1,length(N)); 

n=round(N_mean);
Wn=n*(k1*Na+k2*(n-1)+k3)/V;

for i=1:Nt
    
    r=rand;
    wup=k1*n*Na/V;
    wdn=n*(k2*(n-1)/V+k3);
    
    Dt(n+1)=-log(1-r)/Wn;
    t(n+1)=t(n+1)+Dt(n+1);
    
    if n==0
        n=n;
      txt=sprintf('Metavasi apo n se n-1, r=%d, R1=%d R2=%d i=%d', r,(wdn/Wn),(wup/Wn),i);
       disp(txt)
    else 
        
    if r<(wdn/Wn)  %Μετάβαση Ν->Ν-1
        n=n-1;
        Wn=Wn-k1*Na/V-2*k2*(n-1)/V-k3;
        
    elseif r>(wdn/Wn)           %Μετάβαση Ν->Ν+1
        n=n+1;
        Wn=Wn+k1*Na/V+2*k2*(n-1)/V+k3;
        
    end 
    end 
    
end 

%Συνολικός Χρόνος
T=0;
for j=1:101
    T=T+t(j);
end 

P=t/T;
bar(N,P)
% axis([0 40 0 0.12])
xlabel('N','Interpreter','latex','Fontsize',15)
ylabel('P(N)','Interpreter','latex','Fontsize',15)