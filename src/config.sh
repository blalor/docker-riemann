#!/bin/bash

set -e -x -u

cd /tmp/src

## incron to watch for changed riemann config
## java because … well … riemann
yum install -y incron java-1.7.0-openjdk bzip2

## install riemann
mkdir /opt/riemann
curl http://aphyr.com/riemann/riemann-0.2.5.tar.bz2 | tar -xjf - --strip-components=1 -C /opt/riemann/

## copy files
tar -c -C skel -f - . | tar -xf - -C /

## riemann will run as nobody
mkdir /var/log/riemann
chown nobody:nobody /var/log/riemann

## cleanup
cd /
yum clean all
rm -rf /var/tmp/yum-root* /tmp/src
