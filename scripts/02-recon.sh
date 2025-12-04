#!/bin/bash
source ./helper-functions.sh


function install_amass() {
	CGO_ENABLED=0 /opt/symlinks/go install -v github.com/owasp-amass/amass/v5/cmd/amass@main
	error_handling "installing amass" "Installed amass"
	ln -sf /opt/repositories/go/bin/amass /opt/symlinks/
}


function install_theharvester() {
	git clone https://github.com/laramies/theHarvester /opt/repositories/theharvester
	pipx install --global /opt/repositories/theharvester/
	error_handling "installing theharvester" "Installed theharvester"
	ln -sf /usr/local/bin/theHarvester /opt/symlinks/
	ln -sf /usr/local/bin/restfulHarvest /opt/symlinks/
}


function install_waybackurls() {
	/opt/symlinks/go install -v github.com/tomnomnom/waybackurls@latest
	error_handling "installing waybackurls" "Installed waybackurls"
	ln -sf /opt/repositories/go/bin/waybackurls /opt/symlinks/
}


function install_ipinfo() {
	/opt/symlinks/go install -v github.com/ipinfo/cli/ipinfo@latest
	error_handling "installing ipinfo" "Installed ipinfo"
	ln -sf /opt/repositories/go/bin/ipinfo /opt/symlinks/
}


function install_ytdlp() {
	pipx install --global yt-dlp
	error_handling "installing yt-dlp" "Installed yt-dlp"
	ln -sf /usr/local/bin/yt-dlp /opt/symlinks/
}


function install_apttools() {
	apt install -y whois recon-ng dnsenum exiftool
	error_handling "installing whois, recon-ng, dnsenum, exiftool" "Installed whois, recon-ng, dnsenum, exiftool"
	ln -sf /usr/bin/whois /opt/symlinks/
	ln -sf /usr/bin/recon-ng /opt/symlinks/
	ln -sf /usr/bin/dnsenum /opt/symlinks/
	ln -sf /usr/bin/exiftool /opt/symlinks/
}


install_amass
install_theharvester
install_waybackurls
install_ipinfo
install_ytdlp
install_apttools
