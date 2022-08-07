Development Environment setup on Fedora
---------------------------------------

GeantGuide code utilizes rudimentary `Geant3` framework and `cernlib` libries. Modern Linux systems do not offer `cernlib` package. It is rather  challenging to satisfy the build dependencies on a modern operating system. It is easier to compile and run the software on an older Linux version. GeantGuide code is dated Jan 2008. Therefore we will stick to an older [Fedora Linux](https://en.wikipedia.org/wiki/Fedora_Linux_release_history) versions released in 2007 and earlier. Here is a list of OS that were tested:

* Fedora 7 (May 2007) - everything compiles but getting error `locb/locf address exceeds the 32 bit address space` upon running the executable.
* Fedora 8 (Nov 2007) - testing now...

Download and install Fedora version 8 in a virtual machine from:
https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/

During the setup mark "Software Development" and "Additional Software Reporitories" to be installed. Disable Firewall and SELinux during the setup to avoid potential issues. After install, run `yum -y upgrade` twice. First it imports the repo and then updated the system.


Compile Pythia 6
================

ROOT install with Pythia version 6 is required by the Geant3 library. Obtain Pythia 6 sources from [CERN web repository](https://root.cern.ch/download/) (not official Pythia website). Pythia 6 source code hosted at CERN contains required ROOT bindings. Download link: [https://root.cern.ch/download/pythia6.tar.gz](https://root.cern.ch/download/pythia6.tar.gz).

Extract to `~/Development/pythia6`. Run `./makepythia6.linuxx8664`.


Compile ROOT 5
==============

Install ROOT dependencies:

```
su
yum -y groupinstall "Development Tools" "Development Libraries"
yum -y install git cmake gcc binutils libX11-devel libXpm-devel libXft-devel libXext-devel python-devel openssl-devel
yum -y install redhat-lsb gcc-gfortran pcre-devel mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel mysql-devel fftw* cfitsio-devel graphviz-devel avahi-compat-libdns_sd-devel openldap-devel python-devel numpy libxml2-devel gsl-devel uuid* readline-devel R-devel
yum -y install compat-gcc-34-g77 xorg-x11-fonts
exit
```

Download ROOT v.5.26 (release Dec 2009) from official website (https://root.cern/install/all_releases/)[https://root.cern/install/all_releases/]. Extract in `~/Development/root` and run following commands in Terminal:

```
./configure --help
./configure --enable-pythia6 --with-pythia6-libdir=$HOME/Development/pythia6
make
export ROOTSYS=$HOME/Applications/root
make install
```

Add `source $HOME/Applications/root/bin/thisroot.sh` to `~/.bashrc`.


Compile Geant3
==============

Download Geant3 version from: [https://github.com/vmc-project/geant3/tags](https://github.com/vmc-project/geant3/tags). Geant3 v.1.9 dated Dec 2009 seems to be a reasonable choice with respect to the geantguide source code timestamp. Unpack under `~/Development/geant3-1-9`. Simply run `make` in Terminal.

Compile geantguide
==================

Install the geantguide dependences:

```
su
yum -y install cernlib-devel
exit
```

There is no easy way to check out this repository in Fedora 8 since its Git version does not support SSL. Therefore, find a way to download the archive and move it to the Fedora 8 computer

```
cd geantguide
```

Few Tips
==================

To check the package contents on Fedora, install `yum-utils` package and run `repoquery -l <package-name>` command.
