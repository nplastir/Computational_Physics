clear all;
close all;
clc;

%Πιθανότητα για αριθμό μαθητών Nstudent=23 
Nstudent=23;
z=studentspropability(Nstudent);
fprintf('The propability that 2 or more students have the same birthday date for a multitude of N=%g students is p=%g',Nstudent,z);


%%

%Γράφημα Θεωρητικής - Υπολογιστικής πιθανότητας 
clear z Nstudent;

%Θεωρητική πιθανότητα για Nstudent=0 εώς Nstudent=100

P=zeros(1,100);

for Nstudent=1:100
    multi=1;
    
for n=1:Nstudent 
  multi=multi*(365-n+1)/365; 
end 

figure(1)
hold on;
P(Nstudent)=1-multi;
plot(Nstudent,P(Nstudent),'-o')
end 

%Υπολογιστική πιθανότητα για Nstudent=1 εώς Nstudent=100

 for Nstudent=1:100
     z(Nstudent)=studentspropability(Nstudent);
 end 
 
   figure(1)
   plot(z,'r')
   legend('Theoretical Propability Distribution','Monte Carlo Propability Dist.')