import random
import numpy as np
import matplotlib.pyplot as plt
t=0
A=20
N=A
T=10000
b=100
a=100
k=1
s=1
W=k*(N+A)+b
tn=np.zeros(50)
def Dt(W,r):
    return -np.log(1-r)/W
while t<T:
    r1=random.random()
    r2=random.random()
    l= Dt(W,r1)
    t+= l
    tn[N]= tn[N]+l
    R=r2*W
    R=R-k*N
    if R<0:
        N=N-1
        W=W-k
        continue
    if s==0:
            s=1
            W=W+k*A+b-a
    else:
            R=R-k*A
            if R<0:
                N=N+1
                W=W+k
            else:
                s=0
                W=W-k*A+a-b
    print(W)

plt.bar(range(0,50),tn/t)
plt.show()