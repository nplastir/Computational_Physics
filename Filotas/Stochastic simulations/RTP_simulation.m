close all;
clc;
clear all;

myfunc=@(r,b) -log(1-r)/b;


N=10000;
a=1; b=1;
dt_values=zeros(N);

sum_odd=0; sum_even=0;

for i=0:N/2-1
    
    r1=rand;
    r2=rand;
    
    dt_values(2*i+1)=exp_dist(r1,b);
    dt_values(2*i+2)=exp_dist(r2,b);
    sum_odd=sum_odd+dt_values(2*i+1);
    sum_even=sum_even+dt_values(2*i_2);
    
end 
    
    mean=sum_dd/(sum_odd+sum_even);
    
    sentence('The mean value is equal to %g',mean);
    disp(sentence);
    
   
   







