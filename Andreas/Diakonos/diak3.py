import random
import numpy as np
import matplotlib.pyplot as plt
t=0
A=20
N=0
T=10000
k=1
W=k*(N+A)
tn=np.zeros(50)
def Dt(W,r):
    return -np.log(1-r)/W
while t<T:
    r1=random.random()
    r2=random.random()
    l= Dt(W,r1)
    t+= l
    tn[N]= tn[N]+l
    ratio=A/(A+N)
    if r2>ratio:
        N=N-1
        A=A+1
    else:
        N=N+1
        A=A-1
plt.bar(range(0,50),tn/t)
plt.show()
    







