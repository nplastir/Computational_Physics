clear all;
close all;
clc;


global G M L l 

G=1; M=0.6; L=1; l=G*M/L^2; 

th=linspace(0,2*pi,1000); h=th(2)-th(1);
N=length(th);
u=zeros(1,N);
udot=zeros(1,N);

u(1)=1; udot(1)=0.1;


for i=1:N-1
    
    k11=h*myf1(th(i),u(i),udot(i));
    k12=h*myf2(th(i),u(i),udot(i));
    k21=h*myf1(th(i)+h/2.,u(i)+0.5*k11,udot(i)+0.5*k12);
    k22=h*myf2(th(i)+h/2.,u(i)+0.5*k11,udot(i)+0.5*k12);
    k31=h*myf1(th(i)+h/2.,u(i)+0.5*k21,udot(i)+0.5*k22);
    k32=h*myf2(th(i)+h/2.,u(i)+0.5*k21,udot(i)+0.5*k22);
    k41=h*myf1(th(i),u(i)+k31,udot(i)+k32);
    k42=h*myf2(th(i)+h,u(i)+k31,udot(i)+k32);
    
    u(i+1)=u(i)+(k11+2*k21+2*k31+k41)/6.;
    udot(i+1)=udot(i)+(k12+2*k22+2*k32+k42)/6.;
   
    
end 


x=(1./u).*cos(th);
y=(1./u).*sin(th); 

hold on
plot(x,y,'linewidth',2)
plot(0,0,'*r')
ylabel('y','Interpreter','latex','Fontsize',20)
xlabel('x','Interpreter','latex','Fontsize',20)

slin=polyfit(x,y,1);
disp(['e=',num2str(abs(slin(1)/slin(2))),' and p=',num2str(1/slin(2))])

function y1=myf1(t,u,udot)

y1=udot;

end

function y2=myf2(t,u,udot)

global l

y2=l-u;
    
end 


