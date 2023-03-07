files=$(find dorian -name '*.json' -type f)
echo 'timestamp~source~screen_name~location~coordinates~followers~friends~text~reply_count~retweet_count' > bennett_tester.csv


for file in $files
do
grep 'created_at' $file | sed 's/,"/~"/g'> bennett_tester.txt
echo $file

cat bennett_tester.txt | while read -r line
do
    printf '%s\n' "$line" > temphuffman.txt

    ## TimeStamp
    grep -E -o 'created_at":.* [0-9]{4}"~' temphuffman.txt | cut -d '~' -f1 | sed 's/$/~/' | tr -d '\n' | sed 's/created_at"://g'>> bennett_tester.csv
    

    # ## Source
    grep -q 'a href' temphuffman.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o '\ba href=\\"http://.*.com\b' temphuffman.txt | cut -d "\\" -f2 | tr -d '\n' | sed 's/"http:/http/g' | sed 's/$/~/' >> bennett_tester.csv; 
    else echo 'NaN~' | tr -d '\n' | sed 's/$/~/' >> bennett_tester.csv ; 
    fi

    # ## Screen Name
    grep -q 'screen_name' temphuffman.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o 'screen_name":".*' temphuffman.txt | cut -d '~' -f1 | sed 's/$/~/' | tr -d '\n' | sed 's/screen_name":"//g' >> bennett_tester.csv; 
    else echo 'NaN~' | tr -d '\n' >> bennett_tester.csv | sed 's/"screen_name"://g'; 
    fi

    # ## Location
    grep -q 'region' temphuffman.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o 'region":.*' temphuffman.txt | cut -d '~' -f1 | sed 's/$/~/' | tr -d '\n' | sed 's/region"://g'>> bennett_tester.csv; 
    else echo 'NaN~' | tr -d '\n' | sed 's/region"://g' >> bennett_tester.csv ; 
    fi


    # ## Coordinates
    grep -q 'coordinates' temphuffman.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o '"coordinates":.*' temphuffman.txt | cut -d '~' -f1 | sed 's/$/~/' | tr -d '\n' | sed 's/"coordinates"://g'>> bennett_tester.csv; 
    else echo 'NaN~' | tr -d '\n' | sed 's/"coordinates"://g'>> bennett_tester.csv ; 
    fi

    # ## Follower and Friends Count
    grep -q 'followers_count' temphuffman.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o '"followers_count":.*' temphuffman.txt | cut -d '~' -f1,2 | sed 's/$/~/' | tr -d '\n' | sed 's/"followers_count"://g' | sed 's/"friends_count"://g'>> bennett_tester.csv; 
    else echo 'NaN~' | tr -d '\n' | sed 's/"followers_count"://g'>> bennett_tester.csv ; 
    fi
    # ## Extended Tweet
    grep -q 'full_text' temphuffman.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o '"full_text":".*' temphuffman.txt | cut -d '~' -f1 | sed 's/$/~/' | tr -d '\n' | sed 's/"full_text"://g'>> bennett_tester.csv; 
    else echo 'NaN~' | tr -d '\n' | sed 's/"full_text"://g' >> bennett_tester.csv ; 
    fi

    # ## Reply Count
    grep -q 'reply_count' temphuffman.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o '"reply_count":.*' temphuffman.txt | cut -d '~' -f1 | sed 's/$/~/' | tr -d '\n'| sed 's/"reply_count"://g' >> bennett_tester.csv; 
    else echo 'NaN~' | tr -d '\n'| sed 's/"reply_count"://g' >> bennett_tester.csv ; 
    fi
    
    ## Retweet Count
    grep -q 'retweet_count' temphuffman.txt
    if [ $? -eq 0 ] ; 
    then grep -E -o '"retweet_count":.*' temphuffman.txt | cut -d '~' -f1 | sed 's/"retweet_count"://g'>> bennett_tester.csv; 
    else echo 'NaN' | sed 's/"retweet_count"://g' >> bennett_tester.csv ; 
    fi

done
done