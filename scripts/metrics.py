import pandas as pd               
import numpy as np                 
import matplotlib.pyplot as plt     
import seaborn as sns               


# Histograms for each metric
metrics = ['SEAT_COMFORT', 'FOOD_AND_BEVERAGES', 'CABIN_STAFF_SERVICE',
           'INFLIGHT_ENTERTAINMENT', 'WIFI_AND_CONNECTIVITY', 'GROUND_SERVICE']

plt.figure(figsize=(14, 10))
for i, m in enumerate(metrics, 1):
    plt.subplot(3, 2, i)                                # 3x2 grid
    sns.histplot(df[m].dropna(), kde=True, bins=20)     # histogram + KDE
    plt.title(f'Distribution: {m}')
plt.tight_layout()
plt.show()


# Boxplots to compare metrics across cabin groups
plt.figure(figsize=(14, 10))
for i, m in enumerate(metrics, 1):
    plt.subplot(3, 2, i)
    sns.boxplot(x='CABIN_GROUP', y=m, data=df)
    plt.title(f'{m} by Cabin Group')
plt.tight_layout()
plt.show()