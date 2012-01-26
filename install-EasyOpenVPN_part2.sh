cp -R /etc/openvpn/easy-rsa/2.0/* /etc/openvpn/easy-rsa/
echo "Cleaning and building"

cd /etc/openvpn/easy-rsa/
. ./vars
./clean-all
./build-ca
source vars
#./clean-all
./build-dh
# Generate ta.key
/usr/sbin/openvpn --genkey --secret /etc/openvpn/ta.key


echo "Please select y for Sign certificate AND commit"
 ./build-key-server server
 
echo "copying certs and keys"
cp keys/ca.crt ../   
cp keys/dh1024.pem ../  
cp keys/server.key ../  
cp keys/server.crt ../  


echo "Editing OpenVPN server config file"

mv /etc/openvpn/server.conf /etc/openvpn/server.conf.orig

echo "port 1194" > /etc/openvpn/server.conf
echo "proto udp" >> /etc/openvpn/server.conf
echo "dev tun" >> /etc/openvpn/server.conf
echo "ca ca.crt" >> /etc/openvpn/server.conf
echo "cert server.crt" >> /etc/openvpn/server.conf
echo "key server.key" >> /etc/openvpn/server.conf
echo "dh dh1024.pem" >> /etc/openvpn/server.conf
echo "server 10.8.0.0 255.255.255.0" >> /etc/openvpn/server.conf
echo "ifconfig-pool-persist ipp.txt" >> /etc/openvpn/server.conf
echo "verb 3" >> /etc/openvpn/server.conf
echo "cipher AES-128-CBC" >> /etc/openvpn/server.conf
echo "tls-auth ta.key 0"  >> /etc/openvpn/server.conf
echo "comp-lzo" >> /etc/openvpn/server.conf
echo "#Uncomment the line below to allow different clients to be able to "see" each other." >> /etc/openvpn/server.conf
echo ";client-to-client" >> /etc/openvpn/server.conf

#Cleanup
rm /etc/openvpn/server.conf.tmp*


#open firewall to allow UDP 1194

echo "Opening up firewall to except connections on UDP 1194"
iptables -A INPUT -p udp --dport 1194 -j ACCEPT
service iptables save
echo " Saving Firewall configuration"
sleep 3

echo " Restarting the firewall"
service openvpn restart
sleep 3

 
#Turn on openvpn so it will auto start.
chkconfig openvpn on

clear

echo " Below you should see you OpenVPN tun0 interface:"
ifconfig tun0

echo " Install Complete "
echo " "
echo "Press Enter to continue:"
read none



