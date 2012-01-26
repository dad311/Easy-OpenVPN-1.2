#Changelog
#1/21/2012 update to Centos6

#Make sure date is set
rdate -t 4 -s 129.6.15.28

echo "Downloading required files ........."
cd /root/EasyOpenVPN
wget http://openvpn.net/release/openvpn-2.1.3.tar.gz
wget http://openvpn.net/release/lzo-1.08-4.rf.src.rpm

echo "Installing required files ........." 
#yum install rpm-build -y
#yum install autoconf -y
#yum install automake -y
#yum install imake -y
#yum install autoconf.noarch -y
#yum install zlib-devel -y
yum install pam-devel -y
#yum install openssl-devel -y


#Install
MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then

  # 64-bit stuff here
wget http://download.fedora.redhat.com/pub/epel/5/x86_64/pkcs11-helper-devel-1.07-2.el5.1.x86_64.rpm
wget http://download.fedora.redhat.com/pub/epel/5/x86_64/pkcs11-helper-1.07-2.el5.1.x86_64.rpm
rpm -ivh /root/EasyOpenVPN/pkcs11-helper-1.07-2.el5.1.x86_64.rpm
rpm -ivh /root/EasyOpenVPN/pkcs11-helper-devel-1.07-2.el5.1.x86_64.rpm
rpmbuild --rebuild /root/EasyOpenVPN/lzo-1.08-4.rf.src.rpm
rpm -ivh /root/rpmbuild/RPMS/x86_64/lzo-*.rpm
rpmbuild -tb /root/EasyOpenVPN/openvpn-2.1.3.tar.gz
rpm -ivh /root/rpmbuild/RPMS/x86_64/openvpn-2.1.3-1.x86_64.rpm
else


  # 32-bit stuff here
wget http://download.fedora.redhat.com/pub/epel/6/i386/pkcs11-helper-1.07-5.el6.i686.rpm
wget http://download.fedora.redhat.com/pub/epel/6/i386/pkcs11-helper-devel-1.07-5.el6.i686.rpm
rpm -ivh /root/EasyOpenVPN/pkcs11-helper-*.rpm
rpmbuild --rebuild /root/EasyOpenVPN/lzo-1.08-4.rf.src.rpm
rpm -ivh /root/rpmbuild/RPMS/i686/lzo-*.rpm
rpmbuild -tb /root/EasyOpenVPN/openvpn-2.1.3.tar.gz
rpm -ivh /root/rpmbuild/RPMS/i686/openvpn-2.1.3-1.i686.rpm
fi


echo "Copying sample files"
cp -r /usr/share/doc/openvpn-2*/easy-rsa/ /etc/openvpn/
cp /usr/share/doc/openvpn-2*/sample-config-files/server.conf /etc/openvpn/
clear
echo "##############################################"
echo "STOP AND EDIT  /etc/openvpn/easy-rsa/2.0/vars"
echo "EDIT THE EXPORT lines at end of file"

echo "export KEY_COUNTRY="
echo "export KEY_PROVINCE="
echo "export KEY_CITY="
echo "export KEY_ORG="
echo "export KEY_EMAIL="
chkconfig openvpn on
