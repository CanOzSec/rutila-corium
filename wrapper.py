#!/usr/bin/env python3

import sys
import os
from pathlib import Path

# Program exceptions for docker.
ttyLessPrograms = [
	"jq",
	"xq"
]
guiPrograms = [
	"wireshark",
	"BurpSuiteCommunity",
	"ghidraRun",
	"freerdp3",
	"remmina",
	"jadx",
	"recaf",
	"visualvm"
]
rootPrograms = [
	"masscan",
	"openvpn",
	"wireshark",
	"tcpdump",
	"tshark",
	"nmap",
	"arp-scan",
	"p0f",
	"ssh-mitm",
	"coercer",
	"mitm6",
	"smbserver.py",
	"Responder.py",
	"krbrelayx.py",
	"ntlmrelayx.py"
]
netAdminCapabilityPrograms = [
	"openvpn"
]
deviceAccessPrograms = {
	"openvpn":"/dev/net/tun",
	"BurpSuiteCommunity":"/dev/dri"
}


programName = sys.argv[0].split("/")[-1]
programArgs = sys.argv[1:]

prefix = ["/usr/bin/docker", "run"]
args = [
	"--attach", "stdin",
	"--attach", "stdout",
	"--attach", "stderr",
	"--env-file", "/opt/rutila-corium/config/environment.conf",
	"--workdir", "/opt/host",
	"--volume", f"{Path.cwd()}:/opt/host",
	"--volume", "/opt/attack/:/opt/attack",
	"--mount", "type=bind,src=/opt/rutila-corium/config/krb5.conf,dst=/etc/krb5.conf",
	"--mount", "type=bind,src=/opt/rutila-corium/config/Responder.conf,dst=/etc/Responder.conf",
	"--mount", "type=bind,src=/opt/rutila-corium/config/certs/responder.crt,dst=/etc/responder.crt",
	"--mount", "type=bind,src=/opt/rutila-corium/config/certs/responder.key,dst=/etc/responder.key",
	"--network", "host",
	"--rm",
	"--interactive",
	"rutila-corium",
	programName
]

optionalArgs = []
if programName not in ttyLessPrograms:
	optionalArgs.append("--tty")

if programName in guiPrograms:
	optionalArgs.append("--volume")
	optionalArgs.append("/tmp/.X11-unix/:/tmp/.X11-unix/")
	optionalArgs.append("-e")
	optionalArgs.append(f"DISPLAY={os.environ.get("DISPLAY")}")

if programName in rootPrograms:
	optionalArgs.append("--user")
	optionalArgs.append("0:0")
else:
	optionalArgs.append("--user")
	optionalArgs.append("1000:1000")

if programName in netAdminCapabilityPrograms:
	optionalArgs.append("--cap-add")
	optionalArgs.append("NET_ADMIN")

if programName in deviceAccessPrograms.keys():
	optionalArgs.append("--device")
	optionalArgs.append(deviceAccessPrograms[programName])

command = prefix + optionalArgs + args + programArgs

os.spawnvpe(os.P_WAIT, command[0], command, os.environ)
