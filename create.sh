#!/bin/bash

yum install -y \redhat-lsb-core \wget \rpmdevtools \rpm-build \createrepo \yum-utils \gcc

wget https://nginx.org/packages/centos/8/SRPMS/nginx-1.20.2-1.el8.ngx.src.rpm

rpm -i nginx-1.*

wget https://github.com/openssl/openssl/archive/refs/heads/OpenSSL_1_1_1-stable.zip

unzip OpenSSL_1_1_1-stable.zip

yum-builddep -y ~/rpmbuild/SPECS/nginx.spec

sed -i 's:--with-debug:--with-openssl=/home/vagrant/openssl-OpenSSL_1_1_1-stable \\\n --with-debug:' ~/rpmbuild/SPECS/nginx.spec

rpmbuild -bb ~/rpmbuild/SPECS/nginx.spec

yum localinstall -y ~/rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el8.ngx.x86_64.rpm

systemctl start nginx
systemctl status nginx

mkdir /usr/share/nginx/html/repo

cp ~/rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el8.ngx.x86_64.rpm /usr/share/nginx/html/repo/


wget https://downloads.percona.com/downloads/percona-distribution-mysql-ps/percona-distribution-mysql-ps-8.0.28/binary/redhat/8/x86_64/percona-orchestrator-3.2.6-2.el8.x86_64.rpm -O /usr/share/nginx/html/repo/percona-orchestrator-3.2.6-2.el8.x86_64.rpm


createrepo /usr/share/nginx/html/repo/

sed -i 's/index  index.html index.htm;/index  index.html index.htm;\n        autoindex on;/' /etc/nginx/conf.d/default.conf

nginx -s reload

cat >> /etc/yum.repos.d/otus.repo << EOF
[otus]
name=otus-linux
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF
yum install -y percona-orchestrator.x86_64
