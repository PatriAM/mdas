#builder
FROM golang:stretch AS builder
RUN apt-get update && apt-get install -y git

#reutilizar dependencias
COPY deps.sh .
RUN bash -c './deps.sh'

COPY . .
RUN go build -o /deploy/votingapp && cp -r ui /deploy

#runtime
FROM ubuntu:18.04

#MKDIR Y CD DE APP
WORKDIR /app
COPY --from=builder /deploy .
ENTRYPOINT [ "./votingapp" ]



