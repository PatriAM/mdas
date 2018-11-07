#bin/bash
set -e

image='votingapp'
#imageBuilder='votingapp-builder'
myAliasDocker=${REGISTRY:-'patristark'}

#docker build -t $imageBuilder .
#docker run $imageBuilder bash -c "./pipeline.sh"

docker build -t $myAliasDocker/$image -f ./src/votingapp/Dockerfile .
docker rm -f $image || true
docker run --name $image -d -p 8085:8080 $myAliasDocker/$image
docker push $myAliasDocker/$image
