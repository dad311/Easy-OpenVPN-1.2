echo "Please enter name for cert"
echo "Example: Desktop"
read name
echo "Please enter your FQDN"
echo "Example: mypbx.homelinux.com"
read fqdn

#Copy files for client setup
#cp /etc/openvpn/easy-rsa/vars /etc/openvpn/easy-rsa/2.0/
#cp /etc/openvpn/easy-rsa/keys/* /etc/openvpn/easy-rsa/2.0/keys/


cd /etc/openvpn/easy-rsa
source ./vars
./pkitool $name


rm /etc/openvpn/client.conf.tmp* > /dev/null

mkdir -p /root/keys/$name

#create client.conf
echo "client" >>/etc/openvpn/client.conf.tmp
echo "dev tun" >>/etc/openvpn/client.conf.tmp
echo "proto udp" >>/etc/openvpn/client.conf.tmp
echo "remote $fqdn 1194" >>/etc/openvpn/client.conf.tmp
echo "resolv-retry infinite" >>/etc/openvpn/client.conf.tmp
echo "nobind" >>/etc/openvpn/client.conf.tmp
echo "persist-key" >>/etc/openvpn/client.conf.tmp
echo "persist-tun" >>/etc/openvpn/client.conf.tmp
echo "ca /etc/openvpn/ca.crt" >>/etc/openvpn/client.conf.tmp
echo "cert /etc/openvpn/$name.crt" >>/etc/openvpn/client.conf.tmp
echo "key /etc/openvpn/$name.key" >>/etc/openvpn/client.conf.tmp
echo "comp-lzo" >>/etc/openvpn/client.conf.tmp
echo "verb 3" >>/etc/openvpn/client.conf.tmp
echo "cipher aes-128-cbc" >>/etc/openvpn/client.conf.tmp
echo "tls-auth /etc/openvpn/ta.key 1" >> /etc/openvpn/client.conf.tmp

cp /etc/openvpn/ca.crt /root/keys/$name
cp /etc/openvpn/ta.key /root/keys/$name
cp /etc/openvpn/easy-rsa/keys/$name.crt /root/keys/$name
cp /etc/openvpn/easy-rsa/keys/$name.key /root/keys/$name
cp /etc/openvpn/client.conf.tmp /root/keys/$name/$name.conf
cd /root/keys/$name
tar cvf /root/keys/$name/$name.tar . > /dev/null 
echo "Client config files saved to /root/keys/$name"
echo "Copy the tar file to the new client"

