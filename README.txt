You will need the following:

You will need a static public IP address OR a domain name with a dynamic DNS.  Basically some way to to connect to your network from the outside.

You will need to port forward UDP port 1194 to you PBX.


There are 3 scripts:

install-EasyOpenVPN_part1.sh
install-EasyOpenVPN_part2.sh
create-EasyOpenVPN_client.sh

Run the first script (install-EasyOpenVPN_part1.sh).  At the end of this script it will ask you to edit a few lines at the end of the vars file.  Basic address and email stuff.

Run the second script (install-EasyOpenVPN_part2.sh), the script will ask for more address info for your certificate.  MAKE SURE EACH QUESTION is answered with some text and except ALL defaults answers.  Leave NO BLANK answers, all fields should be are filled in.  

Do not change the "common name" when ask.  The script expects to see the name "server".






After the second script finishes, you should have a working openvpn server.

Type ifconfig and see if you have a tun0 interface as below.

root@pbx:~ $ ifconfig
eth0      Link encap:Ethernet  HWaddr F6:C5:DC:BD:B6:19  
          inet addr:192.168.100.142  Bcast:192.168.100.255  Mask:255.255.255.0
          inet6 addr: fe80::f4c5:dcff:febd:b619/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:17080 errors:0 dropped:0 overruns:0 frame:0
          TX packets:20773 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:5213256 (4.9 MiB)  TX bytes:3634713 (3.4 MiB)
          Interrupt:10 Base address:0xe000 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:373 errors:0 dropped:0 overruns:0 frame:0
          TX packets:373 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:33893 (33.0 KiB)  TX bytes:33893 (33.0 KiB)

tun0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  
          inet addr:10.8.0.1  P-t-P:10.8.0.2  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)



The firewall edit (udp port 1194) is not permant and will reset after a reboot.  You will need to edit you firewall manually.

The third script creates your client config files.  Run the create-openvpn-client.sh script and answer the questions (client name, server ip/fqdn address, etc.

The client config files will be placed into a dir /root/key/<client-name>.  Repeat this script for each client giving each client a NEW NAME.

After creating the client configs, place the <client-name>.tar file on your client.  

The client setup will vary depending on what type of client(s) you are using.  

If your using another pbxinaf pbx for the client, just run install-openvpn_part1.sh and dont make any edits after the script finishes.  Copy your client tar file to /etc/openvpn and untar.  Start openvpn by typeing "service openvpn start".

If your using Ubuntu, type "apt-get install openvpn install".  Copy your client tar file to /etc/openvpn and untar. Start openvpn by typing "/etc/init.d/openvpn restart".





