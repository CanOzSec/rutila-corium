#!/bin/bash
source ./helper-functions.sh


function install_metasploit() {
	curl -fLo /tmp/msfupdate.erb https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb
	chmod 755 /tmp/msfupdate.erb
	/tmp/msfupdate.erb
	error_handling "installing metasploit-framework" "Installed metasploit-framework"
	ln -sf /opt/metasploit-framework/bin/* /opt/symlinks/
}


function install_sliver() {
	apt install -y mingw-w64 binutils-mingw-w64 g++-mingw-w64
	git clone https://github.com/BishopFox/sliver.git /opt/repositories/sliver
	error_handling "downloading sliver" "Downloaded sliver"
	chown user:user -R /opt/repositories/sliver
	export GOPATH=/opt/repositories/go
	export PATH=$PATH:/opt/symlinks/
	cd /opt/repositories/sliver
	sed -i 's/-mod=vendor/-mod=vendor -buildvcs=false/g' Makefile
	make
	error_handling "installing sliver" "Installed sliver"
	su -Pc "/opt/symlinks/sliver-server unpack"
	ln -sf /opt/repositories/sliver/sliver-* /opt/symlinks/
}


install_metasploit
install_sliver
