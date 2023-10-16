clear all;
clc;
close all;


a=472; V=4; %Ορισμός παραμέτρων
Ns=V*(a+(1/V)-1); tol=1e-5;
r=a*V;

N=Ns; st(1)=0; sz(1)=1; P(1)=1;     %Αρχικοποίηση
diff=1; i=2;


while diff>tol && i<1000
   
P(i)=(a*N)*P(i-1)/((N+1)*(1+N/V));

N=N+1;
st(i)=st(i-1)+(N-Ns)^2*P(i);
sz(i)=sz(i-1)+P(i);

diff=st(i)-st(i-1);

i=i+1; 
end 

S2_plus=st(end);
S0_plus=sz(end);
%%
clear st sz P

N=Ns; st(1)=0; sz(1)=1; P(1)=1;     %Αρχικοποίηση
diff=1; i=2;

while diff>tol && i<1000
    
P(i)=P(i-1)*((N+1)*(1+N/V))/(a*N);
% P(i)=P(i-1)*N*(1+(N-1)/V)/a/(N-1);
N=N-1; 

if N<=0
    break
end

st(i)=st(i-1)+(N-Ns)^2*P(i);
sz(i)=sz(i-1)+P(i);

diff=st(i)-st(i-1);

i=i+1; 
end 

S2_minus=st(end);
S0_minus=sz(end);
%%

var=(S2_minus+S2_plus)/(S0_minus+S0_plus);

txt=sprintf('The variance is equal to %d while r=%f',var,r);
disp(txt)

