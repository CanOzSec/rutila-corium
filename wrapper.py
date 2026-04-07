#!/usr/bin/env python3

import sys
import os
from pathlib import Path

# State and config home
stateHome = Path.home() / Path(".local/rutila-corium")

# Program exceptions for docker.
ttyLessPrograms = [
	"jq",
	"xq",
	"nc"
]
guiPrograms = [
	"wireshark",
	"BurpSuiteCommunity",
	"ghidraRun",
	"xfreerdp3",
	"remmina",
	"jadx-gui",
	"recaf",
	"visualvm"
]
rootPrograms = [
	"masscan",
	"openvpn",
	"wireshark",
	"bettercap",
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
	"ntlmrelayx.py",
	"ntlm-reflection"
]
netAdminCapabilityPrograms = [
	"openvpn",
	"bettercap"
]
netRawCapabilityPrograms = [
	"nmap",
	"bettercap"
]
deviceAccessPrograms = {
	"openvpn":"/dev/net/tun",
	"BurpSuiteCommunity":"/dev/dri"
}
localStateFixes = {
	"amass"             :[f"{stateHome}/amass_state", "/home/user/.config/amass"],
	"nxc"               :[f"{stateHome}/nxc_state", "/home/user/.nxc"],
	"nxcdb"             :[f"{stateHome}/nxc_state", "/home/user/.nxc"],
	"nuclei"            :[f"{stateHome}/nuclei_state", "/home/user/nuclei-templates"],
	"ghidraRun"         :[f"{stateHome}/ghidraRun_state", "/home/user/.config/ghidra"],
	"BurpSuiteCommunity":[f"{stateHome}/BurpSuiteCommunity_state", "/home/user/.BurpSuite,/home/user/.java"],
	"sqlmap"            :[f"{stateHome}/sqlmap_state", "/home/user/.sqlmap"]
}

programName = sys.argv[0].split("/")[-1]
programArgs = sys.argv[1:]

prefix = ["/usr/bin/docker", "run"]
args = [
	"--init",
	"--attach", "stdin",
	"--attach", "stdout",
	"--attach", "stderr",
	"--env-file", f"{stateHome}/config/environment.conf",
	"--workdir", "/opt/host",
	"--volume", f"{Path.cwd()}:/opt/host",
	"--volume", "/opt/attack/:/opt/attack",
	"--mount", f"type=bind,src={stateHome}/config/krb5.conf,dst=/etc/krb5.conf",
	"--mount", f"type=bind,src={stateHome}/config/Responder.conf,dst=/etc/Responder.conf",
	"--mount", f"type=bind,src={stateHome}/config/certs/responder.crt,dst=/etc/responder.crt",
	"--mount", f"type=bind,src={stateHome}/config/certs/responder.key,dst=/etc/responder.key",
	"--network", "host",
	"--rm",
	"--interactive",
	"rutila-corium",
	programName,
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

if programName in netRawCapabilityPrograms:
	optionalArgs.append("--cap-add")
	optionalArgs.append("NET_RAW")

if programName in deviceAccessPrograms.keys():
	optionalArgs.append("--device")
	optionalArgs.append(deviceAccessPrograms[programName])

if "KRB5CCNAME" in os.environ.keys():
	optionalArgs.append("-e")
	optionalArgs.append("KRB5CCNAME")

if programName in localStateFixes.keys():
	# stateLocationHost   = f"{stateHome}/{programName}_state"
	stateLocationHost   = localStateFixes[programName][0]
	stateLocationDocker = localStateFixes[programName][1]
	try:
		Path(stateLocationHost).mkdir(parents=True)
	except FileExistsError:
		pass
	if not "," in stateLocationDocker:
		optionalArgs.append("--mount")
		optionalArgs.append(f"type=bind,src={stateLocationHost},dst={stateLocationDocker}")
	else:
		dirs = stateLocationDocker.split(",")
		for i, d in enumerate(dirs):
			try:
				Path(f"{stateLocationHost}/{i}").mkdir(parents=True)
			except FileExistsError:
				pass
			optionalArgs.append("--mount")
			optionalArgs.append(f"type=bind,src={stateLocationHost}/{i}/,dst={d}")

command = prefix + optionalArgs + args + programArgs

os.spawnvpe(os.P_WAIT, command[0], command, os.environ)
