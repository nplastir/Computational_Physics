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
g=-10;         % gravity

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
    
%     figure(1)
%     plot(xx,u(i,:),'Linewidth',2)
%     axis([0 1 -6 2])
%     drawnow;     
end 

%% Analytical

global c L g k 
c=1; 
L=1;
T=5;
g=-10; 
dx=0.01;
dt=0.001;

xx =[0:dx:L]; Nx=length(xx);
tt = [0:dt:T]; Nt=length(tt);  
u_an= zeros(Nt, Nx); 

 for i=1:Nt
        for j=1:Nx
            
        for k=1:10 
            
            u_an(i,j)=u_an(i,j)+myfunc(tt(i),xx(j));
        end 
            u_an(i,j)=u_an(i,j)+cos(2*pi*c*tt(i)/L)*sin(2*pi*xx(j)/L);
    end 
end 


%% Graph
for j=1:Nt/10
    i=10*j-9
    figure(1)
    plot(xx,u(i,:),'k',xx,u_an(i,:),'c--','Linewidth',2)
    axis([0 1 -5 3])
    xlabel('$x$','Interpreter','latex','Fontsize',18)
    ylabel('$u(x,t)$','Interpreter','latex','Fontsize',18)
    text(0.75,2.5,sprintf('t=%g s',i*dt),'Interpreter','latex','Fontsize',14)
    legend('Computational','Analytical','Location','northwest')
    frames{j} = getframe(gcf);
    
end 


%%
%Save the frames as a GIF
filename = 'StringGravity1.gif';
delayTime = 0.005; % Adjust this value to control the frame rate/speed

for i = 1:Nt
    frame = frames{i};
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);
    
    % On the first iteration, create the GIF file
    if i == 1
        imwrite(imind, cm, filename, 'gif', 'Loopcount', inf);
    else
        % On subsequent iterations, append to the existing file
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', delayTime);
    end
end
%%
function z=myfunc(t,x)

global c k L g 
z=(2*L^2*g/k^3/pi^3/c^2)*(1-(-1)^k)*(1-cos(k*pi*c*t/L))*sin(k*pi*x/L);

end 
% %%
% 
% plot(xx,u(1,:))

        
        