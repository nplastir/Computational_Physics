
clear all;
clc;
close all;
%%
textToPrint = 'We are solving the advective equation using the upwind differention scheme $u^{n+1}_{j}=u^{n}_{j}-c \frac{\Delta t}{\Delta x}(u^{n}_{j}-u^{n}_{j-1})$ in width [0,2]' 

figure(1);
axis off;

text(0.5, 0.5, textToPrint, 'Interpreter', 'latex', 'FontSize', 16, 'HorizontalAlignment', 'center');
%% Main algorithm

% Parameters
L = 2;              % Length of the domain
T = 2;              % Total time
c = 1;              % Wave speed
dx =0.01;           % Spatial grid spacing
dt =0.01;           % Temporal grid spacing
a=c*dt/dx;          % parameter a 

%Grid formation 
tt=[0:dt:T]; Nt=length(tt);
xx=[0:dx:L]; Nx=length(xx); 

%Frames 
frames=cell(1,Nt); 

%Initial condition (wavepacket)
wavelength = L;                     % Wavelength
k = 2*pi/wavelength;                % Wave number
amplitude = 1;                      % Amplitude
sigma = 0.1*L;                      % Width parameter (controls the spread)
u0 = amplitude*sin(k*xx).*exp(-(xx-L/4).^2/(2*sigma^2));

%Initiation
u=zeros(Nt,Nx);
u(1,:)=u0; 


for i=1:Nt-1
    
for j=2:Nx
    
        u(i+1,j)=u(i,j)-a*(u(i,j)-u(i,j-1));
end 

figure(2)
plot(xx,u(i,:),'k')
axis([0 2 -2 2])
xlabel('$x$','Interpreter','latex','Fontsize',18)
ylabel('$u(x,t)$','Interpreter','latex','Fontsize',18)
text(1.5,1.5,sprintf('t=%g s',i*dt),'Interpreter','latex','Fontsize',14)
frames{i} = getframe(gcf);
end 


%% 
[T,X]=meshgrid(tt,xx);
figure(3)
surf(T,X,u');
xlabel('t');
ylabel('x');
zlabel('u(x, t)');
title('Propagation of a Wavepacket');

%% Save the frames as a GIF
% filename = 'WavePropagation.gif';
% delayTime = 0.05; % Adjust this value to control the frame rate/speed
% 
% for i = 1:Nt
%     frame = frames{i};
%     im = frame2im(frame);
%     [imind, cm] = rgb2ind(im, 256);
%     
%     % On the first iteration, create the GIF file
%     if i == 1
%         imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', delayTime);
%     else
%         % On subsequent iterations, append to the existing file
%         imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', delayTime);
%     end
% end
