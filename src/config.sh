#!/bin/bash

set -e -x -u

cd /tmp/src

yum localinstall -y http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm

## incron to watch for changed riemann config
## nginx for HTTP proxying
yum install -y incron bzip2 nginx

## install riemann
mkdir /opt/riemann
curl http://aphyr.com/riemann/riemann-0.2.6.tar.bz2 | tar -xjf - --strip-components=1 -C /opt/riemann/

## copy files
tar -c -C skel -f - . | tar -xf - -C /

## riemann will run as nobody
mkdir /var/log/riemann
chown nobody:nobody /var/log/riemann

## cleanup
cd /
yum clean all
rm -rf /var/tmp/yum-root* /tmp/src
