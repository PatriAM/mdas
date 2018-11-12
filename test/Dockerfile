FROM ubuntu:18.04
RUN apt-get update && apt-get install -y curl jq  python python-pip

COPY test.sh .
RUN chmod +x test.sh

RUN pip install requests
COPY test.py .

ENTRYPOINT [ "bash", "-c", "./test.sh && python test.py" ]

