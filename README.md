Development Environment setup on Fedora
---------------------------------------

GeantGuide code utilizes rudimentary `Geant3` framework and `CERNLIB` libries. Modern Linux systems do not offer `cernlib` package. It is rather  challenging to satisfy the build dependencies on a modern operating system. It is easier to compile and run the software on an older Linux version. GeantGuide code is dated Jan 2008. Therefore we will stick to an older [Fedora Linux](https://en.wikipedia.org/wiki/Fedora_Linux_release_history) versions released in 2007 and earlier. Here is a list of OS that were tested:

* Fedora 7 x84_64 (May 2007) - everything compiles but getting error `locb/locf address exceeds the 32 bit address space` upon running the executable.
* Fedora 8 x86_64 (Nov 2007) - same problem, seems that there a [problem running Geant3 applications with CERNLIB on 64 bit](https://mailman.jlab.org/pipermail/halld-offline/2012-December/001214.html). What tried: build static cernlib libs, link cernlib and lapack statically not dynamicaly, using -O0 flags, -fno-automatic, [link with libpacklib_noshift](https://root-forum.cern.ch/t/h2root-with-amd-x2/4104/3).
* Fedora 8 i386 (Nov 2007) - testing now.

Download and install Fedora version 8 in a virtual machine from:
https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/

During the setup mark "Software Development" and "Additional Software Reporitories" to be installed. Disable Firewall and SELinux during the setup to avoid potential issues. After install, run `yum -y upgrade` twice. First it imports the repo and then updated the system.


Compile Pythia 6
================

ROOT install with Pythia version 6 is required by the Geant3 library. Obtain Pythia 6 sources from [CERN web repository](https://root.cern.ch/download/) (not official Pythia website). Pythia 6 source code hosted at CERN contains required ROOT bindings. Download link: [https://root.cern.ch/download/pythia6.tar.gz](https://root.cern.ch/download/pythia6.tar.gz). Extract to `~/Development/pythia6`. Run:
```
su
yum install -y compat-gcc-34-g77
exit
cd ~/Development/pythia6
chmod +x ./makepythia6*
./makepythia6.linux`
```


Compile ROOT 5 with Pythia 6
============================

Install ROOT dependencies:

```
su
yum -y groupinstall "Development Tools" "Development Libraries"
yum -y install git cmake gcc binutils libX11-devel libXpm-devel libXft-devel libXext-devel python-devel openssl-devel
yum -y install redhat-lsb gcc-gfortran pcre-devel mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel mysql-devel fftw* cfitsio-devel graphviz-devel avahi-compat-libdns_sd-devel openldap-devel python-devel numpy libxml2-devel gsl-devel uuid* readline-devel R-devel
yum -y install xorg-x11-fonts
exit
```

Download ROOT v.5.26 (release Dec 2009)  from official website [https://root.cern/download](https://root.cern/download/). Release info is here [https://root.cern/install/all_releases](https://root.cern/install/all_releases/). Extract in `~/Development/root` and run following commands in Terminal:

```
./configure --help
./configure --enable-pythia6 --with-pythia6-libdir=$HOME/Development/pythia6
make
export ROOTSYS=$HOME/Development/root-install
make install
```

Add `source $HOME/Development/root-install/bin/thisroot.sh` to `~/.bashrc`.


Compile Geant3
==============

Download Geant3 version from: [https://github.com/vmc-project/geant3/tags](https://github.com/vmc-project/geant3/tags). Geant3 v.1.9 dated Dec 2007 seems to be a reasonable choice with respect to the geantguide source code timestamp. Unpack under `~/Development/geant3-1-9`. Simply run `make` inside this folder in Terminal.

Compile 64 bit CERNLIB
======================

CERNLIB shared libraries in Fedora 8 repositories seem to have an issue. When running the geantguide program, following error output is provided:
```
locb/locf address exceeds the 32 bit address space
```

Therefore, we need to compile them from source to get 64-bit version. Navigate to [CERNLIB website](https://cernlib.web.cern.ch/cernlib/) and download "[compressed tar files](https://cernlib.web.cern.ch/cernlib/download/2006_source/tar/)" from the 2006 sources. We will need three archives: `2006_src.tar.gz`, `include.tar.gz` (and maybe `mathlib32_src.tar.gz`). Place above files under `~/Devlopment/CERNLIB` folder.

Next, we will create build and install script for the CERNLIB framework. Create a `~/Devlopment/CERNLIB/install-cernlib.sh` file with following content:

```
#!/bin/sh

# Unpack the source files and set up the build structure, e.g.
#  /tmp/cernlib/2003/src (and lib)

list=`ls | grep tar.gz`

for ffile in $list
do
  gunzip -c $ffile | tar xf -
done

# Establish the environment variables for the build procedures
# Depending on the system, other directories may need to be added to the PATH
# e.g. for the build tools and alternative compilers.

CERN_LEVEL=2006

CERN=`pwd`
CERN_ROOT=$CERN/$CERN_LEVEL
CVSCOSRC=$CERN/$CERN_LEVEL/src
PATH=$CERN_ROOT/bin:$PATH

export CERN
export CERN_LEVEL
export CERN_ROOT 
export CVSCOSRC
export PATH

# Create the build directory structure

cd $CERN_ROOT
mkdir -p build bin lib build/log

# Patch iconwidget.c
sed -i "s;void   _XmDrawShadow ();// void   _XmDrawShadow ();" ./src/packlib/kuip/code_motif/iconwidget.c

# Create the top level Makefile with imake

cd $CERN_ROOT/build
$CVSCOSRC/config/imake_boot

# Install kuipc and the scripts (cernlib, paw and gxint) in $CERN_ROOT/bin

gmake bin/kuipc | tee log/kuipc 2>&1
gmake scripts/Makefile
cd scripts
gmake install.bin | tee ../log/scripts 2>&1

# Install the libraries

cd $CERN_ROOT/build
gmake | tee log/make.`date +%m%d` 2>&1
```

Above script is based on the official CERNLIB build notes [posted here](https://cernlib.web.cern.ch/cernlib/install/install.html) and [Matt Bellis post here](https://halldweb.jlab.org/wiki/index.php/CERNLIB_Installation). Next, build CERNLIB with following commands:

```
cd ~/Development/CERNLIB
chmod +x ./install-cernlib.sh
./install-cernlib.sh
```


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

Check the package contents on Fedora, install `yum-utils` package and run: `repoquery -l <package-name>`.

Check if library is 32 or 64 bit: `file <library-path>`.

List symbols in a library: `nm -D <library-path>`.

List shared libraries in a binary: `ldd <binary>`.
