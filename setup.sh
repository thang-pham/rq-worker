#!/usr/bin/env bash
# Setup system to host RQ.
# Ubuntu and CentOS are supported.
#
# @author: Thang Pham <thang.g.pham@gmail.com>
RQ_DIR=$(pwd)


function configure_centos {
    yum update -y
    yum install -y epel-release
    yum install -y git python python-dev
    yum install -y supervisor vim

    easy_install pip

    supervisor_conf="/etc/supervisord.d"

    sed -i 's#*.ini#*.conf#g' /etc/supervisord.conf

    cp $RQ_DIR/etc/supervisor/conf.d/rqworker.conf $supervisor_conf

    # rq is found under /usr/bin
    sed -i 's#/local##g' $supervisor_conf/rqworker.conf
}

function configure_ubuntu {
    # Install stack on Ubuntu
    apt-get update
    apt-get install -y git python python-dev
    apt-get install -y supervisor

    easy_install pip

    supervisor_conf="/etc/supervisor/conf.d"

    cp $RQ_DIR/etc/supervisor/conf.d/rqworker.conf $supervisor_conf
}

function switch_localhost {
    # Link to the redis container MUST exist: --link redis:redis
    sed -i 's/localhost/redis/g' ./rq_settings.py
}


# Begin of main code
if [[ $1 == "-h" ]]; then
    echo "Usage: $0 [--docker]"
    echo ""
    echo "Setup system to host RQ."
    echo "Ubuntu and CentOS are supported."
    echo ""
    echo "Optional:"
    echo "  --docker  Setup RQ for Docker"
    exit 1
fi


# CentOS host
if [ -f /etc/redhat-release ]; then
    configure_centos
fi

# Ubuntu host
if [ -f /etc/debian_version ]; then
    configure_ubuntu
fi

if [[ -n $1 && $1 == "--docker" ]]; then
    switch_localhost
fi

# Run pip install
pip install -r $RQ_DIR/requirements.txt
