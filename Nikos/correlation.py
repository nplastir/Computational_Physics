import random
import numpy as np
import matplotlib.pyplot as plt

def exp_dist(b,r):
    return -np.log(1-r)/b

N=100000
a=1
b=1
sum_odd=0; sum_even=0

t=np.zeros(N)
t[0]=0

dt=np.zeros(N)

for m in range(N//2-1):
    r1=random.random()
    r2=random.random()

    t[2*m+1]=t[2*m]+exp_dist(b,r1)
    t[2*m+2]=t[2*m+1]+exp_dist(a,r2)

    dt[2*m+1]=t[2*m+1]-t[2*m]
    dt[2*m+2]=t[2*m+2]-t[2*m+1]

    sum_odd+=dt[2*m+1]
    sum_even+=dt[2*m+2]

mean= sum_odd/(sum_even+sum_odd)
print(mean)

def kapa(l):
    sum=0
    for m in range(N//2-1):
        a=t[2*m]
        b=t[2*m+1]

        for k in range(m,N//2-1):
            c=t[2*k]-l
            d=t[2*k+1]-l
            if b>c:
                if a<d:
            
                    if c<=a:
                        if d<=b:
                            dias=d-a
                        else:
                            dias=b-a
                    else:
                        if d<=b:
                            dias=d-c
                        else:
                            dias=b-c
                    sum+=dias
                else:
                    sum+=0
            else:
                break
        mean2=sum/(sum_even+sum_odd)
    return mean2-mean**2

tau_values = np.linspace(0.1, 5, 1000)
k_values = [kapa(tau) for tau in tau_values]
klisi=(np.log(kapa(2.5))-np.log(kapa(1.5)))
print (klisi)
plt.plot(tau_values, k_values)

plt.show()