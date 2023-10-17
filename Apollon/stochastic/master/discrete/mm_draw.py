import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
matplotlib.use('TkAgg')


dfAB0 = pd.read_csv('data/mm-AB-0.csv').query('N < 30')

total_N0 = dfAB0['P'].sum()
mean_N0 = (dfAB0['N'] * dfAB0['P']).sum() / total_N0

dfAB0['poisson'] = np.array([
    mean_N0 / N
    for N in dfAB0['N']
]).cumprod() * np.exp(-mean_N0) * total_N0

bar_kwargs = {
    'color': 'mediumseagreen',
    'width': 0.75
}

plt.figure(figsize = (7,5))
plt.grid(alpha = 0.5)

plt.bar(
    x = 'N', height = 'P', data = dfAB0,
    **bar_kwargs
)

plt.plot(
    'N', 'poisson', data = dfAB0, 
    color = 'darkblue', linewidth = 2
)

plt.xlabel('N')
plt.ylabel('probability')

plt.legend(['poisson', 'simulation'])

plt.title('Michaelis-Menten (a = b = 50, k = 1)')

plt.savefig('img/mm-high-ab-0.png', bbox_inches = 'tight')


# --------------------------------------------------------

def normalize_prob(P):
    return P / P.max()

dfab0 = pd.read_csv('data/mm-ab-0.csv')

df_tot_0 = pd.DataFrame({
    'N':  dfab0['N'],
    'ab': normalize_prob(dfab0['P']),
    'Ab': normalize_prob(pd.read_csv('data/mm-Ab-0.csv')['P']),
    'aB': normalize_prob(pd.read_csv('data/mm-aB-0.csv')['P'])
}).query('N <= 40')

plt.figure(figsize = (7,5))
plt.grid(alpha = 0.5)

plt.xlabel('N')
plt.ylabel(r'$P\,\,/\,\,P_{max}$')


def make_histo(
    x_name, y_name, data = df_tot_0, 
    color = 'red', linewidth = 1.5, fill_alpha = 0.15,
    label = ''
):
    x = np.concatenate((np.array([data[x_name][0]]), data[x_name])) - 0.5
    y = np.concatenate((np.array([0]), data[y_name]))

    plt.fill_between(
        x, y, 
        color = color, alpha = fill_alpha, step = 'post',
        label = label
    )
    plt.step(
        x, y, 
        color = color, linewidth = linewidth, where = 'post'
    )



make_histo(
    'N', 'Ab', color = 'orangered', 
    label = 'a = 1.75, b = 0.25'
)
make_histo(
    'N', 'ab', color = 'royalblue', 
    label = 'a = 1, b = 1'
)
make_histo(
    'N', 'aB', color = 'green', 
    label = 'a = 0.25, b = 1.75'
)

plt.legend()

plt.title('Michaelis-Menten (k = 1)')

plt.savefig('img/mm-tot-0.png', bbox_inches = 'tight')