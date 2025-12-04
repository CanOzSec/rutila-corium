#!/bin/bash
source ./helper-functions.sh


function install_python_ruby_php() {
    apt install -y python3-dev python3-pip pipx python3-venv ruby-dev php-cli
    error_handling "installing python, ruby, php" "Installed python, ruby, php"
    pip install --break-system-packages pycryptodome
}


function install_openjdks() {
    apt install -y openjdk-21-jdk libasmtools-java maven
    error_handling "installing openjdk 21 and maven" "Installed openjdk 21 and maven"
    ln -sf /usr/bin/mvn /opt/symlinks/
    for i in $(find /usr/lib/jvm/java-1.21.0-openjdk-amd64/bin/*); do toolName=$(echo $i|cut -d/ -f7); ln -sf $i /opt/symlinks/java21-$toolName; done
    # Install java jdk 8 for ysoserial
    curl -fLo /tmp/bellsoft-jdk8u382+6-linux-amd64.deb https://download.bell-sw.com/java/8u382+6/bellsoft-jdk8u382+6-linux-amd64.deb
    dpkg -i /tmp/bellsoft-jdk8u382+6-linux-amd64.deb
    error_handling "installing jdk 8" "Installed jdk 8"
    for i in $(find /usr/lib/jvm/bellsoft-java8-amd64/bin/*); do toolName=$(echo $i|cut -d/ -f7); ln -sf $i /opt/symlinks/java8-$toolName; done
}


function install_go() {
    curl -fLo /tmp/go1.25.3.linux-amd64.tar.gz https://go.dev/dl/go1.25.3.linux-amd64.tar.gz
    tar -xf /tmp/go1.25.3.linux-amd64.tar.gz -C /opt/languages/
    ln -sf /opt/languages/go/bin/go* /opt/symlinks
    error_handling "installing go" "Installed go"
}


function install_rust() {
    mkdir -p /opt/languages/rust/cargo
    curl https://sh.rustup.rs -sSf | CARGO_HOME=/opt/languages/rust/cargo RUSTUP_HOME=/opt/languages/rust sh -s -- -y
    error_handling "installing rust" "Installed rust"
    ln -sf /opt/languages/rust/cargo/bin/* /opt/symlinks/
}


function install_cross_compilers() {
    apt install -y cmake libclang-dev musl-tools mingw-w64 binutils-mingw-w64 g++-mingw-w64 g++-mingw-w64-x86-64 gcc-mingw-w64-x86-64 osslsigncode
    error_handling "installing cross compilers" "Installed cross compilers"
    ln -sf /usr/bin/x86_64-w64-mingw32* /opt/symlinks/
}


function install_nodejs() {
    apt install -y npm nodejs
    error_handling "installing nodejs and npm" "Installed nodejs and npm"
    npm install --global yarn
    error_handling "installing yarn" "Installed yarn"
    ln -sf $(which npm) /opt/symlinks/
    ln -sf $(which node) /opt/symlinks/
    ln -sf $(which yarn) /opt/symlinks/
}


function set_java_version() {
    update-alternatives --set java /usr/lib/jvm/java-21-openjdk-amd64/bin/java
    error_handling "setting java version" "Set java version"
}


install_python_ruby_php
install_openjdks
install_go
install_rust
install_cross_compilers
# install_nodejs # Optional since it takes a lot of space.
set_java_version
