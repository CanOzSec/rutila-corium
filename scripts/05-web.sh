#!/bin/bash
source ./helper-functions.sh


function install_ffuf() {
	/opt/symlinks/go install -v github.com/ffuf/ffuf/v2@latest
	error_handling "installing ffuf" "Installed ffuf"
	ln -sf /opt/repositories/go/bin/ffuf /opt/symlinks/
}


function install_sqlmap() {
	git clone https://github.com/sqlmapproject/sqlmap.git /opt/repositories/sqlmap
	error_handling "installing sqlmap" "Installed sqlmap"
	sed -i 's/#!\/usr\/bin\/env python/#!\/usr\/bin\/env python3/' /opt/repositories/sqlmap/sqlmap.py
	ln -sf /opt/repositories/sqlmap/sqlmap.py /opt/symlinks/sqlmap
}


function install_jwttool() {
	git clone https://github.com/ticarpi/jwt_tool /opt/repositories/jwt_tool
	python3 -m venv /opt/repositories/jwt_tool/virt
	/opt/repositories/jwt_tool/virt/bin/python3 -m pip install -r /opt/repositories/jwt_tool/requirements.txt
	error_handling "installing jwt_tool" "Installed jwt_tool"
	sed -i 's/#!\/usr\/bin\/env python3/#!\/opt\/repositories\/jwt_tool\/virt\/bin\/python3/' /opt/repositories/jwt_tool/*.py
	ln -sf /opt/repositories/jwt_tool/jwt_tool.py /opt/symlinks/jwt_tool
}


function install_wpscan() {
	gem install wpscan
	error_handling "installing wpscan" "Installed wpscan"
	ln -sf /usr/local/bin/wpscan /opt/symlinks/
}


function install_eos() {
	pipx install --global git+https://github.com/synacktiv/eos.git
	error_handling "installing eos" "Installed eos"
	/opt/pipx/venvs/eos/bin/python3.13 -m pip install setup-tools
	ln -sf /usr/local/bin/eos /opt/symlinks/
}


function install_sslscan() {
	apt install -y sslscan
	error_handling "installing sslscan" "Installed sslscan"
	ln -sf /usr/bin/sslscan /opt/symlinks/
}


function install_wafw00f() {
	pipx install --global wafw00f
	error_handling "installing wafw00f" "Installed wafw00f"
	ln -sf /usr/local/bin/wafw00f /opt/symlinks/
}


function install_gitdumper() {
	pipx install --global git-dumper
	error_handling "installing git-dumper" "Installed git-dumper"
	ln -sf /usr/local/bin/git-dumper /opt/symlinks/
}


function install_flaskunsign() {
	pipx install --global flask-unsign
	error_handling "installing flask-unsign" "Installed flask-unsign"
	ln -sf /usr/local/bin/flask-unsign /opt/symlinks/
}


function install_ysoserial() {
	mkdir /opt/repositories/ysoserial
	curl -fLo /opt/repositories/ysoserial/ysoserial.jar https://github.com/frohoff/ysoserial/releases/latest/download/ysoserial-all.jar
	error_handling "installing ysoserial" "Installed ysoserial"
	echo -e "#!"'/bin/bash\n/usr/lib/jvm/bellsoft-java8-amd64/bin/java -jar /opt/repositories/ysoserial/ysoserial.jar "$@"' > /opt/repositories/ysoserial/ysoserial
	ln -sf /opt/repositories/ysoserial/ysoserial /opt/symlinks/
}


function install_phpggc() {
	git clone https://github.com/ambionics/phpggc.git /opt/repositories/phpggc
	error_handling "installing phpggc" "Installed phpggc"
	ln -sf /opt/repositories/phpggc/phpggc /opt/symlinks/
}


function install_nuclei() {
	/opt/symlinks/go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
	error_handling "installing nuclei" "Installed nuclei"
	ln -sf /opt/repositories/go/bin/nuclei /opt/symlinks/
	/opt/symlinks/nuclei
	error_handling "updating nuclei templates" "Updated nuclei templates"
	cp -r /root/nuclei-templates /home/user/
	chown user:user -R /home/user/nuclei-templates/
}


function install_cookiemonster() {
	/opt/symlinks/go install github.com/iangcarroll/cookiemonster/cmd/cookiemonster@latest
	error_handling "installing cookiemonster" "Installed cookiemonster"
	ln -sf /opt/repositories/go/bin/cookiemonster /opt/symlinks
}


function install_python_libraries() {
	apt install -y python3-bs4 python3-requests
	error_handling "installing requests and beautifulsoup" "Installed requests and beautifulsoup"
}


install_ffuf
install_sqlmap
install_jwttool
install_wpscan
install_eos
install_sslscan
install_wafw00f
install_gitdumper
install_flaskunsign
install_ysoserial
install_phpggc
install_nuclei
install_cookiemonster
install_python_libraries
