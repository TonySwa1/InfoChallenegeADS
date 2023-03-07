import pandas as pd
from nltk import tokenize
from nltk.classify import NaiveBayesClassifier
from nltk.corpus import subjectivity
from nltk.sentiment import SentimentAnalyzer
from nltk.sentiment.util import *
n_instances = 100
subj_docs = [(sent, 'subj') for sent in subjectivity.sents(categories='subj')[:n_instances]]
obj_docs = [(sent, 'obj') for sent in subjectivity.sents(categories='obj')[:n_instances]]
len(subj_docs), len(obj_docs)
from nltk import tokenize



data = pd.read_csv('florence.csv',sep='~', error_bad_lines=False)
paragraph = (data['text'])
print(paragraph)
lines_list = tokenize.sent_tokenize(paragraph)

# for text in paragraph:
#     sid = SentimentIntensityAnalyzer()
#     print(sentence)
#     ss = sid.polarity_scores(sentence)
#     for k in sorted(ss):
#     print('{0}: {1}, '.format(k, ss[k]), end='')
#     print()


