import pandas as pd
import re
fh = pd.read_csv("dorian.csv",sep='~', error_bad_lines=False)
POSITIVE_TWEETS= []
TWITTER = {}
NEWTWITTER = {}
INSTA = {}
NEWINSTA = {}
SND = {}
NEWSND ={}
SF = {}
NEWSF = {}
#gets rows that are not NaN in the text column
only = fh[~fh['text'].isna()]
	
DICT = pd.Series(only.source.values,index=only.text).to_dict()
orgtotal = (len(only))

#loops through the values and finds if the text is from twitter
for key,value in DICT.items():
    for social in re.findall(r"twitter.com", value):
        TWITTER[key] = social
orgtwitter = len(TWITTER)

#loops through the values and finds if the text is from instagram
for key,value in DICT.items():
    for social in re.findall(r"instagram.com", value):
        INSTA[key] = social
orginstagram = len(INSTA)


#loops through the values and finds if the text is from socialnewsdesk
for key,value in DICT.items():
    for social in re.findall(r"socialnewsdesk.com", value):
        SND[key] = social
orgSND = len(SND)

#loops through the values and finds if the text is from socialnewsdesk
for key,value in DICT.items():
    for social in re.findall(r"socialflow.com", value):
        SF[key] = social
orgSF = len(SF)

#importing nltk sentiment analyzer to find useful tweets
import nltk
from nltk.sentiment import SentimentIntensityAnalyzer
sia = SentimentIntensityAnalyzer()

def is_positive(tweet: str) -> bool:
    """True if tweet has positive compound sentiment, False otherwise."""
    try:
        return sia.polarity_scores(tweet)["compound"] > 0
    except AttributeError:
        print("error")

#loops through all the text to find tweets that are not positive and deletes them
for tweet in only["text"]:
    if is_positive(tweet) == False:
        # POSITIVE_TWEETS.append(tweet)
        try:
            del DICT[tweet]
        except KeyError:
            continue

for tweet, web in TWITTER.items():
  if is_positive(tweet) == True:
        # POSITIVE_TWEETS.append(tweet)
        try:
            NEWTWITTER[tweet] = web
        except KeyError:
            continue
        except:
            continue
twittergood = len(NEWTWITTER)

for tweet, web in INSTA.items():
  if is_positive(tweet) == True:
        # POSITIVE_TWEETS.append(tweet)
        try:
            NEWINSTA[tweet] = web
        except KeyError:
            continue
        except:
            continue
instagood = len(NEWINSTA)

for tweet, web in SND.items():
  if is_positive(tweet) == True:
        # POSITIVE_TWEETS.append(tweet)
        try:
            NEWSND[tweet] = web
        except KeyError:
            continue
        except:
            continue
SNDgood = len(NEWSND)

for tweet, web in SF.items():
  if is_positive(tweet) == True:
        # POSITIVE_TWEETS.append(tweet)
        try:
            NEWSF[tweet] = web
        except KeyError:
            continue
        except:
            continue
SFgood = len(NEWSF)

#getting the percentages of all the different social media
usefultotal = (len(DICT))
totalpercentage = round(usefultotal/orgtotal * 100,2)
twitterpercentage = round(twittergood/orgtwitter * 100,2)
instagrampercentage = round(instagood/orginstagram * 100,2)
SNDpercent = round(SNDgood/orgSND * 100,2)
SFpercent = round(SFgood/orgSF * 100,2) 
PERCENTS = [twitterpercentage, instagrampercentage, SNDpercent, SFpercent]



print("The percentage of useful information in total is", totalpercentage, "%")
print("The percentage of useful tweets for twitter is", twitterpercentage, "%")
print("The percentage of useful tweets for instagram is", instagrampercentage, "%")
print("The percentage of useful tweets for socialnewsdesk is", SNDpercent, "%")
print("The percentage of useful tweets for socialflow is", SFpercent, "%")

import matplotlib.pyplot as plt



#graphing the stacked bar graph
USEFUL = [twittergood, instagood,SNDgood, SFgood]
NOTUSEFUL = [(orgtwitter-twittergood),(orginstagram-instagood),(orgSND-SNDgood), (orgSF-SFgood)]
SOCIALS = ["Twitter", "Instagram", "SocialNewsDesk", "SocialFlow"]
plt.bar(SOCIALS, USEFUL, color='r')
graph = plt.bar(SOCIALS, NOTUSEFUL, bottom=USEFUL, color='b')
plt.xlabel("Social Media")
plt.ylabel("Number of Posts")
plt.legend(["Useful", "Not Useful"])
plt.title("Usefulness of Information from Social Media: Hurricane Dorian")

#adds the percentages to each column
i = 0
for p in graph:
    width = p.get_width()
    height = p.get_height()
    x, y = p.get_xy()
    plt.text(x+width/2,
             y+height*1.01,
             str(PERCENTS[i])+'%',
             ha='center',
             weight='bold')
    i+=1
plt.savefig("dorianstackedgraph.png")


