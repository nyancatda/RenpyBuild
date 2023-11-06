FROM ubuntu:latest

COPY . /work
WORKDIR /work

COPY ./build.sh ./build.sh

RUN apt-get update
RUN apt-get install --yes wget bzip2 mesa-utils

ENTRYPOINT ["/work/build.sh"]