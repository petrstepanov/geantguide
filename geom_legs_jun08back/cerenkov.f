      Subroutine setupCerenkov
*      include 'geometry.inc'
      include 'gcommon/cerenkov'
      Data eff0/nbins*0.0/
      Data eff1/nbins*1.0/
      Data effPMT/
     + 0.0001,0.0001,0.0002,0.0002,0.0002,0.0002,0.0002,0.0001,
     + 0.0001,0.0001,0.0002,0.0004,0.0008,0.0015,0.0027,0.0045,
     + 0.0070,0.0104,0.0148,0.0203,0.0268,0.0346,0.0435,0.0535,
     + 0.0645,0.0763,0.0888,0.1020,0.1156,0.1296,0.1438,0.1582,
     + 0.1727,0.1873,0.2016,0.2156,0.2290,0.2412,0.2519,0.2604,
     + 0.2662,0.2691,0.2689,0.2657,0.2598,0.2512,0.2389,0.2208,
     + 0.1943,0.1583,0.1135/
*      Data alenLGD/nbins*280./

c      Data alenLGD/
c     + 275.83,258.83,258.83,251.08,251.08,275.83,275.83,275.83,
c     + 275.83,275.83,275.83,267.07,275.83,251.08,251.08,258.83,
c     + 236.88,236.88,251.08,267.07,275.83,275.83,275.83,275.83,
c     + 275.83,275.83,258.83,251.08,243.77,236.88,230.35,224.16,
c     + 212.72,207.42,202.37,188.57,184.37,176.49,162.55,153.43,
c     + 127.07, 91.92, 61.65, 43.27, 24.58, 11.82,  4.75,  1.69,
c     +   1.60,  1.60,  1.60/
      Data rindexLGD/nbins*1.60/
      Data rindexclada/nbins*1.49/
      Data rindexcladb/nbins*1.42/
c     Data alenGap/nbins*0.001/		! black paper wrapping (air gap)
c     Data rindexGap/nbins*1.00/	! is a very absorptive dielectric
c     Data alenGap/nbins*0.10/		! aluminum wrapping (no air gap)
c     Data rindexGap/nbins*0.00/	! is a reflective metal surface

      Data alenClad/nbins*1200.0/	! transparent air gap

      Data rindexGap/nbins*1.00/	! for total-internal-reflection
      Data alenWrap/nbins*100./		! aluminum wrapping (outside gap)
      Data rindexWrap/nbins*1.60/	! is a reflective metal surface
      Data alenAIR/nbins*30000./
      Data rindexAIR/nbins*1.00/
      Data alenPMT/nbins*0.001/
      Data rindexPMT/nbins*1.52/

      DATA rindexmir/0.0/
c      DATA abscomir/nbins*0.01/
c      Data alenLGD /nbins*30000./
c
c     measured reflectivity=0.75 based on GlueX-doc-656
c     assume mirror of 95% reflectivity
c
c      DATA abscomir/nbins*0.05/
c      Data alenLGD /nbins*240./
      DATA abscomir/nbins*0.15/
      Data alenLGD /nbins*240./

*      Data Ephot/nbins*2.43e-9/

      Data Ephot/
     + 1.54e-9,1.56e-9,1.58e-9,1.60e-9,1.62e-9,1.65e-9,1.67e-9,1.69e-9,
     + 1.72e-9,1.74e-9,1.76e-9,1.79e-9,1.82e-9,1.84e-9,1.87e-9,1.90e-9,
     + 1.93e-9,1.96e-9,1.99e-9,2.02e-9,2.06e-9,2.09e-9,2.13e-9,2.17e-9,
     + 2.21e-9,2.25e-9,2.29e-9,2.33e-9,2.37e-9,2.42e-9,2.47e-9,2.52e-9,
     + 2.57e-9,2.63e-9,2.68e-9,2.74e-9,2.81e-9,2.87e-9,2.94e-9,3.01e-9,
     + 3.09e-9,3.17e-9,3.25e-9,3.34e-9,3.43e-9,3.53e-9,3.63e-9,3.74e-9,
     + 3.86e-9,3.98e-9,4.12e-9/

      call GSCKOV(7,nbins,Ephot,alenAIR,eff0,rindexAIR)
C      call GSCKOV(med_GAP,nbins,Ephot,alenGap,eff0,rindexGap)
      call GSCKOV(4,nbins,Ephot,alenWrap,eff0,rindexWrap)
      call GSCKOV(5,nbins,Ephot,alenWrap,eff0,rindexWrap)

      call GSCKOV(9,nbins,Ephot,abscomir,eff0,rindexmir)

      call GSCKOV(2,nbins,Ephot,alenLGD,eff0,rindexLGD)
      call GSCKOV(21,nbins,Ephot,alenClad,eff0,rindexclada)
      call GSCKOV(22,nbins,Ephot,alenClad,eff0,rindexcladb)
      call GSCKOV(30,nbins,Ephot,alenLGD,eff0,rindexclada)

C      call GSCKOV(med_cathode,nbins,Ephot,alenPMT,eff1,rindexPMT)


      end
