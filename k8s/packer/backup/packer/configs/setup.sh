#!/bin/sh

set -ex

apk add libressl
apk add open-vm-tools
rc-update add open-vm-tools
/etc/init.d/open-vm-tools start
apk add --no-cache  --repository http://dl-cdn.alpinelinux.org/alpine/edge/main --repository  http://dl-cdn.alpinelinux.org/alpine/edge/community  docker py-pip python-dev libffi-dev openssl-dev gcc libc-dev make
rc-update add docker boot
pip install docker-compose

echo " starting Docker"
service docker start

echo "loading images into docker"
docker load --input /media/floppy/rancheros.tar.gz

echo "show image list"
docker images

echo "copying docker compose file"
mkdir /docker/
cp /media/floppy/docker-compose.yml /docker/
cp -R /media/floppy/data /docker/
echo "copying docker compose init.d"
cp /media/floppy/docker-compose /etc/init.d/docker
rc-update add docker-compose boot
service docker-compose start
service docker-compose status

echo "testing docker compose"
cd /docker
docker-compose up -d


cat >/usr/local/bin/shutdown <<EOF
#!/bin/sh
poweroff
EOF
chmod +x /usr/local/bin/shutdown

sed -i "/#PermitRootLogin/c\PermitRootLogin yes" /etc/ssh/sshd_config
mkdir ~/.ssh
wget https://raw.githubusercontent.com/jetbrains-infra/packer-builder-vsphere/master/test/test-key.pub -O ~/.ssh/authorized_keys
/etc/init.d/sshd restart