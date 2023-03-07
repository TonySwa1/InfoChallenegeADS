import pandas as pd
import plotly.express as px
import matplotlib.pyplot as plt
import numpy as np

data = pd.read_csv('dorian.csv',sep='~', error_bad_lines=False)
only = data[~data['text'].isna()]
print(only)


# data['timestamp'] = pd.to_datetime(data['timestamp'])
# data['date'] = data['timestamp'].dt.date
# data['counter'] = 1
# density = data['date'].value_counts()
# density = density.sort_index()
# print(density)

# fig = px.line(density,markers=True,title='Hurricane Dorian Time Density',labels={
#                      "index": "date",
#                      "value": "density"})
# fig.show()