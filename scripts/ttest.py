from scipy import stats              # t-test
import pandas as pd
import numpy as np

# Metrics to test
metrics = ['SEAT_COMFORT', 'FOOD_AND_BEVERAGES', 'CABIN_STAFF_SERVICE',
           'INFLIGHT_ENTERTAINMENT', 'WIFI_AND_CONNECTIVITY', 'GROUND_SERVICE']
def ttest_econ_vs_non(df, metric):
    econ = df.loc[df['CABIN_GROUP']=='Economy', metric].dropna()
    non = df.loc[df['CABIN_GROUP']=='Non-Economy', metric].dropna()
    tstat, pvalue = stats.ttest_ind(econ, non, equal_var=False)  # Welch's t-test
    return tstat, pvalue, len(econ), len(non)

# Run tests for all metrics and display
results = []
for m in metrics:
    t, p, n_e, n_ne = ttest_econ_vs_non(df, m)
    results.append({'metric': m, 't_stat': t, 'p_value': p, 'n_econ': n_e, 'n_non': n_ne})

pd.DataFrame(results)