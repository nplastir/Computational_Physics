clear all;
close all;
clc;

Na=20; N=[0:Na]; k=1;
a=400; b=500;
N_mean=Na*a/(a+b);

Nt=10000;

Dt=zeros(1,length(N)); % Αρχικοποίηση
t=zeros(1,length(N)); 

s=1; n=round(N_mean);
Wn=b+k*(n+Na);

for i=1:Nt
   
%      r=random('uniform',0,1);
     r=rand();
     r1=rand();
   
    wdn=k*n;
    wup=k*Na;
    
    R1=wdn/Wn;
    R2=wup/Wn;
    
    Dt(n+1)=-log(1-r)/Wn;
    t(n+1)=t(n+1)+Dt(n+1);
    
   if r<R1            %Μετάβαση από Ν->Ν-1
       %sentence=sprintf('Metavasi apo n se n-1, r=%d, R1=%d R2=%d', r,(wdn/Wn),(wup/Wn));
       % disp(sentence)
       
       n=n-1; 
       Wn=Wn-k; 
   end 
   if s==0 % μετάβαση s=0->s=1
         % sentence=sprintf('Metavasi apo s=0 se s=1, r=%d, R1=%d R2=%d', r,(wdn/Wn),(wup/Wn));
          % disp(sentence)
           
           s=1;
           Wn=Wn+k*Na+b-a;     
   else
           if r<R2 % μετάβαση Ν->Ν+1
              % sentence=sprintf('Metavasi apo n se n+1, r=%d, R1=%d R2=%d', r,(wdn/Wn),(wup/Wn));
              % disp(sentence) 
%               
               n=n+1;
               Wn=Wn+k;
           else          %μετάβαση s=1->s=0
             %  sentence=sprintf('Metavasi apo s=1 se s=0, r=%d,R1=%d R2=%d', r,(wdn/Wn),(wup/Wn));
              % disp(sentence)
               
               s=0;
               Wn=Wn-k*Na+a-b; 
               
           end
       end
 
   
       
  
           
end

%Συνολικός χρόνος 
T=0;
for j=1:length(N)
    T=T+t(j);
end 

P=t/T;
values=[0:Na];
bar(values,P)


xpos=0.6;
ypos=0.9;
text(xpos, ypos, sprintf('a=%d  b=%d  Na=%d \n k=%d $<N>$=%g ',a,b,Na,k,N_mean), 'Units', 'normalized','Interpreter','latex','Fontsize',14)
text(xpos, ypos, sprintf('\n ',N_mean), 'Units', 'normalized','Interpreter','latex','Fontsize',14)

xlabel('N','Interpreter','latex','Fontsize',20)
ylabel('P(N)','Interpreter','latex','Fontsize',20)
 %print(gcf,'MichaelMeden4.png','-dpng','-r300');