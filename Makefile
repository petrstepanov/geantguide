# Makefile for compiling GEANT simulation on Linux based systems.

SOURCES=guhadr.f guout.f gustep.f ugeom.f uginit.f uhinit.f gukine2.f guphad.f gutrev.f uglast.f cerenkov.f ggscnt.f guplsh.f
SOURCES_INT = $(SOURCES) gxint.f
SOURCES_BAT = $(SOURCES) main.f

# Create objects variables
OBJECTS_INT = $(SOURCES_INT:.f=.o)
OBJECTS_BAT = $(SOURCES_BAT:.f=.o)
$(info OBJECTS_INT=$(OBJECTS_INT))
$(info OBJECTS_BAT=$(OBJECTS_BAT))

#LIBS=${HOME}/Applications/geant3/lib64/libgeant321.so $(LIBDIR)/libGraf.so $(LIBDIR)/libGraf3D.so \
#$(LIBDIR)/libGX11.so $(LIBDIR)/libmathlib.a -L/${HOME}/Applications/root-debug/lib 

# Turn on this flag to dismiss compilation errors
FFLAGS=-I${HOME}/Applications/root/include/
FFLAGS+=-I/usr/include/cernlib/2006/
FFLAGS+=-I${HOME}/Development/geant3-1-11/geant321
# FFLAGS+=-I${HOME}/Applications/vmc/include/vmc/ 
# FFLAGS+=-fallow-argument-mismatch
$(info FFLAGS=$(FFLAGS))

LIBS=$(shell root-config --libs)
LIBS+=-L/usr/lib64/cernlib/2006/lib
LIBS+=-L${HOME}/Development/geant3-1-11/lib/tgt_linuxx8664gcc -lgeant321
# LIBS+=-L/home/petrstepanov/Applications/vmc/lib64 -lVMCLibrary
# LIBS+= -lnsl

$(info LIBS=$(LIBS))

# Compile and link in fortran
# https://stackoverflow.com/questions/31650093/link-multiple-object-files-in-gfortran

all: int bat

int: $(OBJECTS_INT)
	$(info Linking...)
	gfortran -o gbcal-int $(OBJECTS_INT) $(LIBS) --verbose

bat: $(OBJECTS_BAT)
	$(info Linking...)
	gfortran -o gbcal-bat $(OBJECTS_BAT) $(LIBS) --verbose

%.o: %.f
	$(info Compiling $@)
	gfortran -c $(FFLAGS) $< -o $@

clean:
	rm -rf $(OBJECTS_INT) $(OBJECTS_BAT) gbcal-bat gbcal-int
