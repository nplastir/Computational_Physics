import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
matplotlib.use('TkAgg')

df0 = pd.read_csv('data/pc-0.csv')

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

plt.figure(figsize = (7,5))

plt.grid(alpha = 0.5)

plt.bar(
    x = 'N', height = 'P', data = df0,
    **bar_kwargs
)

plt.plot(
    'N', 'poisson', data = df0, 
    color = 'darkblue', linewidth = 2
)

plt.xlabel('N')
plt.ylabel('probability')

plt.legend(['poisson', 'simulation'])

plt.savefig('img/pc-0.png', bbox_inches = 'tight')