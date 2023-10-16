#simpson
import numpy as np
import matplotlib.pyplot as plt
def f(x,y,z):
    return x*y+z
i=0
x=np.zeros(3)
y=np.zeros(3)
z=np.zeros(3)
while i<3:
    x[i]=input("Enter x{} ".format(i))
    y[i]=input("enter y{} ".format(i))
    z[i]=input("Enter z{} ".format(i))
    i=i+2
def mo(x,y):
    return (x+y)/2
x[1]=mo(x[0],x[2])
y[1]=mo(y[0],y[2])
z[1]=mo(z[0],z[2])
print(x,y,z)
i=0
j=0
k=0
sum=0
n=1
m=1
l=1
for i in range(3):
    if i==1:
         n=4
    else:
         n=1 
    for j in range(3):
        if j==1:
                 m=4
        else:
                 m=1
        for k in range(3):
            if k==1:
                l=4
            else:
                  l=1
            sum=sum + n*m*l*f(x[i],y[i],z[i])
            print(sum)
            print(i,j,k)
            k=k+1
        j=j+1
    i=i+1
integral=(x[1]-x[0])*(y[1]-y[0])*(z[1]-z[0])/27*sum
print(integral)