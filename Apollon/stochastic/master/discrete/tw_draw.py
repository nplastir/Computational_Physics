import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
matplotlib.use('TkAgg')


df0 = pd.read_csv('data/twr-0.csv').query('N <= 42')

total_N0 = df0['P'].sum()
mean_N0 = (df0['N'] * df0['P']).sum() / total_N0

df0['poisson'] = np.array([
    mean_N0 / N
    for N in df0['N']
]).cumprod() * np.exp(-mean_N0) * total_N0

bar_kwargs = {
    'color': 'mediumseagreen',
    'width': 0.75
}

plt.figure(figsize = (5,5))

plt.grid(alpha = 0.5)

plt.bar(
    x = 'N', height = 'P', data = df0,
    **bar_kwargs
)

plt.plot('N', 'poisson', data = df0, color = 'darkblue')

plt.xlabel('N')
plt.ylabel('probability')

plt.legend(['poisson', 'simulation'])

plt.savefig('img/twr-0.png', bbox_inches = 'tight')


# --------------------------------------------------


def binomial(p, N, n):
    return np.math.factorial(N) / (
        np.math.factorial(n) * np.math.factorial(N - n)
    ) * (p ** n) * ((1 - p) ** (N - n))

df1 = pd.read_csv('data/twr-1.csv')

total_N1 = df1['P'].sum()
mean_N1 = (df1['N'] * df1['P']).sum() / total_N1

A = 20
p = mean_N1 / A

df1['binomial'] = np.array([
    binomial(p, A, n)
    for n in df1['N']
]) * total_N1

plt.figure(figsize = (5,5))

plt.grid(alpha = 0.5)

plt.bar(
    x = 'N', height = 'P', data = df1,
    **bar_kwargs
)

plt.plot('N', 'binomial', data = df1, color = 'darkblue')

plt.xlabel('N')
plt.ylabel('probability')

plt.legend(['binomial', 'simulation'])

plt.savefig('img/twr-1.png', bbox_inches = 'tight')