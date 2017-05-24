# Base image is Ubuntu Xenial
# FROM ubuntu:xenial
FROM centos:centos7

MAINTAINER Thang Pham <thang.g.pham@gmail.com>

ENV DOCKYARD=/home/docker/rq

# Copy over the code
ADD . $DOCKYARD

# Install RQ and set it up
WORKDIR $DOCKYARD
RUN $DOCKYARD/setup.sh --docker

CMD ["supervisord", "-n"]
