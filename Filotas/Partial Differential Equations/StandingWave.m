clear all;
close all;
clc;
%%

% Parameters
L = 1;          % Length of the string
T = 5;          % Total simulation time
dx=0.01;       % Number of spatial points
dt=0.001;     % Number of time steps
c = 1;          % Wave speed
a=c*dt/dx;     % parameter a
g=0;         % gravity

% Initialize variables
xx =[0:dx:L]; Nx=length(xx);       % Spatial grid
tt = [0:dt:T]; Nt=length(tt);      % Time grid
u= zeros(Nt, Nx);  

% Initial conditions
u(1,:) = sin(pi * xx / (0.5*L));      % Initial displacement
u(2,:) = u(1,:) + dt * zeros(1,Nx);  % Initial velocity is zero

%Boundary conditions
u(:,1)=0 ; u(:,L)=0;

for i=2:Nt-1
    
    for j=2:Nx-1
        u(i+1,j)=2*u(i,j)-u(i-1,j)+a^2*(u(i,j+1)-2*u(i,j)+u(i,j-1))+dt^2*g;
        
    end 
    
    figure(1)
    plot(xx,u(i,:),'Linewidth',2)
    axis([0 1 -6 2])
    xlabel('$x$','Interpreter','latex','Fontsize',20)
    ylabel('$u(x,t)$','Interpreter','Latex','Fontsize',20)
    text(0.75,1.5,sprintf('t=%g s',i*dt),'Interpreter','latex','Fontsize',14)
    drawnow;     
end 



        
        