#mag
import numpy as np
import matplotlib.pyplot as plt

B=4
v=[1,2,30]
N=1000
T=10
l=T/N
t=np.zeros(N)
x=np.zeros(N)
y=np.zeros(N)
z=np.zeros(N)
w=np.zeros((2,N))
k1=np.zeros(2)
k2=np.zeros(2)
k3=np.zeros(2)
k4=np.zeros(2)
w[0,0]=v[0]
w[1,0]=v[1]
def dvx(t,vx,vy):
    return vy*B
def dvy(t,vx,vy):
    return -vx*B
f=[dvx,dvy]
for j in range(N-1):
    for i in range(2):
        k1[i]=l*f[i](t[j],w[0,j],w[1,j])
    for i in range(2):
        k2[i]=l*f[i](t[j]+l/2,w[0,j]+k1[0]/2,w[1,j]+k1[1]/2)
    for i in range(2):
        k3[i]=l*f[i](t[j]+l/2,w[0,j]+k2[0]/2,w[1,j]+k2[1]/2)
    for i in range(2):
        k4[i]=l*f[i](t[j]+l,w[0,j]+k3[0],w[1,j]+k3[1])
    for i in range(2):
        w[i,j+1]=w[i,j]+1/6*(k1[i]+2*k2[i]+2*k3[i]+k4[i])
    x[j+1]=x[j]+w[0,j]*l
    y[j+1]=y[j]+w[1,j]*l
    z[j+1]=z[j]+v[2]*l
    t[j+1]=l+t[j]
k=np.zeros(N)
v2=np.zeros(N)
v2=w[0]**2+w[1]**2
v2_ave=sum(v2)/N
r_th_ave=np.sqrt(v2_ave)/B
ymax=max(y)
ymin=min(y)
xmax=max(x)
xmin=min(x)
x0=(xmax+xmin)/2
y0=(ymax+ymin)/2
r_ex=np.sqrt((x-x0)**2+(y-y0)**2)
r_ex_ave=sum(r_ex)/N
print(r_th_ave)
print(r_ex_ave)
print(x0,y0)
plt.plot(x,y)
plt.show()

