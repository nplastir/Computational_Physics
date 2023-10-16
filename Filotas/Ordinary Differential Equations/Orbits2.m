clear all;
close all;
clc;


global G M L l 

G=1; M=0.58; L=1; l=G*M/L^2; 

tt=linspace(0,100,1000); h=tt(2)-tt(1);
N=length(tt);
r=zeros(1,N);
u=zeros(1,N);
theta(1)=0; 
theta_dot=zeros(1,N); theta_2dot=zeros(1,N); 
r(1)=1; u(1)=0.01;
theta_dot(1)=L/r(1)^2; theta_2dot(1)=-(2*L/r(1)^3)*u(1); 

for i=1:N-1
    
   
    
    
    k11=h*myf1(tt(i),r(i),u(i));
    k12=h*myf2(tt(i),r(i),u(i));
    k21=h*myf1(tt(i)+h/2.,r(i)+0.5*k11,u(i)+0.5*k12);
    k22=h*myf2(tt(i)+h/2.,r(i)+0.5*k11,u(i)+0.5*k12);
    k31=h*myf1(tt(i)+h/2.,r(i)+0.5*k21,u(i)+0.5*k22);
    k32=h*myf2(tt(i)+h/2.,r(i)+0.5*k21,u(i)+0.5*k22);
    k41=h*myf1(tt(i),r(i)+k31,u(i)+k32);
    k42=h*myf2(tt(i)+h,r(i)+k31,u(i)+k32);
    
    r(i+1)=r(i)+(k11+2*k21+2*k31+k41)/6.;
    u(i+1)=u(i)+(k12+2*k22+2*k32+k42)/6.;
   
    theta_dot(i+1)=L/r(i+1)^2;
    theta_2dot(i+1)=-(2*L/r(i+1)^3)*u(i+1); 
    
    theta(i+1)=theta(i)+h*theta_dot(i)+0.5*h^2*theta_2dot(i); 
end 


x=r.*cos(theta);
y=r.*sin(theta); 
figure(1)
hold on
plot(x,y,'linewidth',2)
plot(0,0,'*r')

ylabel('y','Interpreter','latex','Fontsize',20)
xlabel('x','Interpreter','latex','Fontsize',20)

figure(2)
A=0.5*r.^2.*theta_dot; 
plot(A,'--','Linewidth',2);
axis([0 1000 0 1])
text(600,0.9,'$\dot{A}=\frac{1}{2} r^2 \dot{\theta}$','Interpreter','latex','Fontsize',20) 
% text(1, 0.5, latex_formula, 'Interpreter', 'latex', 'FontSize', 16);

function y1=myf1(t,r,u)

y1=u;

end

function y2=myf2(t,r,u)

global l L

y2=L^2*((-l/r^2)+1/r^3);
    
end 
