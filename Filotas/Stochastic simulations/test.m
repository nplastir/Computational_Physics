clear all;
clc;
close all;


k1=100; Na=20; k2=10;  k3=12; V=2; 

a=round(k1*Na/(k3*V));

V2=k3*V/k2;

r=a/V2;

l=(k1*Na+k2)/V; mesh1=V*(l-1)/k2; mesh2=V2*(a-1);
txt0=sprintf('μεση τιμη=%d μέση (με α)=%d',mesh1,mesh2);
disp(txt0)
%Ορισμός παραμέτρων
Ns=round(V2*(a-1)); tol=1e-5;

N=Ns; st(1)=0; sz(1)=1; P(1)=1;     %Αρχικοποίηση
diff=1; i=2;


while diff>tol && i<1000
    
P(i)=k1*Na*N*P(i-1)/(V*(N+1)*(k2*N/V+k3));
% P(i)=(a*N)*P(i-1)/((N+1)*(1+N/V));

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
 
P(i)=V*(N+1)*(k2*N/V+k3)*P(i-1)/(k1*Na*N);
% P(i)=P(i-1)*((N+1)*(1+N/V))/(a*N);

N=N-1;
st(i)=st(i-1)+(N-Ns)^2*P(i);
sz(i)=sz(i-1)+P(i);

diff=st(i)-st(i-1);

i=i+1; 
end 

S2_minus=st(end);
S0_minus=sz(end);
%%

var=(S2_minus+S2_plus)/(S0_minus+S0_plus);

txt=sprintf('The variance is equal to %d while r=%d',var,r);
disp(txt)
