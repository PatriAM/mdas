set -e

builder_image='votingapp-builder'
image='votingapp'
registry=${REGISTRY:-'patristark'}

docker build -t $builder_image .
docker run -v $(pwd):/app -w /app $builder_image bash -c "./pipeline.sh"

docker build -t $registry/$image ./src/votingapp
docker rm -f $image || true
docker run --name $image -d -p 8085:8080 $registry/$image
docker push $registry/$image
