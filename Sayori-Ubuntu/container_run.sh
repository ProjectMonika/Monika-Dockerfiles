#!/bin/sh
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < /tmp/passwd_template > /tmp/passwd

cd /opt/app && \
/usr/bin/python3.6 '/opt/app/main.py'
