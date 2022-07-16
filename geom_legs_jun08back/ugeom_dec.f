      SUBROUTINE UGEOM

*'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*
*     Author:    R. Hakobyan, Z. Papandreou, B. Leverington         *
*                                                                   *
*       Date:    25 January 2005                                    *
*       Modified: 11/10/05  by B.L.                                 *
*                                                                   *
*  Real geometry of the Barrel Calorimeter is considered.           *
*  The thickness of an optical glue layer around the SciFis is      *
*  0.05mm, as well as there are glue boxes between the SciFis       *  
*  along the horizontal direction.                                  *
*  Horizontal distance between the centres of the SciFis is 1.35mm  *
*  and the vertical distance is 1.18mm.                             * 
*  The magnetic field crosses the direction of the inital particle. *
*                                                                   *
*  This code, which I named 'gBCal' is for one module of the GlueX  *
*  Barrel Calorimeter with the real geometry and shape (trapezoid). *
*                                                                   *
*'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*
      

*       Local variables
*******************************************************************
      INCLUDE 'gcommon/gckine'
      INCLUDE 'gcommon/gccuts'
      INCLUDE 'gcommon/gcuser'
      INCLUDE 'gcommon/gconsp'
      INCLUDE 'gcommon/gntcwn'


* Local variables
      real dx0siz, dy0siz, dxspot, dyspoy, bcxbox, bcybox
      real firad, rbcrad, bcring
      integer nx, ny, nz, ix, iy, iz, nscfi, geomfl
      integer ivol1, ivol2, ivol3, ivol
      integer imtsci, tmtsci, tmtpb, tmtair, ipbscb
     	DIMENSION PAR(10), AMAT(10), ZMAT(10), WMAT(10)
      	CHARACTER*20 CHNAMA, NATMED, NAMATE
        CHARACTER*4 CHNAME, CHSHAP, CHMOTH, CHONLY                 

C SciFi 
	REAL DFSCI
        real AFSCI(4), ZFSCI(4), WFSCI(4) 
	DATA DFSCI/1.049/
	DATA AFSCI,ZFSCI,WFSCI/12.01,1.01,14.01,16.
     +,      6.,1.,7.,8.,0.9213,0.0773,8.73E-4,5.03E-4/
        real FSCVOL(3) 
	DATA FSCVOL/0.0,0.05,195./

* CDC
	REAL VCDC(3)
        data VCDC/16.,60.,100./

C Target LH2
        real H2VOL(3) 
	DATA H2VOL/0.,2.,15./

C Target AL
        real ALVOL(3) 
	DATA ALVOL/2.,2.15,15.15/
        real ALBK(3) 
	DATA ALBK/0.,2.,0.075/
        real ALFR(3) 
	DATA ALFR/0.,2.,0.005/

* ST
        real STUBE(3) 
	DATA STUBE/6.,9.,25./
        real STCONE(5) 
	DATA STCONE/3.2,6.,9.,0.,3./

C Scintillator 
	REAL DSCI
        real ASCI(2), ZSCI(2), WSCI(2) 
	DATA DSCI/1.032/
	DATA ASCI,ZSCI,WSCI/12.01,1.01,6.,1.,8.,9./

* Optical Glue BC-600 
        real DBC600
        real ABC600(4), ZBC600(4), WBC600(4)
        DATA DBC600/1.18/
        DATA ABC600,ZBC600,WBC600
     +/12.01,1.01,16.,14.01,6.,1.,8.,7.,60.,79.,3.,2./

* Cladding 
        real CLDVLA(3) 
        real CLDVLB(3)

        data CLDVLA /0.048,0.0495, 195.0/
        data CLDVLB /0.0495,0.05, 195.0/

* Glue box between the SciFis
        real BCSPOT(3)    
        real BCSCIN(3)    
        DATA BCSPOT/0.0125,0.01,195./
        DATA BCSCIN/0.,0.055,195./  

C Pb BCal
        real PBVOL(11) 
	DATA PBVOL/195.,0.,0.,12.5,4.25424,5.8989116,0.,12.5,
     ,4.25424,5.8989116,0./

C Air in the grooved lead for the SciFi
        real HALAIR(3) 
	DATA HALAIR/0.,0.05,195./

C&& Mixed Pb,SciFi,BC600
	REAL DMIX
        real AMIX(3), ZMIX(3), WMIX(3) 
	DATA DMIX/4.9314/
	DATA AMIX,ZMIX,WMIX/207.2,11.059,11.291,82.,5.568,5.686,
     ,0.8653932,0.1025429,0.0320639/
        data thxinp,thyinp,thzinp/0.,0.,0./
        data dxinp,dyinp,diminp/0.,0.,0./
      real tmaxfd,stmax,deemax,epsil,stmin

C** Blake's attempt to have 48 modules
        real SPVOL(3),ang,brad
        DATA SPVOL/100.,100.,205./ 
        integer irot

        REAL THETB(3),PHB(3)
        DATA THETB/90.0,180.0,90.0/   !initial rotation angles for irot matrix
        DATA PHB/0.0,90.0,90.0/

C** test tubes for scintillation

* Cladding 
        real tCLDA(3) 
        real tCLDB(3)
        data tCLDA /.046,.049,195.0/
        data tCLDB /.049,.05,195.0/

        real tSCVOL(3) 
	DATA tSCVOL/0.0,.05,195.0/
        
        REAL tBCSCIN(3)
        DATA tBCSCIN/0.,0.055,195.0/  

C             Lead glass mixture parameters
C      
       REAL ZLG(6),ALG(6),WLG(6)
       DATA ZLG/  82.00,  19.00,  14.00,  11.00,  8.00,  33.00/
       DATA ALG/ 207.19,  39.102,  28.088,  22.99, 15.999,  74.922/
       DATA WLG/ .65994, .00799, .126676, .0040073,.199281, .00200485/

       REAL LGBLOC(3)
       DATA LGBLOC/2.5,15.0,2.5/

C** Light Guide
        real LGVOL(11) 
	DATA LGVOL/3.5,0.,0.,2.0,2.00,2.00,0.00,2.0,
     ,2.0,2.0,0./

** aluminum wrapping
*        real ALWRAP(11) 
*	DATA ALWRAP/10.0,0.,0.,2.01,2.14,2.31,2.434,2.1,
*     ,2.1,2.1,0./

** rounding the edges
        real AIRCON(5)
        DATA AIRCON/4.7065,1.4142,1.4142,0.2456,1.4142/

*        real TAPSQ(5)
*        DATA TAPSQ/1.0,0.7071,1.0,0.7071,0.85355/        
        real TAPSQ(11)
	DATA TAPSQ/2.000,26.56505,90.0,2.0,2.00,2.00,0.00,0.0,
     ,2.0,2.0,0./
         
       
        tpsq1=0.
        tpsq1=tapsq(1)
        LGVOL(1)=5-TAPSQ(1)
        lgvol1=0.
        lgvol1=lgvol(1) 
C Characteristic values for BCal
      IFIELD=0
      FIELDM=0.
      nmod=0
      dx=0.135   ! horizontal (X) dist. between the SciFis    
      dy=0.118   ! Y  dist. between the centres of the SciFis
      thy=25.    ! BCal thickness
      thymin=-12.5  ! min Y
      thymax=12.5   ! max Y
      stmax=11000.0  ! steps   
      deemax=0.1    ! energy per step   
      tmaxfd=0.5    ! bending angle
      epsil=0.0001  ! boundry presision    
      stmin=0.0001  ! boundry distance  
      thz=400.      ! length of the BCal module
      dx0=3.        ! segment size 
      dy0=3.        !
      firad=0.05    ! radius of the SciFi  
      dz=0.         ! 
      nscfi1=17000  ! # of SciFi can not exceed this #
      imtsci=17          ! med. #
      imglbc=35          ! med. #
      ipbscb=37          ! med. #
      imfsci=38          ! med. #
      geomfl=gcuts(1)      ! geometry mix. or real 
      bcxbox=0.025           ! glue box size
      bcybox=0.02            ! glue box size
      bcring=0.055           ! outer radius of the glue around the SciFi
      
C      print *,'You have entered incorrect value for the geometry?'
C      print *,'Try it again.'
C      stop
C      endif
 88   continue
      nscfi=0
      CALL GIDROP
*************************************************************************
*     Store standard particle and material constants
*************************************************************************
* basic particles
      CALL GPART
* heavier ions
      CALL GPIONS
* standard materials 
      CALL GMATE
      CALL GSMATE(18,'ARGON$',39.948,18.,0.00166,11762.31,46024.1,0,0)

*******************************************************************
* Barrel Calorimeter 
*******************************************************************
* Lab.
	CALL GSMIXT(17,'SCINT$',ASCI,ZSCI,DSCI,-2,WSCI)
	CALL GSMIXT(38,'FIBERS$',AFSCI,ZFSCI,DFSCI,4,WFSCI)
        CALL GSMIXT(35,'BC600$',ABC600,ZBC600,DBC600,-4,WBC600)
        CALL GSMIXT(40,'LEAD GLASS$',ALG,ZLG,5.2,6,WLG) 
  
      CALL GSTMED(7,'AIR$',15,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
        CALL GSVOLU('SPAC','BOX ',7, SPVOL, 3, IVol)
        CALL GSATT('SPAC','SEEN',0)

      if ((gcuts(1).eq.1).or.(gcuts(1).eq.2).or.(gcuts(1).eq.5)) then
        
* Target 
        CALL GSTMED(8,'TARGH2$',1,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
        CALL GSVOLU('HYDR','TUBE',8,H2VOL,3,IVol)
        
        CALL GSTMED(9,'TARGAL$',9,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
        CALL GSVOLU('ALUM','TUBE',9,ALVOL,3,IVol)

        CALL GSTMED(10,'TGALBK$',9,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
        CALL GSVOLU('BKAL','TUBE',10,ALBK,3,IVol)

        CALL GSTMED(11,'TGALFR$',9,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
        CALL GSVOLU('FRAL','TUBE',11,ALFR,3,IVol)
        

* ST 
        CALL GSTMED(12,'STSIDE$',imtsci,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
        CALL GSVOLU('STCT','TUBE',12,STUBE,3,IVol)

        CALL GSTMED(13,'STFR$',imtsci,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
        CALL GSVOLU('STFR','CONE',13,STCONE,5,IVol)

* CDC
        CALL GSTMED(14,'DCNT$',18,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
        CALL GSVOLU('DCNT','TUBE',14,VCDC,3,IVol)

*Lead glass block
        CALL GSTMED(15,'leadglass$',40,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
        CALL GSVOLU('LDGL','BOX ',15,LGBLOC,3,IVol)

*******************************************************************
* Tracking media parameters
*******************************************************************            
      if (geomfl.eq.1.or.gcuts(1).eq.5) then

	CALL GSTMED(1,'PBBC$',13,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
	CALL GSTMED(2,'SCIFI$',imfsci,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
	CALL GSTMED(21,'CLAD1$',imfsci,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
	CALL GSTMED(22,'CLAD2$',imfsci,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
	CALL GSTMED(30,'lightg$',imfsci,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)



         CALL GSTMED(4,'SPOT$',imglbc,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
         if (bcring.ne.firad) then
         CALL GSTMED(5,'LAYR$',imglbc,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
         endif

        CALL setupCerenkov 

*******************************************************************
* BCal geometry description
*******************************************************************    
      CALL GSVOLU('BCAL','TRAP', 1, PBVOL, 11, IVol)
      CALL GSVOLU('BCSC','TUBE', 5, BCSCIN, 3, IVol)
       CALL GSATT('BCSC','SEEN',-1)
      CALL GSVOLU('SCIN','TUBE', 2, FSCVOL, 3, IVol)
      CALL GSVOLU('CLD1','TUBE', 21, tCLDA, 3, IVol)
      CALL GSVOLU('CLD2','TUBE', 22, tCLDB, 3, IVol)
 
      CALL GSVOLU('BCRN','BOX ', 4, BCSPOT, 3, IVol)
        CALL GSATT('BCRN','SEEN',0)

      CALL GSVOLU('LTGD','TRAP', 30, LGVOL, 11, IVol)
      CALL GSVOLU('AIRC','CONE', 7, AIRCON, 5, IVol)
      CALL GSVOLU('TPSQ','TRAP', 30, TAPSQ, 11, IVol)
      CALL GSVOLU('TPMR','TRAP', 9, TAPSQ, 11, IVol)

* Positioning of the Scintil. Fibers and glue geometry

      CALL GSPOS('CLD1',1,'SCIN',0.,0.,0.,0,'ONLY')
      CALL GSPOS('CLD2',1,'SCIN',0.,0.,0.,0,'ONLY')

     

      zbc=0.
      ybc0=thymin
      ny=int(thy/dy)
         thyd=(thymax-thymin)/dy
         ny=int(thyd)
         thydif=thyd-int(thyd)
         if (thydif.ge.0.9) ny=ny+1
      nscfi1=nscfi1+1
      nscfi2=nscfi1+1
      if(bcring.ne.firad) then
          CALL GSPOS('SCIN',nscfi1,'BCSC',0.,0.,0.,0,'ONLY')
      endif    
      nxsc=0
      do iy=1,ny
         ybc=ybc0+(iy*dy-firad)
         thxmin=-5.006913291658734d0-0.06544984694978735d0*ybc
         thxmax=5.006913291658734d0+0.06544984694978735d0*ybc
         thxd=(thxmax-thxmin)/dx
         nx=int(thxd)
         thxdif=thxd-int(thxd)
         if (thxdif.ge.0.9) nx=nx+1
         nxsc=nxsc+nx
        if(mod(iy,2).gt.0) then
          do ix=1,nx
             xbc=thxmin+(ix*dx-firad)
          if(xbc.le.thxmax.and.(thxmax-xbc).gt.0.03) then      
          xbc1=xbc + dx/2             
      nscfi=nscfi+1
      if(bcring.eq.firad) then
          CALL GSPOS('SCIN',nscfi,'BCAL',xbc,ybc,zbc,0,'ONLY')
      else
          CALL GSPOS('BCSC',nscfi,'BCAL',xbc,ybc,zbc,0,'ONLY')
      endif
          if(ix.ne.nx) then
      nscfi2=nscfi2+1
           CALL GSPOS('BCRN',nscfi2,'BCAL',xbc1,ybc,zbc,0,'ONLY')
          endif
          endif
          enddo
        else
          do ix=1,nx                          
          xbc=thxmin+(ix*dx+((dx-2*firad)/2))
          if(xbc.le.thxmax.and.(thxmax-xbc).gt.0.03) then    
          xbc1=xbc+dx/2                        
      nscfi=nscfi+1
      if (bcring.eq.firad) then
          CALL GSPOS('SCIN',nscfi,'BCAL',xbc,ybc,zbc,0,'ONLY')
      else
          CALL GSPOS('BCSC',nscfi,'BCAL',xbc,ybc,zbc,0,'ONLY')
      endif
          if(ix.ne.nx) then
      nscfi2=nscfi2+1
           CALL GSPOS('BCRN',nscfi2,'BCAL',xbc1,ybc,zbc,0,'ONLY')
          endif
          endif
          enddo
       endif
      enddo
      if (gcuts(1).eq.5) goto 205
      else 

	CALL GSMIXT(37,'MIXE$',AMIX,ZMIX,DMIX,3,WMIX)
	CALL GSTMED(1,'PBSB$',ipbscb,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
	CALL GSTMED(2,'SCIFI$',imfsci,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)

        CALL setupCerenkov 

        CALL GSVOLU('BCAL','TRAP', 2, PBVOL, 11, IVol)

      endif
C** 2. put modules into SPACe (box filled with air)

        brad = 77.5 !bcal rad plus half thickness of module
        xring = 0.
        yring = 0.

        nmod = 48    !number of modules
        ang = 7.5   !angle between modules (360 degrees /48 modules)
c position the modules in SPACe
        do i=1,nmod
        xring = brad*cos(((i-1)*ang+3.75)*degrad)
        yring = brad*sin(((i-1)*ang+3.75)*degrad)

        irot = i !number of the rotation matrix
        bnum = i !copy number of bcal module
c rotate each module depending on position
        PHB(1) = (i-1)*ang-90.+3.75
        PHB(2) = (i-1)*ang+3.75
       CALL GSROTM(irot,THETB(1),PHB(1),THETB(2),PHB(2),THETB(3),PHB(3))
        CALL GSPOS('BCAL',bnum,'SPAC',xring,yring,0.,irot,'ONLY')
        enddo
C**


     


        CALL GSPOS('HYDR',101,'SPAC',0.,0.,-95.,0,'ONLY')
        CALL GSPOS('ALUM',102,'SPAC',0.,0.,-95.,0,'ONLY')
        CALL GSPOS('BKAL',103,'SPAC',0.,0.,-79.85,0,'ONLY')
        CALL GSPOS('FRAL',104,'SPAC',0.,0.,-110.0025,0,'ONLY')
        CALL GSPOS('STCT',105,'SPAC',0.,0.,-90.,0,'ONLY')
        CALL GSPOS('STFR',106,'SPAC',0.,0.,-61.8,0,'ONLY')
        CALL GSPOS('DCNT',107,'SPAC',0.,0.,-15.,0,'ONLY')

        endif !end of gcuts(1) = 1 or 2



        if (gcuts(1).eq.3.or.gcuts(1).eq.4) then

	CALL GSMIXT(37,'MIXE$',AMIX,ZMIX,DMIX,3,WMIX)
	CALL GSTMED(1,'PBSB$',ipbscb,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
	CALL GSTMED(2,'SCIFI$',imfsci,1,IFIELD,FIELDM,TMAXFD,1000.0
     +,0.0025,EPSIL,STMIN,0,0)
	CALL GSTMED(21,'CLAD1$',imfsci,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)
	CALL GSTMED(22,'CLAD2$',imfsci,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)

         CALL GSTMED(4,'SPOT$',imglbc,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)           
        CALL setupCerenkov 

      CALL GSVOLU('BCAL','TRAP', 1, PBVOL, 11, IVol)
      CALL GSVOLU('CLD1','TUBE', 21, tCLDA, 3, IVol)
      CALL GSVOLU('CLD2','TUBE', 22, tCLDB, 3, IVol)
      CALL GSVOLU('SCIN','TUBE', 2, tSCVOL, 3, IVol)
      CALL GSVOLU('BCSC','TUBE', 4, tBCSCIN, 3, IVol)


      CALL GSPOS('CLD1',1,'SCIN',0.,0.,0.,0,'ONLY')
      CALL GSPOS('CLD2',1,'SCIN',0.,0.,0.,0,'ONLY')
      CALL GSPOS('SCIN',1,'BCSC',0.,0.,0.,0,'ONLY')

      if (gcuts(1).eq.3) then
      CALL GSPOS('BCSC',1,'SPAC',0.,0.,0.,0,'ONLY')
      elseif (gcuts(1).eq.4) then
      CALL GSPOS('BCSC',1,'BCAL',0.,0.,0.,0,'ONLY')
      CALL GSPOS('BCAL',1,'SPAC',0.,0.,0.,0,'ONLY')
      endif
*      CALL GSPOS('BCAL',1,'SPAC',0.,0.,0.,0,'ONLY')

      endif !end of gcuts(1) = 3




 205  CONTINUE
       if (gcuts(1).eq.5) then
        brad = 77.5 !bcal rad plus half thickness of module
        xring = 0.
        yring = 0.

        nmod = 48    !number of modules
        ang = 7.5   !angle between modules (360 degrees /48 modules)
c position the modules in SPACe
        i=1
        xring = brad*cos(((i-1)*ang+3.75)*degrad)
        yring = brad*sin(((i-1)*ang+3.75)*degrad)

        irot = i !number of the rotation matrix
        bnum = i !copy number of bcal module
c rotate each module depending on position

*        PHB(1) = (i-1)*ang-90.+90.
*        PHB(2) = (i-1)*ang+90.
        
       CALL GSROTM(irot,THETB(1),PHB(1),THETB(2),PHB(2),THETB(3),PHB(3))
       CALL GSROTM(2,THETB(1),PHB(1),(THETB(2)+90.),
     &PHB(2),(THETB(3)+90.),PHB(3))
       CALL GSROTM(3,90.,0.,0.,0.,0.,0.)

*        CALL GSPOS('BCAL',bnum,'SPAC',xring,yring,0.,irot,'ONLY')
*       CALL GSPOS('BCAL',1,'SPAC',0.,77.5,0.,0,'ONLY')
*        CALL GSPOS('LDGL',bnum,'SPAC',xring,yring,197.5,irot,'ONLY')

*       CALL GSPOS('AIRC',1,'SPAC',0.,0.,(10-AIRCON(1)),0,'ONLY')
        CALL GSPOS('LTGD',1,'SPAC',0.,0.,(10-2*TAPSQ(1)-LGVOL(1)),0
     &,'ONLY')
       CALL GSPOS('TPSQ',1,'SPAC',0.,1.,(10-TAPSQ(1)),0,'ONLY')
       CALL GSPOS('TPMR',1,'SPAC',0.,-1.,(10-TAPSQ(1)),2,'ONLY')
       CALL GSPOS('LTGD',2,'SPAC',0.,5.,(10-TAPSQ(1)),3
     &,'ONLY')

*       CALL GSPOS('LTGD',2,'SPAC',0.,
*     &(TAPSQ(4)+LGVOL(1)),(10-TAPSQ(1)),irot,'ONLY')

      endif



      	CALL GGCLOS
      	CALL GPRINT('VOLU',0)
      	END
