#!/bin/bash
source ./helper-functions.sh


function install_usernameanarchy() {
    git clone https://github.com/urbanadventurer/username-anarchy.git /opt/repositories/username-anarchy
    error_handling "downloading username-anarchy" "Downloaded username-anarchy"
    ln -sf /opt/repositories/username-anarchy/username-anarchy /opt/symlinks/
}


function install_wister() {
    pipx install --global wister
    error_handling "installing wister" "Installed wister"
    ln -sf /usr/local/bin/wister /opt/symlinks/
}


function install_crunch_cupp_cewl() {
    apt install -y crunch cupp cewl
    error_handling "installing crunch, cupp and cewl" "Installed crunch, cupp and cewl"
    ln -sf /usr/bin/cupp /opt/symlinks/
    ln -sf /usr/bin/crunch /opt/symlinks/
    ln -sf /usr/bin/cewl /opt/symlinks/
}


function install_john() {
    git clone https://github.com/openwall/john.git /opt/repositories/john
    cd /opt/repositories/john/src/ && ./configure && make -s clean && make -j8
    error_handling "installing john" "Installed john"
    ln -sf /opt/repositories/john/run/john /opt/symlinks/
    ln -sf /opt/repositories/john/run/*.py /opt/symlinks/
    ln -sf /opt/repositories/john/run/*.pl /opt/symlinks/
}


function install_rsactftool() {
    pipx install --global git+https://github.com/RsaCtfTool/RsaCtfTool
    error_handling "installing RsaCtfTool" "Installed RsaCtfTool"
    ln -sf /usr/local/bin/RsaCtfTool /opt/symlinks/
    ln -sf /usr/local/bin/rsacrack /opt/symlinks/
}


function install_terminal_tools() {
    apt install -y tmux neovim fzf file
    error_handling "installing terminal tools" "Installed terminal tools"
}


function cleanup(){
    rm -rf /tmp/*
    /opt/symlinks/go clean -cache
    su -Pc '/opt/symlinks/go clean -cache' - user
    rm -rf /root/.cache
    rm -rf /home/user/.cache
    rm -rf /opt/repositories/go/pkg/mod/
    apt-get clean
    apt-get distclean
    # remove git trackers since they use lots of space.
    rm -rf /opt/repositories/Responder/.git*
    rm -rf /opt/repositories/exploitdb/.git*
    rm -rf /opt/repositories/hashgrab/.git*
    rm -rf /opt/repositories/john/.git*
    rm -rf /opt/repositories/john/src
    rm -rf /opt/repositories/jwt_tool/.git*
    rm -rf /opt/repositories/krbrelayx/.git*
    rm -rf /opt/repositories/phpggc/.git*
    rm -rf /opt/repositories/pygpoabuse/.git*
    rm -rf /opt/repositories/remote-method-guesser/.git*
    rm -rf /opt/repositories/sliver/.git*
    rm -rf /opt/repositories/sqlmap/.git*
    rm -rf /opt/repositories/theharvester/.git*
    rm -rf /opt/repositories/username-anarchy/.git*
    # Workaround for llvm Too many levels of symbolic links @ dir_initialize
    rm -rf /usr/lib/llvm-19/build/Debug+Asserts
    rm -rf /usr/lib/llvm-19/build/Release
    rm -rf /var/log/*
    updatedb
}


function make_executable() {
    find /opt/symlinks -maxdepth 1 ! -name searchsploit -exec chmod +x {} +
}


install_usernameanarchy
install_wister
install_crunch_cupp_cewl
install_john
set_java_version
install_terminal_tools
cleanup
make_executable