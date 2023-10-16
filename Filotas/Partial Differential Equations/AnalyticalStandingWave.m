clear all;
clc;

global c L g k 
c=1; 
L=1;
T=5;
g=-10; 
dx=0.01;
dt=0.01;

xx =[0:dx:L]; Nx=length(xx);
tt = [0:dt:T]; Nt=length(tt);  
u= zeros(Nt, Nx); 

frames=cell(1,Nt);

 for i=1:Nt
        for j=1:Nx
            
        for k=1:10 
            
            u(i,j)=u(i,j)+myfunc(tt(i),xx(j));
        end 
            u(i,j)=u(i,j)+cos(2*pi*c*tt(i)/L)*sin(2*pi*xx(j)/L);
    end 
end 


%%
for i=1:Nt
    
    figure(1)
    plot(xx,u(i,:),'Linewidth',2)
    axis([0 1 -5 3])
    xlabel('$x$','Interpreter','latex','Fontsize',18)
    ylabel('$u(x,t)$','Interpreter','latex','Fontsize',18)
    text(0.75,2.5,sprintf('t=%g s',i*dt),'Interpreter','latex','Fontsize',14)
    drawnow
end 


%%
function z=myfunc(t,x)

global c k L g 
z=(2*L^2*g/k^3/pi^3/c^2)*(1-(-1)^k)*(1-cos(k*pi*c*t/L))*sin(k*pi*x/L);

end 
