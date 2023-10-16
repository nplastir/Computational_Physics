#gauss3
import numpy as np
import matplotlib.pyplot as plt

def f(x,y,z):
    return 1+x**2+2*y**2+3*z**2
def fx(x,y,z):
    return x+x**3+2*x*y**2+3*x*z**2
def fy(x,y,z):
    return y+x**2*y+2*y**3+3*y*z**2
def fz(x,y,z):
    return z+x**2*z+2*y**2*z+3*z**3
a=0
b=1
n=100
h=(b-a)/n
an=np.zeros(101)
for i in range(101):
    an[i]=a+i*h
    i=i+1
tn=np.zeros(3)
xn=np.zeros(3)
yn=np.zeros(3)
zn=np.zeros(3)
R=np.zeros(3)
tn[0]=-(3/5)**0.5
tn[1]=0
tn[2]=(3/5)**0.5
i=0
def g(y,z):
    integral1=0
    for i in range(100):
        xn[0]=((an[i+1]-an[i])*tn[0]+an[i]+an[i+1])/2
        xn[1]=((an[i+1]-an[i])*tn[1]+an[i]+an[i+1])/2
        xn[2]=((an[i+1]-an[i])*tn[2]+an[i]+an[i+1])/2        
        integral1=integral1+(an[i+1]-an[i])/2*(f(xn[0],y,z)/1.8+f(xn[1],y,z)/1.125+f(xn[2],y,z)/1.8)
        i=i+1
    return integral1
def h(z):
    integral2=0
    for i in range(100):
        yn[0]=((an[i+1]-an[i])*tn[0]+an[i]+an[i+1])/2
        yn[1]=((an[i+1]-an[i])*tn[1]+an[i]+an[i+1])/2
        yn[2]=((an[i+1]-an[i])*tn[2]+an[i]+an[i+1])/2
        integral2=integral2+(an[i+1]-an[i])/2*(g(yn[0],z)/1.8+g(yn[1],z)/1.125+g(yn[2],z)/1.8)
        i=i+1
    return integral2
integral3=0
i=0
for i in range(100):
    zn[0]=((an[i+1]-an[i])*tn[0]+an[i]+an[i+1])/2
    zn[1]=((an[i+1]-an[i])*tn[1]+an[i]+an[i+1])/2
    zn[2]=((an[i+1]-an[i])*tn[2]+an[i]+an[i+1])/2
    integral3=integral3+(an[i+1]-an[i])/2*(h(zn[0])/1.8+h(zn[1])/1.125+h(zn[2])/1.8)
    i=i+1
M=integral3
print(M)
def gx(y,z):
    integral1=0
    for i in range(100):
        xn[0]=((an[i+1]-an[i])*tn[0]+an[i]+an[i+1])/2
        xn[1]=((an[i+1]-an[i])*tn[1]+an[i]+an[i+1])/2
        xn[2]=((an[i+1]-an[i])*tn[2]+an[i]+an[i+1])/2        
        integral1=integral1+(an[i+1]-an[i])/2*(fx(xn[0],y,z)/1.8+fx(xn[1],y,z)/1.125+fx(xn[2],y,z)/1.8)
        i=i+1
    return integral1
def hx(z):
    integral2=0
    for i in range(100):
        yn[0]=((an[i+1]-an[i])*tn[0]+an[i]+an[i+1])/2
        yn[1]=((an[i+1]-an[i])*tn[1]+an[i]+an[i+1])/2
        yn[2]=((an[i+1]-an[i])*tn[2]+an[i]+an[i+1])/2
        integral2=integral2+(an[i+1]-an[i])/2*(gx(yn[0],z)/1.8+gx(yn[1],z)/1.125+gx(yn[2],z)/1.8)
        i=i+1
    return integral2
integral3=0
i=0
for i in range(100):
    zn[0]=((an[i+1]-an[i])*tn[0]+an[i]+an[i+1])/2
    zn[1]=((an[i+1]-an[i])*tn[1]+an[i]+an[i+1])/2
    zn[2]=((an[i+1]-an[i])*tn[2]+an[i]+an[i+1])/2
    integral3=integral3+(an[i+1]-an[i])/2*(hx(zn[0])/1.8+hx(zn[1])/1.125+hx(zn[2])/1.8)
    i=i+1
print(integral3)
Rx=integral3
R[0]=Rx/M
def gy(y,z):
    integral1=0
    for i in range(100):
        xn[0]=((an[i+1]-an[i])*tn[0]+an[i]+an[i+1])/2
        xn[1]=((an[i+1]-an[i])*tn[1]+an[i]+an[i+1])/2
        xn[2]=((an[i+1]-an[i])*tn[2]+an[i]+an[i+1])/2        
        integral1=integral1+(an[i+1]-an[i])/2*(fy(xn[0],y,z)/1.8+fy(xn[1],y,z)/1.125+fy(xn[2],y,z)/1.8)
        i=i+1
    return integral1
def hy(z):
    integral2=0
    for i in range(100):
        yn[0]=((an[i+1]-an[i])*tn[0]+an[i]+an[i+1])/2
        yn[1]=((an[i+1]-an[i])*tn[1]+an[i]+an[i+1])/2
        yn[2]=((an[i+1]-an[i])*tn[2]+an[i]+an[i+1])/2
        integral2=integral2+(an[i+1]-an[i])/2*(gy(yn[0],z)/1.8+gy(yn[1],z)/1.125+gy(yn[2],z)/1.8)
        i=i+1
    return integral2
integral3=0
i=0
for i in range(100):
    zn[0]=((an[i+1]-an[i])*tn[0]+an[i]+an[i+1])/2
    zn[1]=((an[i+1]-an[i])*tn[1]+an[i]+an[i+1])/2
    zn[2]=((an[i+1]-an[i])*tn[2]+an[i]+an[i+1])/2
    integral3=integral3+(an[i+1]-an[i])/2*(hy(zn[0])/1.8+hy(zn[1])/1.125+hy(zn[2])/1.8)
    i=i+1
print(integral3)
Ry=integral3
R[1]=Ry/M
def gz(y,z):
    integral1=0
    for i in range(100):
        xn[0]=((an[i+1]-an[i])*tn[0]+an[i]+an[i+1])/2
        xn[1]=((an[i+1]-an[i])*tn[1]+an[i]+an[i+1])/2
        xn[2]=((an[i+1]-an[i])*tn[2]+an[i]+an[i+1])/2        
        integral1=integral1+(an[i+1]-an[i])/2*(fz(xn[0],y,z)/1.8+fz(xn[1],y,z)/1.125+fz(xn[2],y,z)/1.8)
        i=i+1
    return integral1
def hz(z):
    integral2=0
    for i in range(100):
        yn[0]=((an[i+1]-an[i])*tn[0]+an[i]+an[i+1])/2
        yn[1]=((an[i+1]-an[i])*tn[1]+an[i]+an[i+1])/2
        yn[2]=((an[i+1]-an[i])*tn[2]+an[i]+an[i+1])/2
        integral2=integral2+(an[i+1]-an[i])/2*(gz(yn[0],z)/1.8+gz(yn[1],z)/1.125+gz(yn[2],z)/1.8)
        i=i+1
    return integral2
integral3=0
i=0
for i in range(100):
    zn[0]=((an[i+1]-an[i])*tn[0]+an[i]+an[i+1])/2
    zn[1]=((an[i+1]-an[i])*tn[1]+an[i]+an[i+1])/2
    zn[2]=((an[i+1]-an[i])*tn[2]+an[i]+an[i+1])/2
    integral3=integral3+(an[i+1]-an[i])/2*(hz(zn[0])/1.8+hz(zn[1])/1.125+hz(zn[2])/1.8)
    i=i+1
print(integral3)
Rz=integral3
R[2]=Rz/M
print(R)