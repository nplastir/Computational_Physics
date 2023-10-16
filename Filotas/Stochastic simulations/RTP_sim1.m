clear all;

global a b 

N=10000;
a=9;
b=5;


sum_odd=0; sum_even=0;
Nt=round(N/2)-1;

exp_dist= @(r,w) -log(1-r)/w;

for i=0:Nt
    r1=random('uniform',0,1);
    r2=random('uniform',0,1);
    
    dt(2*i+1)=exp_dist(r1,b);
    dt(2*i+2)=exp_dist(r2,a);

    
    sum_odd=sum_odd+dt(2*i+1);
    sum_even=sum_even+dt(2*i+2);
end 

    mesos=a/(a+b);
    mean=sum_odd/(sum_odd+sum_even); 
    sentence=sprintf('With parameter values a=%g, b=%g , <Nsim>=%g while <N>=%g',a,b,mean,mesos);
    disp(sentence);
    
    
