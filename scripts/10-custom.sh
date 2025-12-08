#!/bin/bash

echo "You can add your custom applications, libraries etc. here."


function install_dotfiles(){
    # Configure tmux.
    su -Pc "mkdir -p /home/user/.config/tmux" - user
    mkdir -p /root/.config/tmux

    su -Pc "cp /opt/dotfiles/tmux.conf /home/user/.config/tmux/" - user
    cp /opt/dotfiles/tmux.conf /root/.config/tmux/
    
    # Configure bash.
    su -Pc "cp /opt/dotfiles/bashrc /home/user/.bashrc" - user
    cp /opt/dotfiles/bashrc /root/.bashrc
    # Change prompt color to red on root.
    sed -i "s/220/52/" /root/.bashrc 
}


function install_vim_dotfiles(){
	# Configure vim.
    su -Pc "mkdir -p /home/user/.config/nvim" - user
    mkdir -p /root/.config/nvim
    su -Pc "mkdir -p /home/user/.local/share/nvim/site/autoload/" - user
    mkdir -p /root/.local/share/nvim/site/autoload/
    
    su -Pc "cp /opt/dotfiles/init.vim /home/user/.config/nvim/" - user
    cp /opt/dotfiles/init.vim /root/.config/nvim/

    # Install vim plugin manager.
    curl -fLo /tmp/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    su -Pc "cp /tmp/plug.vim /home/user/.local/share/nvim/site/autoload/plug.vim" - user
    cp /tmp/plug.vim /root/.local/share/nvim/site/autoload/plug.vim

    vim -c "PlugUpdate" -c "qa!"
    su -Pc 'vim -c "PlugUpdate" -c "qa!"' - user
}


install_dotfiles
