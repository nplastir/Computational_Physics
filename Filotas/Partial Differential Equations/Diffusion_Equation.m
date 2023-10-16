clear all;
close all;
clc;

%Thermal Diffusion with Crack-Nicholson scheme
%Parameters

L=2; 
T=4;
D=0.5; 
dt=0.01; 
dx=0.01; 
lamda=D*dt/dx^2; 

%Grid 
xx=[-L/2:dx:L/2]; Nx=length(xx);
tt=[0:dt:T]; Nt=length(tt); 

u=zeros(Nt,Nx); 


%Initial condition 
sigma=0.2; mu=0; 
u(1,:)=normpdf(xx,mu,sigma); 
plot(xx,u(1,:))

% u(1,:)=0*ones(1,Nx);

%Boundary Condition
u(:,1)=0; u(:,Nx)=0;

%Matrix Definition

A=MatrixPreperation(lamda,Nx);

B=MatrixPreperation(-lamda,Nx); 

C=zeros(Nx-2,1);

%Frames 
frames=cell(1,Nt);

for i=1:Nt-1
    
    C(1,1)=0.5*lamda*u(i+1,1)+0.5*lamda*u(i,1);
    C(Nx-2,1)=0.5*lamda*u(i+1,Nx)+0.5*lamda*u(i,Nx);
    
    b=B*u(i,2:Nx-1)'+C; 
    
    u(i+1,2:Nx-1)=Gauss_Elimination(A,b);  %Solution to the problem A*u=b
    
end 
%%
  for i=1:Nt
      
      figure(1)
      plot(xx,u(i,:));
      axis([-L/2 L/2 0 3])
      xlabel('$x$','Interpreter','latex','Fontsize',18)
      ylabel('$u(x,t)$','Interpreter','latex','Fontsize',18)
      text(0.6,2.5,sprintf('t=%g s',i*dt),'Interpreter','latex','Fontsize',14)
      title('Thermal Diffusion','interpreter','Latex','Fontsize',20);
      drawnow
      frames{i} = getframe(gcf);
      
  end 
 %% 3D plot
  
[T,X]=meshgrid(tt,xx);
figure(2)
surf(T,X,u');
xlabel('$t$','interpreter','Latex','Fontsize',20);
ylabel('$x$','interpreter','Latex','Fontsize',20);
zlabel('$u(x, t)$','interpreter','Latex','Fontsize',20);
title('Thermal Diffusion','interpreter','Latex','Fontsize',20);
    
%%
%Save the frames as a GIF
filename = 'Diffusion1.gif';
delayTime = 0.005; % Adjust this value to control the frame rate/speed

for i = 1:Nt
    frame = frames{i};
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);
    
    On the first iteration, create the GIF file
    if i == 1
        imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', delayTime);
    else
        On subsequent iterations, append to the existing file
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', delayTime);
    end
end
