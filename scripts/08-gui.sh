#!/bin/bash
source ./helper-functions.sh


function install_apttools() {
	apt install -y wireshark
	error_handling "installing wireshark" "Installed wireshark"
	ln -sf /usr/bin/wireshark /opt/symlinks/
}


function install_burpsuite() {
	curl -fLo /tmp/burp.sh 'https://portswigger.net/burp/releases/download?product=community&type=Linux'
	chmod +x /tmp/burp.sh && /tmp/burp.sh -q
	error_handling "installing burp suite community edition" "Installed burp suite community edition"
	ln -sf /opt/BurpSuiteCommunity/BurpSuiteCommunity /opt/symlinks/
	# Fix chrome in docker problem.
	export chromePath=$(find /opt/BurpSuiteCommunity/burpbrowser/ | grep chrome$)
	mv $chromePath "$chromePath"_bin
	echo -e '#!/bin/sh\n\n'"$chromePath"'_bin --no-sandbox "$@"' | tee $chromePath
	chmod +x $chromePath
}


function install_ghidra() {
	cd /tmp/ && curl -s https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest | jq -r .assets[].browser_download_url | wget -i -
	unzip /tmp/ghidra*.zip -d /opt/repositories
	error_handling "installing ghidra" "Installed ghidra"
	ln -sf /opt/repositories/ghidra_*/ghidraRun /opt/symlinks/
	sed -i 's/bg jdk/fg jdk/' /opt/repositories/ghidra_*/ghidraRun
}


function install_freerdp3() {
	apt install -y freerdp3-wayland freerdp3-x11
	error_handling "installing freerdp (x11 and wayland)" "Installed freerdp (x11 and wayland)"
	ln -sf /usr/bin/xfreerdp3 /opt/symlinks/
	ln -sf /usr/bin/wlfreerdp3 /opt/symlinks/
}


function install_remmina() {
	apt install -y remmina
	error_handling "installing remmina" "Installed remmina"
	ln -sf /usr/bin/remmina /opt/symlinks/
}


function install_jadx() {
	curl -fLo /tmp/jadx.zip 'https://github.com/skylot/jadx/releases/download/v1.5.3/jadx-1.5.3.zip'
	unzip /tmp/jadx.zip -d /opt/repositories/jadx
	ln -sf /opt/repositories/jadx/bin/jadx /opt/symlinks
	ln -sf /opt/repositories/jadx/bin/jadx-gui /opt/symlinks
}


install_apttools
install_burpsuite
install_ghidra
install_freerdp3
install_remmina
install_jadx
