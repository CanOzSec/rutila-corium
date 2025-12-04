#!/bin/bash
source ./helper-functions.sh


function config_apt() {
    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
    error_handling "configuring apt" "Configured apt"
    apt update
    error_handling "updating debian repositories" "Updated debian repositories"
}


function upgrade_debian_packages() {
    apt upgrade -y
    error_handling "upgrading debian packages" "Upgraded debian packages"
}


function install_libraries() {
    apt install -y openssl libssl-dev
    error_handling "installing openssl" "Installed openssl"
    apt install -y apt-utils libsasl2-dev libldap2-dev libcurl4-openssl-dev libreadline8 \
                   libreadline-dev libasound2 libxrender1 libxtst6 libxi6 libsqlite3-dev \
                   libbz2-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev tk-dev \
                   libffi-dev liblzma-dev python3-openssl
    error_handling "installing required libraries" "Installed required libraries"
}


function prepare_directories() {
    mkdir /opt/repositories
    mkdir /opt/symlinks
    mkdir /opt/languages
    mkdir /opt/attack
    error_handling "preparing directories" "Prepared directories"
}


function install_cli_tools() {
    apt install -y  git curl wget time faketime procps locate kmod traceroute lsb-release   \
                    iproute2 net-tools iputils-ping traceroute dnsutils socat openvpn telnet \
                    nfs-common ftp gnupg2 netcat-openbsd less p7zip-full xz-utils ffmpeg xq jq
    error_handling "installing useful cli tools" "Installed useful cli tools"
    ln -sf /usr/bin/socat /opt/symlinks/
    ln -sf /usr/bin/nc /opt/symlinks/
    ln -sf /usr/bin/dig /opt/symlinks/
    ln -sf /usr/bin/ftp /opt/symlinks/
    ln -sf /usr/bin/faketime /opt/symlinks/
    ln -sf /usr/bin/p7zip /opt/symlinks/
    ln -sf /usr/sbin/openvpn /opt/symlinks/
    ln -sf /usr/bin/telnet /opt/symlinks/
    ln -sf /usr/bin/ffmpeg /opt/symlinks/
    ln -sf /usr/bin/jq /opt/symlinks/
    ln -sf /usr/bin/xq /opt/symlinks/
}


function create_user() {
    useradd -s /bin/bash -m -p $(echo "password123!" | openssl passwd -1 -stdin) user > /dev/null 2>&1
    error_handling "creating user" "Created user"
    chown user:user /opt/repositories
}


config_apt
upgrade_debian_packages
install_libraries
prepare_directories
install_cli_tools
create_user

