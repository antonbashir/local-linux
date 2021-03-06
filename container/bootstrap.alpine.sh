#!/bin/bash

if [[ $(id -u) -ne 0 ]] ; then
  echo "Use sudo to run this script"
else
  adduser -h /home/developer -s /bin/ash developer

  apk add \
        sudo \
        nano \
        htop \
        iftop \
        rsync \
        tree \
        git \
        wget \
        curl \
        openssh \
        iproute2 \
        util-linux \
        neofetch \
        openjdk11 \
        python3 \
        nodejs \
        micro \
        clang \
        gcc


  wget https://github.com/antonbashir/local-linux-packages/raw/9ab9daa4b3fa4887fb05ec7d3542814bb0317101/alpine/tarantool/2.8.3/tarantool-2.8.3-r0.apk
  apk add --allow-untrusted tarantool-2.8.3-r0.apk
  rm -rf tarantool-2.8.3-r0.apk

  wget https://github.com/jarun/nnn/releases/download/v4.4/nnn-musl-static-4.4.x86_64.tar.gz
  tar xf nnn-musl-static-4.4.x86_64.tar.gz
  mv nnn-musl-static /usr/bin/files
  rm -rf nnn-musl-static-4.4.x86_64.tar.gz

  service sshd restart
  rc-update add sshd default

  rm -rf /home/developer/.profile.d
  git clone https://github.com/antonbashir/local-linux "/home/developer/.profile.d"
  cp "/home/developer/.profile.d/container/container.sh" "/home/developer/.profile"

  rm -rf "$HOME/.profile.d"
  git clone https://github.com/antonbashir/local-linux "$HOME/.profile.d"
  cp "$HOME/.profile.d/container/container.sh" "$HOME/.profile"

  echo "developer ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/username
  chown -R developer:developer /home/developer

  chmod +x /root/.profile
  chmod +x /home/developer/.profile
fi
