import numpy as np
import pandas as pd
from matplotlib import use, pyplot as plt
use('TkAgg')

def gauss(x, mu, sigma):
    return np.exp(
        - 0.5 * (x - mu) ** 2 / sigma
    ) / (np.sqrt(2 * np.pi * sigma))


df0 = pd.read_csv('data/sc-1.csv').query('N < 40')

total_P = df0['P'].sum()
df0['P'] = df0['P'] / total_P

mean_N = (df0['N'] * df0['P']).sum()
mean_N2 = ((df0['N'] ** 2) * df0['P']).sum()
sigma_N = np.sqrt(mean_N2 - mean_N ** 2)
sigma_N = 18.55815208780317 # for a = 20

V = 1; a = 20

df0['gauss_th'] = gauss(df0['N'], a - 1, a * V)

df0['gauss_num'] = gauss(df0['N'], mean_N, sigma_N)

bar_kwargs = {
    'color': 'mediumseagreen',
    'width': 0.75
}

plt.figure(figsize = (7,5))

plt.grid(alpha = 0.5)

plt.bar(
    x = 'N', height = 'P', data = df0,
    **bar_kwargs
)
lw = 2.5
plt.plot(
    'N', 'gauss_th', data = df0, 
    color = 'red', linewidth = lw
)
plt.plot(
    'N', 'gauss_num', data = df0, 
    color = 'darkblue', linewidth = lw
)

plt.xlabel('N')
plt.ylabel('probability')

plt.legend([
    'gauss (theoretial)', 
    'gauss (numerical)',
    'simulation'
])

plt.title(f'Schlögl model (V = {V}, a = {a})')

plt.savefig('img/sc-1.png', bbox_inches = 'tight')



# -------------------------------------------------



df1 = pd.read_csv('data/sc-2.csv').query('20 < N < 80')

total_P = df1['P'].sum()
df1['P'] = df1['P'] / total_P

mean_N = (df1['N'] * df1['P']).sum()
mean_N2 = ((df1['N'] ** 2) * df1['P']).sum()
sigma_N = np.sqrt(mean_N2 - mean_N ** 2)
sigma_N = 47.462355681370035 # for a = 50

V = 1; a = 50

df1['gauss_th'] = gauss(df1['N'], a - 1, a * V)

df1['gauss_num'] = gauss(df1['N'], mean_N, sigma_N)

bar_kwargs = {
    'color': 'mediumseagreen',
    'width': 0.75
}

plt.figure(figsize = (7,5))

plt.grid(alpha = 0.5)

plt.bar(
    x = 'N', height = 'P', data = df1,
    **bar_kwargs
)
lw = 2.5
plt.plot(
    'N', 'gauss_th', data = df1, 
    color = 'red', linewidth = lw
)
plt.plot(
    'N', 'gauss_num', data = df1, 
    color = 'darkblue', linewidth = lw
)

plt.xlabel('N')
plt.ylabel('probability')

plt.legend([
    'gauss (theoretial)', 
    'gauss (numerical)',
    'simulation'
])

plt.title(f'Schlögl model (V = {V}, a = {a})')

plt.savefig('img/sc-2.png', bbox_inches = 'tight')