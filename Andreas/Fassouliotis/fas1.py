import numpy as np
import matplotlib.pyplot as plt
from functools import partial
import sympy as sp
def f(x,y,z):
    return x*y+z/y
i=0
x=np.zeros(2)
y=np.zeros(2)
z=np.zeros(2)
while i<2:
    x[i]=input("Enter x{} ".format(i))
    y[i]=input("enter y{} ".format(i))
    z[i]=input("Enter z{} ".format(i))
    i=i+1
print(x,y,z)
i=0
j=0
k=0
sum=0
while i<2:
    while j<2:
        while k<2:
            sum=sum + f(x[i],y[i],z[i])
            k=k+1
        j=j+1
    i=i+1
integral=(x[1]-x[0])*(y[1]-y[0])*(z[1]-z[0])/8*sum
print(integral)