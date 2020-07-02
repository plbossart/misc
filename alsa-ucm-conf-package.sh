#!/usr/bin/bash

set -e

DEBIAN_VERSION=1.2.2
#https://github.com/alsa-project/alsa-ucm-conf
UPSTREAM_VERSION=ffe0cab
UPSTREAM_TARGET=1.2.3

DEBEMAIL="pierre-louis.bossart@linux.intel.com"
DEBFULLNAME="Pierre-Louis Bossart"
export DEBEMAIL DEBFULLNAME

sudo apt-get install dh-make devscripts
sudo apt-get build-dep alsa-ucm-conf

mkdir -p DEBIAN
cd DEBIAN
rm -rf alsa-ucm-conf*
mkdir alsa-ucm-conf-upstream
mkdir alsa-ucm-conf

cd alsa-ucm-conf
apt-get source alsa-ucm-conf

cd ../alsa-ucm-conf-upstream
wget https://github.com/alsa-project/alsa-ucm-conf/archive/$UPSTREAM_VERSION.zip

unzip $UPSTREAM_VERSION.zip
mv alsa-ucm-conf-$UPSTREAM_VERSION*/ alsa-ucm-conf-$UPSTREAM_TARGET

cd alsa-ucm-conf-$UPSTREAM_TARGET
dh_make -c bsd --single --createorig --yes
cp ../../alsa-ucm-conf/alsa-ucm-conf-$DEBIAN_VERSION/debian/*.install debian/

debuild -us -uc
