sudo virt-install \
 -n opnsense \
 --description OPNsense router \
 --os-variant=openbsd5.8 \
 --ram=2048 \
 --vcpus=2 \
 --check path_in_use=off \
 --disk pool=default,size=10,format=qcow2 \
 --graphics vnc,listen=0.0.0.0 \
 --cdrom OPNsense-21.7.1-OpenSSL-dvd-amd64.iso \
 --network bridge=br0 \
 --network network=default
