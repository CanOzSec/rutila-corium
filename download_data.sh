#!/bin/bash

mkdir /opt/attack/


function download_seclists() {
    git clone https://github.com/danielmiessler/SecLists.git /opt/attack/seclists
    tar -xvf /opt/attack/seclists/Passwords/Leaked-Databases/rockyou.txt.tar.gz -C /opt/attack/seclists/Passwords/
    rm /opt/attack/seclists/Passwords/Leaked-Databases/rockyou.txt.tar.gz
    rm -rf /opt/attack/seclists/.git*
    rm -rf /opt/attack/seclists/.bin
}


function download_sharpcollection() {
    git clone https://github.com/Flangvik/SharpCollection /opt/attack/SharpCollection
    rm -rf /opt/attack/SharpCollection/.git
}


function download_peassng() {
    mkdir /opt/attack/peass-ng
    curl -fLo /opt/attack/peass-ng/linpeas_linux_amd64 https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas_linux_amd64
    curl -fLo /opt/attack/peass-ng/linpeas.sh https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh
    curl -fLo /opt/attack/peass-ng/winPEASx64.exe https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEASx64.exe
    curl -fLo /opt/attack/peass-ng/winPEASx64_ofs.exe https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEASx64_ofs.exe
    curl -fLo /opt/attack/peass-ng/winPEAS.ps1 https://raw.githubusercontent.com/peass-ng/PEASS-ng/master/winPEAS/winPEASps1/winPEAS.ps1
    curl -fLo /opt/attack/peass-ng/winPEAS.bat https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEAS.bat
}


function download_pspy() {
    mkdir /opt/attack/pspy/
    curl -fLo /opt/attack/pspy/pspy64 https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64
    curl -fLo /opt/attack/pspy/pspy32 https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy32
}


function download_exploitdb() {
    git clone https://gitlab.com/exploit-database/exploitdb.git /opt/attack/exploitdb
    sed -i 's/\/opt\/exploitdb/\/opt\/attack\/exploitdb/' /opt/attack/exploitdb/.searchsploit_rc
}


download_seclists
download_sharpcollection
download_peassng
download_pspy
