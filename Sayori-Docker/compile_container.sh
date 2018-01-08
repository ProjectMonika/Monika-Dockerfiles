#!/bin/sh

# The reason we're doing the package install here is to keep everything in one layer for easier downloads
# It's relatively more convinient this way
sudo apt update && \
sudo apt -y install \
     build-essential \
     gcc \
     zlib1g-dev \
     sudo \
     wget \
     curl \
     apt-utils \
     apt-transport-https \
     git \
     tar \
     unzip \
     clang \
     cmake \
     openssh-server \
     gettext \

# manually install Python 3.6
cd /usr/src && \
   wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz && \
   tar xzf Python-3.6.4.tgz && \
   cd Python-3.6.4 && \
   ./configure --enable-optimizations && \
   make altinstall && \
   rm -rf /usr/src/Python-3.6.4.tgz && \

# Create user
mkdir /var/run/sshd && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
useradd -u 1000 -G users,sudo -d /home/user --shell /bin/bash -m user && \
usermod -p "*" user 

# perm root awau
chmod g+rw /opt
chgrp root /opt

# allow to run on openshift
chown -R user:root /opt/app
chmod -R g+rw /opt/app
chmod -R g+rw /home/user
find /home/user -type d -exec chmod g+x {} +