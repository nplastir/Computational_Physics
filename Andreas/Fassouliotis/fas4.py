#gauss2
import numpy as np
import matplotlib.pyplot as plt
x=np.zeros(2)
y=np.zeros(2)
z=np.zeros(2)
sum=0
i=0
while i<2:
    x[i]=input("Enter x{} ".format(i))
    y[i]=input("enter y{} ".format(i))
    z[i]=input("Enter z{} ".format(i))
    i=i+1
print(x,y,z)
def f(x,y,z):
    return x*y+z
def g(s,t,u):
    return f(((x[1]-x[0])*s+x[1]+x[0])/2,((y[1]-y[0])*t+y[1]+y[0])/2,((z[1]-z[0])*u+z[1]+z[0])/2)
K=(x[1]-x[0])*(y[1]-y[0])*(z[1]-z[0])/8
print(K)
i=0
while i<2:
    x[i]=2*i-1
    y[i]=2*i-1
    z[i]=2*i-1
    i=i+1
print(x,y,z)
a=0.5773502692
for i in range(2):
    for j in range(2):
        for k in range(2):
            sum=sum + g(a*x[i],a*y[i],a*z[i])
            print(sum)
            print(i,j,k)
            k=k+1
        j=j+1
    i=i+1
integral=K*sum
print(integral)