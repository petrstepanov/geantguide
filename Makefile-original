# Makefile for compiling GEANT simulation on Linux based systems.

TOP_DIR=/localhome/leverin/geantguide

SOURCES=$(TOP_DIR)/guhadr.f $(TOP_DIR)/guout.f $(TOP_DIR)/gustep.f $(TOP_DIR)/ugeom.f $(TOP_DIR)/uginit.f $(TOP_DIR)/uhinit.f $(TOP_DIR)/gukine2.f $(TOP_DIR)/guphad.f $(TOP_DIR)/gutrev.f $(TOP_DIR)/uglast.f $(TOP_DIR)/cerenkov.f $(TOP_DIR)/ggscnt.f $(TOP_DIR)/guplsh.f

LIBDIR=$(CERN_ROOT)/lib
GRAPH=/usr/lib

LIBS=$(LIBDIR)/libgeant321.a $(LIBDIR)/libpawlib.a $(LIBDIR)/libgraflib.a \
$(LIBDIR)/libgrafX11.a $(LIBDIR)/liblapack3.a $(LIBDIR)/libblas.a \
$(LIBDIR)/libpacklib.a $(LIBDIR)/libmathlib.a $(GRAPH)/libX11.so.6.2.0 \
 -L/usr/X11R6/lib -lnsl -lcrypt -ldl

int: $(SOURCES) $(TOP_DIR)/gxint.f 

	@if [ -n "${CERN_ROOT}" ]; then \
	        g77 $(SOURCES) $(TOP_DIR)/gxint.f -o gbcal-int $(LIBS); \
	else \
		echo ERROR: CERN_ROOT environment variable is not defined.; \
	fi;

bat: $(SOURCES) $(TOP_DIR)/main.f

	@if [ -n "${CERN_ROOT}" ]; then \
		g77 $(SOURCES)  $(TOP_DIR)/main.f -o gbcal-bat $(LIBS); \
	else \
		echo ERROR: CERN_ROOT environment variable is not defined.; \
	fi;

