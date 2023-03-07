import pandas as pd
import plotly.express as px
import nltk
from nltk.sentiment import SentimentIntensityAnalyzer
sia = SentimentIntensityAnalyzer()
import ast

data = pd.read_csv('florence.csv',sep='~', error_bad_lines=False)
data['timestamp'] = pd.to_datetime(data['timestamp'])
data['date'] = data['timestamp'].dt.date
only_data = data[~data['text'].isna()]
sentiment = []
dates = []
for i,row in only_data.iterrows():
    result = (sia.polarity_scores(row['text'])['compound'])
    sentiment.append(result)

newdata = only_data.assign(Sentiment = sentiment)
newdata['reply_count'] = newdata['reply_count'].astype(pd.Int64Dtype())
print(newdata.iloc[5]['reply_count'])
print(type(newdata.iloc[5]['reply_count']))


fig = px.scatter(newdata,x='reply_count',y='Sentiment')
fig.show()

