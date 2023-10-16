import random
import numpy as np
import matplotlib.pyplot as plt
a=1000
V=1
Ns=V*(a-1)
e=1e-8
imax=1000

s2=np.zeros(imax)
s0=np.zeros(imax)
P=np.zeros(imax+Ns)
s0[0]=1
P[Ns]=1
d=1
N=Ns
i=0

while d>e and i<imax-1:
    P[N+1]=(a*N)*P[N]/(N+1)/(1+N/V)
    N=N+1
    s2[i+1]=s2[i]+(N-Ns)**2*P[N]
    s0[i+1]=s0[i]+P[N]
    d=s2[i+1]-s2[i]
    i=i+1
print(i)
S2=s2[i]
S0=s0[i]

s2=np.zeros(imax)
s0=np.zeros(imax)
P=np.zeros(Ns+1)
s0[0]=1
P[Ns]=1
d=1
N=Ns
i=0

while d>e and i<imax-1 and N>1:
    P[N-1]=P[N]*N*(1+(N-1)/V)/a/(N-1)
    N=N-1
    s2[i+1]=s2[i]+(N-Ns)**2*P[N]
    s0[i+1]=s0[i]+P[N]
    d=s2[i+1]-s2[i]
    i=i+1
print(i)
S2=s2[i]+S2
S0=s0[i]+S0
var=S2/S0
varth=a*V
div=(var-varth)/varth
print(var)
print(div*100)
