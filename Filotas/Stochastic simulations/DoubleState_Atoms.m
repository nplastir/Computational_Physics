clear all;
close all;
clc;

Na=20; N=[0:100]; k=1;
N_mean=Na;


Nt=10000;

Dt=zeros(1,length(N)); % Αρχικοποίηση
t=zeros(1,length(N)); 

n=round(N_mean);
Wn=k*(n+Na);

for i=1:Nt
    
    r=rand;
    wup=k*Na;
    wdn=k*n;
    
    Dt(n+1)=-log(1-r)/Wn;                      %index n+1 to avoid t(0)
    t(n+1)=t(n+1)+Dt(n+1);
    
    if r<(wdn/Wn)  %Transition Ν->Ν-1
        n=n-1;
        Wn=Wn-k;
        
    else           %Transition Ν->Ν+1
        n=n+1;
        Wn=Wn+k;
        
    end 
    
end 

%Συνολικός Χρόνος
T=0;
for j=1:101
    T=T+t(j);
end 

P=t/T;
bar(N,P)
axis([0 40 0 0.12])

xpos=0.8;
ypos=0.9;
text(xpos, ypos, sprintf('Na=%d',Na), 'Units', 'normalized','Interpreter','latex','Fontsize',14)
xlabel('N','Interpreter','latex','Fontsize',15)
ylabel('P(N)','Interpreter','latex','Fontsize',15)

 %print(gcf,'DoubleState4.png','-dpng','-r300');