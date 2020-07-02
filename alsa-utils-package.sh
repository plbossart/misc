#!/usr/bin/bash

set -e

DEBIAN_VERSION=1.2.2

#https://github.com/alsa-project/alsa-utils/tree/v1.2.3
UPSTREAM_VERSION=247d9e3
UPSTREAM_TARGET=1.2.3

DEBEMAIL="pierre-louis.bossart@linux.intel.com"
DEBFULLNAME="Pierre-Louis Bossart"
export DEBEMAIL DEBFULLNAME

#sudo apt-get install dh-make devscripts
#sudo apt-get build-dep alsa-utils

mkdir -p DEBIAN
cd DEBIAN
rm -rf alsa-utils*
mkdir alsa-utils-upstream
mkdir alsa-utils

cd alsa-utils
apt-get source alsa-utils

cd ../alsa-utils-upstream
wget https://github.com/alsa-project/alsa-utils/archive/$UPSTREAM_VERSION.zip

unzip $UPSTREAM_VERSION.zip
mv alsa-utils-$UPSTREAM_VERSION*/ alsa-utils-$UPSTREAM_TARGET

cd alsa-utils-$UPSTREAM_TARGET
dh_make -c lgpl --single --createorig --yes
cp ../../alsa-utils/alsa-utils-$DEBIAN_VERSION/debian/*.install debian/

debuild -us -uc
