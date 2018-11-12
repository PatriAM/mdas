#bin/bash
set -e

image='votingapp'
myAliasDocker=${REGISTRY:-'patristark'}
network="votingapp-network"

docker network create $network || true

#BUILD
docker build -t $myAliasDocker/$image ./src/votingapp

#INTEGRATION TEST
docker rm -f $image || true
docker run --name $image -d --network $network $myAliasDocker/$image

docker build -t votingapp-test ./test
docker run --rm --network $network -e VOTING_URL="http://$image:8080/vote" votingapp-test

#DELIVERY
docker push $myAliasDocker/$image
