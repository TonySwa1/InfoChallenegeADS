
grep 'created_at' file.json | sed 's/,"/~"/g'> tolentino_tester.txt


echo 'timestamp~source~screen_name~location~coordinates~followers~friends~text~reply_count~retweet_count' > tolentino_tester.csv
cat tolentino_tester.txt | while read -r line
do
    printf '%s\n' "$line" > temptolentino.txt

    ## TimeStamp
    grep -E -o 'created_at":.* [0-9]{4}"~' temptolentino.txt | cut -d '~' -f1 | sed 's/$/~/' | tr -d '\n' | sed 's/created_at"://g'>> tolentino_tester.csv
    

    # ## Source
    grep -q 'a href' temptolentino.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o '\ba href=\\"http://.*.com\b' temptolentino.txt | cut -d "\\" -f2 | tr -d '\n' | sed 's/"http:/http/g' | sed 's/$/~/' >> tolentino_tester.csv; 
    else echo 'NaN~' | tr -d '\n' | sed 's/$/~/' >> tolentino_tester.csv ; 
    fi

    # ## Screen Name
    grep -q 'screen_name' temptolentino.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o 'screen_name":".*' temptolentino.txt | cut -d '~' -f1 | sed 's/$/~/' | tr -d '\n' | sed 's/screen_name":"//g' >> tolentino_tester.csv; 
    else echo 'NaN~' | tr -d '\n' >> tolentino_tester.csv | sed 's/"screen_name"://g'; 
    fi

    # ## Location
    grep -q 'region' temptolentino.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o 'region":.*' temptolentino.txt | cut -d '~' -f1 | sed 's/$/~/' | tr -d '\n' | sed 's/region"://g'>> tolentino_tester.csv; 
    else echo 'NaN~' | tr -d '\n' | sed 's/region"://g' >> tolentino_tester.csv ; 
    fi


    # ## Coordinates
    grep -q 'coordinates' temptolentino.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o '"coordinates":.*' temptolentino.txt | cut -d '~' -f1 | sed 's/$/~/' | tr -d '\n' | sed 's/"coordinates"://g'>> tolentino_tester.csv; 
    else echo 'NaN~' | tr -d '\n' | sed 's/"coordinates"://g'>> tolentino_tester.csv ; 
    fi

    # ## Follower and Friends Count
    grep -q 'followers_count' temptolentino.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o '"followers_count":.*' temptolentino.txt | cut -d '~' -f1,2 | sed 's/$/~/' | tr -d '\n' | sed 's/"followers_count"://g' | sed 's/"friends_count"://g'>> tolentino_tester.csv; 
    else echo 'NaN~' | tr -d '\n' | sed 's/"followers_count"://g'>> tolentino_tester.csv ; 
    fi
    # ## Extended Tweet
    grep -q 'full_text' temptolentino.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o '"full_text":".*' temptolentino.txt | cut -d '~' -f1 | sed 's/$/~/' | tr -d '\n' | sed 's/"full_text"://g'>> tolentino_tester.csv; 
    else echo 'NaN~' | tr -d '\n' | sed 's/"full_text"://g' >> tolentino_tester.csv ; 
    fi

    # ## Reply Count
    grep -q 'reply_count' temptolentino.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o '"reply_count":.*' temptolentino.txt | cut -d '~' -f1 | sed 's/$/~/' | tr -d '\n'| sed 's/"reply_count"://g' >> tolentino_tester.csv; 
    else echo 'NaN~' | tr -d '\n'| sed 's/"reply_count"://g' >> tolentino_tester.csv ; 
    fi
    
    ## Retweet Count
    grep -q 'retweet_count' temptolentino.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o '"retweet_count":.*' temptolentino.txt | cut -d '~' -f1 | sed 's/"retweet_count"://g'>> tolentino_tester.csv; 
    else echo 'NaN' | sed 's/"retweet_count"://g' >> tolentino_tester.csv ; 
    fi
done