#!/usr/bin/bash

set -e

DEBIAN_VERSION=1.2.2
#https://github.com/alsa-project/alsa-lib/tree/v1.2.3.2
UPSTREAM_VERSION=cac5a62
UPSTREAM_TARGET=1.2.3.2

DEBEMAIL="pierre-louis.bossart@linux.intel.com"
DEBFULLNAME="Pierre-Louis Bossart"
export DEBEMAIL DEBFULLNAME

sudo apt-get install dh-make devscripts
sudo apt-get build-dep alsa-lib

mkdir -p DEBIAN
cd DEBIAN
rm -rf alsa-lib*
mkdir alsa-lib-upstream
mkdir alsa-lib

cd alsa-lib
apt-get source alsa-lib

cd ../alsa-lib-upstream
wget https://github.com/alsa-project/alsa-lib/archive/$UPSTREAM_VERSION.zip

unzip $UPSTREAM_VERSION.zip
mv alsa-lib-$UPSTREAM_VERSION*/ alsa-lib-$UPSTREAM_TARGET

cd alsa-lib-$UPSTREAM_TARGET
dh_make -c lgpl --single --createorig --yes
cp ../../alsa-lib/alsa-lib-$DEBIAN_VERSION/debian/*.install debian/

debuild -us -uc

cd ..

# install with this:
https://github.com/alsa-project/alsa-ucm-conf#sudo dpkg -i --force-overwrite alsa-lib_$UPSTREAM_TARGET-1_amd64.deb
