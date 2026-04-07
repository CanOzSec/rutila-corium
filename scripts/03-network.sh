#!/bin/bash
source ./helper-functions.sh


function install_apttools() {
	export DEBIAN_FRONTEND=noninteractive
	apt install -y arp-scan ike-scan nmap tcpdump iptables masscan redis-tools postgresql-client dsniff \
				   default-mysql-client proxychains4 hydra tshark p0f dnsmasq hping3 snmp libmemcached-tools \
				   python3-scapy
	error_handling "installing apt network tools" "Installed apt network tools"
	ln -sf /usr/sbin/arp-scan /opt/symlinks/
	ln -sf /usr/sbin/hping3 /opt/symlinks/
	ln -sf /usr/bin/nmap /opt/symlinks/
	ln -sf /usr/bin/tcpdump /opt/symlinks/
	ln -sf /usr/sbin/iptables /opt/symlinks/
	ln -sf /usr/bin/masscan /opt/symlinks/
	ln -sf /usr/bin/redis-cli /opt/symlinks/
	ln -sf /usr/bin/psql /opt/symlinks/
	ln -sf /usr/bin/mysql* /opt/symlinks/
	ln -sf /usr/bin/proxychains4 /opt/symlinks/
	ln -sf /usr/bin/hydra /opt/symlinks/
	ln -sf /usr/bin/tshark /opt/symlinks/
	ln -sf /usr/sbin/p0f /opt/symlinks/
	ln -sf /usr/sbin/dnsmasq /opt/symlinks/
	ln -sf /usr/bin/snmpbulkwalk /opt/symlinks/
	ln -sf /usr/bin/snmp* /opt/symlinks/
	ln -sf /usr/bin/memc* /opt/symlinks/
	ln -sf /usr/sbin/arpspoof /opt/symlinks/
	ln -sf /usr/sbin/dnsspoof /opt/symlinks/
	ln -sf /usr/sbin/dsniff /opt/symlinks/
	ln -sf /usr/bin/nslookup /opt/symlinks/
	ln -sf /usr/bin/traceroute /opt/symlinks/
	ln -sf /usr/bin/traceroute6 /opt/symlinks/
	ln -sf /usr/bin/nslookup /opt/symlinks/
}


function install_grpcurl() {
	/opt/symlinks/go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
	error_handling "installing grpcurl" "Installed grpcurl"
	ln -sf /opt/repositories/go/bin/grpcurl /opt/symlinks/
}


function install_chisel() {
	git clone https://github.com/jpillora/chisel.git /opt/repositories/chisel
	mkdir /opt/repositories/chisel/static-binaries/
	cd /opt/repositories/chisel && GOOS=linux GOARCH=amd64 /opt/symlinks/go build -ldflags="-s -w" -tags netgo,osusergo -o /opt/repositories/chisel/static-binaries/chisel-linux-amd64
	error_handling "installing chisel" "Installed chisel"
	cd /opt/repositories/chisel && GOOS=windows GOARCH=amd64 /opt/symlinks/go build -ldflags="-s -w" -tags netgo,osusergo -o /opt/repositories/chisel/static-binaries/chisel-windows-amd64.exe
	ln -sf /opt/repositories/chisel/static-binaries/chisel-linux-amd64 /opt/symlinks/
}


function install_bettercap() {
	# Need to test
	export DEBIAN_FRONTEND=noninteractive
	apt install -y libusb-1.0-0 libusb-1.0-0-dev libpcap-dev libnetfilter-queue-dev
	error_handling "installing bettercap dependencies" "Installed bettercap dependencies"
	/opt/symlinks/go install github.com/bettercap/bettercap@latest
	ln -sf /opt/repositories/go/bin/bettercap /opt/symlinks/
	/opt/symlinks/bettercap -eval "caplets.update; q"
}


function install_updog() {
	pipx install --global git+https://github.com/sc0tfree/updog.git
	error_handling "installing updog" "Installed updog"
	ln -sf /usr/local/bin/updog /opt/symlinks/
}


function install_vlanpwn() {
	git clone https://github.com/pirenga/VLANPWN.git /opt/repositories/vlanpwn
	error_handling "installing vlanpwn" "Installed vlanpwn"
	cat /opt/repositories/vlanpwn/DoubleTagging.py | tr --delete '\r' | tee /opt/repositories/vlanpwn/DoubleTagging.py
	cat /opt/repositories/vlanpwn/DTPHijacking.py | tr --delete '\r' | tee /opt/repositories/vlanpwn/DTPHijacking.py
	chmod +x /opt/repositories/vlanpwn/DoubleTagging.py
	chmod +x /opt/repositories/vlanpwn/DTPHijacking.py
	ln -sf /opt/repositories/vlanpwn/DoubleTagging.py /opt/symlinks/
	ln -sf /opt/repositories/vlanpwn/DTPHijacking.py /opt/symlinks/
}


install_apttools
install_grpcurl
install_chisel
install_bettercap
install_vlanpwn
