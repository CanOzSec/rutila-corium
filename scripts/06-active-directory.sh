#!/bin/bash
source ./helper-functions.sh


function install_apttools() {
	export DEBIAN_FRONTEND=noninteractive
	apt install -y samdump2 smbclient onesixtyone nbtscan ldap-utils \
	libkrb5-dev krb5-user libkrb5-dev libgssapi-krb5-2 libsasl2-modules-gssapi-mit
	ln -sf /usr/bin/klist /opt/symlinks/
	ln -sf /usr/bin/kinit /opt/symlinks/
	ln -sf /usr/bin/kadmin /opt/symlinks/
	ln -sf /usr/bin/ktutil /opt/symlinks/
	ln -sf /usr/bin/ksu /opt/symlinks/
	ln -sf /usr/bin/kswitch /opt/symlinks/
	ln -sf /usr/bin/smbclient /opt/symlinks/
	ln -sf /usr/bin/samdump2 /opt/symlinks/
	ln -sf /usr/bin/onesixtyone /opt/symlinks/
	ln -sf /usr/bin/nbtscan /opt/symlinks/
	ln -sf /usr/bin/ldap* /opt/symlinks/
	ln -sf /usr/bin/rpcclient /opt/symlinks/
}


function install_impacket() {
	pipx install --global git+https://github.com/fortra/impacket
	error_handling "installing impacket" "Installed impacket"
	ln -sf /opt/pipx/venvs/impacket/bin/*.py /opt/symlinks/
}


function install_bloodyad() {
	pipx install --global git+https://github.com/CravateRouge/bloodyAD
	error_handling "installing bloodyAD" "Installed bloodyAD"
	ln -sf /usr/local/bin/bloodyad /opt/symlinks/
	ln -sf /usr/local/bin/bloodyAD /opt/symlinks/
}


function install_netexec() {
	pipx install --global git+https://github.com/Pennyw0rth/NetExec
	error_handling "installing NetExec" "Installed NetExec"
	ln -sf /usr/local/bin/NetExec /opt/symlinks/
	ln -sf /usr/local/bin/netexec /opt/symlinks/
	ln -sf /usr/local/bin/nxc /opt/symlinks/
	ln -sf /usr/local/bin/nxcdb /opt/symlinks/
	# create dbs.
	/usr/local/bin/nxc
	su -Pc "/usr/local/bin/nxc" - user
}


function install_ldeep() {
	pipx install --global git+https://github.com/franc-pentest/ldeep
	error_handling "installing ldeep" "Installed ldeep"
	ln -sf /usr/local/bin/ldeep /opt/symlinks/
}


function install_certipy() {
	pipx install --global git+https://github.com/ly4k/Certipy.git
	error_handling "installing Certipy" "Installed Certipy"
	ln -sf /usr/local/bin/certipy /opt/symlinks/
}


function install_coercer() {
	pipx install --global git+https://github.com/p0dalirius/Coercer
	error_handling "installing Coercer" "Installed Coercer"
	ln -sf /usr/local/bin/coercer /opt/symlinks/
}


function install_enum4linux-ng() {
	pipx install --global git+https://github.com/cddmp/enum4linux-ng
	error_handling "installing enum4linux-ng" "Installed enum4linux-ng"
	ln -sf /usr/local/bin/enum4linux-ng /opt/symlinks/
}


function install_donpapi() {
	pipx install --global git+https://github.com/login-securite/DonPAPI
	error_handling "installing DonPAPI" "Installed DonPAPI"
	ln -sf /usr/local/bin/donpapi /opt/symlinks/
	ln -sf /usr/local/bin/DonPAPI /opt/symlinks/
	ln -sf /usr/local/bin/dpp /opt/symlinks/
}


function install_mitm6() {
	pipx install --global mitm6
	error_handling "installing mitm6" "Installed mitm6"
	ln -sf /usr/local/bin/mitm6 /opt/symlinks/
}


function install_pypykatz() {
	pipx install --global pypykatz
	error_handling "installing pypykatz" "Installed pypykatz"
	ln -sf /usr/local/bin/pypykatz /opt/symlinks/
}


function install_adidnsdump() {
	pipx install --global git+https://github.com/dirkjanm/adidnsdump#egg=adidnsdump
	error_handling "installing adidnsdump" "Installed adidnsdump"
	ln -sf /usr/local/bin/adidnsdump /opt/symlinks/
}


function install_evil-winrm() {
	gem install evil-winrm
	error_handling "installing evil-winrm" "Installed evil-winrm"
	ln -sf /usr/local/bin/evil-winrm /opt/symlinks/
}


function install_responder() {
	git clone https://github.com/lgandx/Responder /opt/repositories/Responder
	error_handling "installing Responder" "Installed Responder"
	python3 -m venv /opt/repositories/Responder/virt
	/opt/repositories/Responder/virt/bin/python3 -m pip install -r /opt/repositories/Responder/requirements.txt
	/opt/repositories/Responder/virt/bin/python3 -m pip install pycryptodome six pycryptodomex
	sed -i 's/#!\/usr\/bin\/env python3/#!\/opt\/repositories\/Responder\/virt\/bin\/python3/' /opt/repositories/Responder/Responder.py
	mv /opt/repositories/Responder/Responder.conf /etc/Responder.conf
	ln -sf /etc/Responder.conf /opt/repositories/Responder/Responder.conf
	ln -sf /opt/repositories/Responder/Responder.py /opt/symlinks/
}


function install_krbrelayx() {
	git clone https://github.com/dirkjanm/krbrelayx /opt/repositories/krbrelayx
	error_handling "installing krbrelayx" "Installed krbrelayx"
	python3 -m venv /opt/repositories/krbrelayx/virt
	/opt/repositories/krbrelayx/virt/bin/python3 -m pip install ldap3 impacket dnspython
	sed -i 's/#!\/usr\/bin\/env python/#!\/opt\/repositories\/krbrelayx\/virt\/bin\/python3/' /opt/repositories/krbrelayx/*.py
	ln -sf /opt/repositories/krbrelayx/*.py /opt/symlinks
}


function install_hashgrab() {
	git clone https://github.com/xct/hashgrab /opt/repositories/hashgrab
	error_handling "installing hashgrab" "Installed hashgrab"
	python3 -m venv /opt/repositories/hashgrab/virt
	/opt/repositories/hashgrab/virt/bin/python3 -m pip install -r /opt/repositories/hashgrab/requirements.txt
	sed -i 's/import argparse/#!\/opt\/repositories\/hashgrab\/virt\/bin\/python3\nimport argparse/' /opt/repositories/hashgrab/hashgrab.py
	chmod +x /opt/repositories/hashgrab/hashgrab.py
	ln -sf /opt/repositories/hashgrab/hashgrab.py /opt/symlinks/
}


function install_pywhisker() {
	pipx install --global git+https://github.com/ShutdownRepo/pywhisker.git
	error_handling "installing pywhisker" "Installed pywhisker" 
	ln -sf /usr/local/bin/pywhisker /opt/symlinks/
}


function install_lsassy() {
	pipx install --global git+https://github.com/login-securite/lsassy.git
	error_handling "installing lsassy" "Installed lsassy"
	ln -sf /usr/local/bin/lsassy /opt/symlinks/
}


function install_pygpoabuse() {
	git clone https://github.com/Hackndo/pyGPOAbuse /opt/repositories/pygpoabuse
	error_handling "installing pyGPOAbuse" "Installed pyGPOAbuse"
	python3 -m venv /opt/repositories/pygpoabuse/virt
	/opt/repositories/pygpoabuse/virt/bin/python3 -m pip install -r /opt/repositories/pygpoabuse/requirements.txt
	sed -i '0,/"""/s//#!\/opt\/repositories\/pygpoabuse\/virt\/bin\/python3\n"""/' /opt/repositories/pygpoabuse/pygpoabuse.py
	ln -sf /opt/repositories/pygpoabuse/pygpoabuse.py /opt/symlinks
}


function install_ntdissector() {
	pipx install --global git+https://github.com/synacktiv/ntdissector.git
	error_handling "installing ntdissector" "Installed ntdissector"
	ln -sf /usr/local/bin/ntdissector /opt/symlinks/
}


function install_nopac() {
	git clone https://github.com/Ridter/noPac.git /opt/repositories/noPac
	error_handling "installing noPac" "Installed noPac"
	sed -i 's/\/usr\/bin\/env python/\/opt\/repositories\/krbrelayx\/virt\/bin\/python3/g' /opt/repositories/noPac/noPac.py
	chmod +x /opt/repositories/noPac/noPac.py
	ln -sf /opt/repositories/noPac/noPac.py /opt/symlinks/
}


function install_rusthound() {
	export RUSTUP_HOME=/opt/languages/rust
	export CARGO_HOME=/opt/languages/rust
	export PATH=$PATH:/opt/languages/rust/cargo/bin
	/opt/symlinks/cargo install rusthound-ce
	error_handling "installing rusthound-ce" "Installed rusthound-ce"
	ln -sf /opt/languages/rust/bin/rusthound-ce /opt/symlinks/
}


install_apttools
install_impacket
install_bloodyad
install_netexec
install_ldeep
install_certipy
install_coercer
install_enum4linux-ng
install_donpapi
install_mitm6
install_pypykatz
install_adidnsdump
install_evil-winrm
install_responder
install_krbrelayx
install_hashgrab
install_pywhisker
install_lsassy
install_pygpoabuse
install_ntdissector
