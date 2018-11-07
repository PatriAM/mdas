#builder
FROM ubuntu:18.04 AS builder
RUN apt-get update && apt-get install -y git golang curl jq 
COPY . .
RUN bash -c './pipeline.sh'

#runtime
FROM ubuntu:18.04
WORKDIR /app
COPY --from=builder ./src/votingapp/deploy .
ENTRYPOINT [ "./votingapp" ]



