clear all;
close all;
clc;


Nwalkers=10000;
t=[1:1000];
dt=1;
gamma=1; 
x=zeros(length(t),Nwalkers);
r = zeros(1, Nwalkers); 

for i=1:length(t)
    
    sigma=sqrt(2*gamma*i*dt);
    
    for j=1:Nwalkers
          
        r(j)=sigma*randn(1);
%       r(j)=gaussiandist(gamma,i*dt);
        x(i,j)=x(i,j)+r(j);             
    end 
    
  g=x(i,:);
  
 figure(1)
 drawnow;
 numbins=100;
 histogram(g,numbins)
 grid on;
 
 title(['Time Step: ', num2str(i)]);
 xlabel('Position');
 ylabel('Frequency');
 axis([-200 200 0 350])
 grid on;
 
%  if mod(i,10)==0
%  % Check the total number of values in the histogram
%  total_values = histcounts(g, numbins);
%  
%  % Display the total number of values in the histogram at each time step
%  disp(['Time Step: ', num2str(i), ', Total Values in Histogram: ', num2str(sum(total_values))]);
%  end 
    
end 


% function ri=gaussiandist(gamma,tt)
% 
% k=1; %Initialization
% sigma=sqrt(2*gamma*tt);
% 
% gauss= @ (dx) exp(-dx^2/(2*sigma^2))/sqrt(2*pi*sigma^2);
% 
% while k<1e8
%     
%     u1=0.5*rand();
%     u2=6*sigma*rand()-3*sigma;
%     
%     if u1<=gauss(u2)
%         ri=u2;
%         break;
%     end
%     k=k+1;
% end
% 
% end