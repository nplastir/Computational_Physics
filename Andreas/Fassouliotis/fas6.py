#prosa
import math
pi=math.pi
def gaussian_pdf(x, sigma, x0):
    tmp = (x - x0) / sigma
    return (1.0 / (math.sqrt(2 * math.pi) * abs(sigma))) * math.exp(-tmp * tmp / 2)

def func(x):
    value = 2*pi*x**4*(1+math.exp(x))
    value += 10000 * gaussian_pdf(x, 2., 32.)
    return value
def simpson(a, b):
    value = (b - a) / 6. * (func(a) + func(b) + 4. * func((a + b) / 2.))
    return value

def prosa(a, b, tol, N, inte):
    s0 = simpson(a, b)
    s1 = simpson(a, 0.5 * (a + b))
    s2 = simpson(0.5 * (a + b), b)
    L=s0-s1-s2
    K=tol*(s1+s2)*1/1000
    if abs(L) < K:
        inte += s1 + s2
    else:
        N += 1
        prosa(a, 0.5 * (a + b), 0.5 * tol, N, inte)
        prosa(0.5 * (a + b), b, 0.5 * tol, N, inte)
    return inte
def func1(x):
    value = 1-x**2
    value += 10000 * gaussian_pdf(x, 2., 32.)
    return value
def simpson1(a, b):
    value = (b - a) / 6. * (func1(a) + func1(b) + 4. * func1((a + b) / 2.))
    return value

def prosa1(a, b, tol, N, inte):
    s0 = simpson1(a, b)
    s1 = simpson1(a, 0.5 * (a + b))
    s2 = simpson1(0.5 * (a + b), b)
    L=s0-s1-s2
    K=tol*(s1+s2)*1/500
    if abs(L) < K:
        inte += s1 + s2
    else:
        N += 1
        prosa(a, 0.5 * (a + b), 0.5 * tol, N, inte)
        prosa(0.5 * (a + b), b, 0.5 * tol, N, inte)
    return inte

b=prosa1(-1,1,100,1,0)
print(b)
a=prosa(0,1,100,1,0)
print(a)
c=a*b
print(c)
