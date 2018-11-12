#bin/bash

    
    http_client() {
        curl --url 'http://votingapp:8080/vote' \
        --request $1 \
        --data "$2" \
        --header 'Content-Type: application/json' \
        --silent
    }

    topics='{"topics":["bash","python","go"]}'
    expectedWinner='bash'
    echo "Given vostings topics $topics, When vote for $options, Then winer is $expectedWinner"

    http_client POST $topics
    for option in bash bash bash python
    do  
        http_client PUT '{"topic":"'$option'"}'
    done
    winner=$(http_client DELETE | jq -r '.winner')

    if [ "$expectedWinner" = "$winner" ]; then
        echo TEST BASH RESULT: OK
        exit 0
    else 
        echo TEST BASH RESULT: FAIL 
        exit 1
    fi  
