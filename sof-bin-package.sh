#!/usr/bin/bash

set -e

#https://github.com/plbossart/sof-bin/tree/stable-v1.5.1
UPSTREAM_VERSION=5d3249f
UPSTREAM_TARGET=1.5.1

DEBEMAIL="pierre-louis.bossart@linux.intel.com"
DEBFULLNAME="Pierre-Louis Bossart"
export DEBEMAIL DEBFULLNAME

sudo apt-get install dh-make devscripts

mkdir -p DEBIAN
cd DEBIAN
rm -rf sof-bin*
mkdir sof-bin

cd sof-bin

wget https://github.com/thesofproject/sof-bin/archive/$UPSTREAM_VERSION.zip

unzip $UPSTREAM_VERSION.zip
mv sof-bin-$UPSTREAM_VERSION*/ sof-bin-$UPSTREAM_TARGET

cd sof-bin-$UPSTREAM_TARGET
dh_make -c bsd --single --createorig --yes

debuild -us -uc

cd ..

# install with this:
#sudo dpkg -i sof-bin_$UPSTREAM_TARGET-1_amd64.deb
