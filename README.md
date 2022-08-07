Development Environment setup on Fedora
---------------------------------------

Download and install Fedora version 8 in a virtual machine from:
https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/

Disable Firewall and SELinux during the setup to avoid potential issues.

TODO: try Feadora v 11. Refer to release info here: 
https://en.wikipedia.org/wiki/Fedora_Linux_release_history

GeantGuide code dated ~ Jan 2008.

* Fedora 7 (May 2007) - everything compiles but getting error `locb/locf address exceeds the 32 bit address space`.
* Fedora 8 (Nov 2007) - testing now...
* Fedora 9 (May 2008) - ?
* Fedora 10 (Nov 2008) - samba not working
* Fedora 11 (Jun 2009) - netinst checksum fails, update servers do not work.

Compile Pythia 6
================

ROOT install with Pythia version 6 is required by the Geant3 library. Obtain Pythia 6 sources from [CERN web repository](https://root.cern.ch/download/) (not official Pythia website). Pythia 6 source code hosted at CERN contains required ROOT bindings. Download link: [https://root.cern.ch/download/pythia6.tar.gz](https://root.cern.ch/download/pythia6.tar.gz).

Extract to `~/Development/pythia6`. Run `./makepythia6.linuxx8664`.

Compile ROOT 5.26 (Dec 2009)
============================

Install ROOT dependencies:

```
sudo yum -y groupinstall "Development Tools" "Development Libraries"
sudo yum -y install git cmake gcc binutils libX11-devel libXpm-devel libXft-devel libXext-devel python-devel openssl-devel

sudo yum -y install redhat-lsb gcc-gfortran pcre-devel mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel mysql-devel fftw* cfitsio-devel graphviz-devel avahi-compat-libdns_sd-devel openldap-devel python-devel numpy libxml2-devel gsl-devel uuid* readline-devel R-devel
```
Download ROOT v.5.20 (Jun 2008) sources from official website (https://root.cern/install/all_releases/)[https://root.cern/install/all_releases/].
./configure --help
./configure --enable-pythia6 --with-pythia6-libdir=$HOME/Development/pythia6 --disable-gsl-shared
make
export ROOTSYS=$HOME/Applications/root
make install

add "source $HOME/Applications/root/bin/thisroot.sh" to ~/.bashrc

Compile Geant3 v1.11
====================

Download corresponding version from: https://github.com/vmc-project/geant3/tags
Just "make"

Compile geantguide
==================

Dependencies: timex - cernlib-devel?
yum install yum-utils
repoquery -l cernlib-devel
