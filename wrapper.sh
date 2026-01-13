#!/bin/bash


args="$@"
guiTools="wireshark BurpSuiteCommunity ghidraRun freerdp3 remmina jadx recaf visualvm"
for tool in $guiTools; do
	if [[ $0 == *"$tool"* ]]; then
		if [[ -n "$DISPLAY" ]]; then
			xhost +local:* 1>/dev/null 2>/dev/null
			guiType="x11"
			gui="-v /tmp/.X11-unix/:/tmp/.X11-unix/ -e DISPLAY=$DISPLAY"
			break
		else
			guiType="wayland"
			break
		fi
	fi;
done


rootTools="masscan openvpn wireshark tcpdump tshark nmap arp-scan p0f ssh-mitm coercer mitm6 smbserver.py Responder.py krbrelayx.py ntlmrelayx.py"
for tool in $rootTools; do
	if [[ $0 == *"$tool"* ]]; then
		user="0:0"
		break
	else
		user="1000:1000"
	fi;
done


if [[ $0 == *"openvpn"* ]]; then
	vpn="--cap-add NET_ADMIN --device /dev/net/tun"
fi


if [[ $0 == *"BurpSuiteCommunity"* ]]; then
	chromiumGpu="--device /dev/dri"
fi


function run() {
	docker run -a stdin -a stdout -a stderr														\
	--env-file /opt/rutila-corium/config/environment.conf 										\
	-v $PWD:/opt/host --user "$user" $gui $vpn $chromiumGpu										\
	-v /opt/attack/:/opt/attack -w /opt/host 													\
	--mount type=bind,src=/opt/rutila-corium/config/krb5.conf,dst=/etc/krb5.conf 				\
	--mount type=bind,src=/opt/rutila-corium/config/Responder.conf,dst=/etc/Responder.conf 	\
	--mount type=bind,src=/opt/rutila-corium/config/certs/responder.crt,dst=/etc/responder.crt \
	--mount type=bind,src=/opt/rutila-corium/config/certs/responder.key,dst=/etc/responder.key \
	--network host --rm -it rutila-corium $0 $args
}


run
