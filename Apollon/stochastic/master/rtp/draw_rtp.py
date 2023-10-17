import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
matplotlib.use('TkAgg')

# kdf_1M = pd.read_csv('data/k-1M.csv')
# kdf_100K = pd.read_csv('data/k-100K.csv')
# kdf_10K = pd.read_csv('data/k-10K.csv')
# kdf = pd.DataFrame({
#     'tau': kdf_1M['tau'],
#     'k1M': kdf_1M['kappa'],
#     'k100K': kdf_100K['kappa'],
#     'k10K': kdf_10K['kappa']
# })
# kdf.to_csv('data/k-0.csv', index = False)

kdf = pd.read_csv('data/k-0.csv')

lw = 1.5

plt.figure(figsize = (7,5))
plt.grid(alpha = 0.3)
plt.axhline(y = 0, linewidth = lw / 2)

l10K = plt.plot(
    'tau', 'k10K', data = kdf, 
    color = 'darkblue', linewidth = lw, label = 'N=10 000'
)
# l100K = plt.plot('tau', 'k100K', data = kdf, color = 'blue', linewidth = lw)
l1M = plt.plot(
    'tau', 'k1M', data = kdf, 
    color = 'orange', linewidth = lw, label = 'N=1 000 000'
)

plt.xlabel('τ [sec]')
plt.ylabel('κ(τ)')

plt.legend()

plt.subplots_adjust(
    left = 0.13,
    right = 0.95,
    bottom = 0.10,
    top = 0.95
)
plt.savefig('img/k-0.png')

# kdf_1M = pd.read_csv('data/k-short-1M.csv')
# kdf_10K = pd.read_csv('data/k-short-10K.csv')
# kdf = pd.DataFrame({
#     'tau': kdf_1M['tau'],
#     'k1M': kdf_1M['kappa'],
#     'k10K': kdf_10K['kappa']
# })
# kdf.to_csv('data/k-short-0.csv', index = False)

kdf_short = pd.read_csv('data/k-short-10K.csv')

plt.figure(figsize = (7,5))
plt.grid(alpha = 0.3)
plt.axhline(y = 0, linewidth = lw / 2)

plt.plot(
    'tau', 'kappa', data = kdf_short, 
    color = 'royalblue', linewidth = lw,
    label = 'N=1 000 000'
)
plt.xlabel('τ [sec]')
plt.ylabel('κ(τ)')

plt.subplots_adjust(
    left = 0.11,
    right = 0.95,
    bottom = 0.10,
    top = 0.95
)
plt.savefig('img/k-short-10K.png')
