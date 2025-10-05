import pandas as pd                
import numpy as np                 
import matplotlib.pyplot as plt    
import seaborn as sns               

# Create a boxplot to visualize distribution of ratings by cabin class
sns.boxplot(x="CABIN_GROUP", y="AVERAGE_RATING", data=df)

# Add a title for clarity
plt.title("Rating Distribution by Cabin Class")

# Show the plot
plt.show()