      SUBROUTINE UGEOM

*'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*
*     Author:    R. Hakobyan, Z. Papandreou, B. Leverington         *
*                                                                   *
*       Date:    25 January 2005                                    *
*       Modified: 11/10/05  by B.L. 
*       Modified: Dec 2006 Elton trim for use with Bcal outer pmt light guides
*
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

C Scintillator 
	REAL DSCI
        real ASCI(2), ZSCI(2), WSCI(2) 
	DATA DSCI/1.032/
	DATA ASCI,ZSCI,WSCI/12.01,1.01,6.,1.,8.,9./

C SciFi 
	REAL DFSCI
        real AFSCI(4), ZFSCI(4), WFSCI(4) 
	DATA DFSCI/1.049/
	DATA AFSCI,ZFSCI,WFSCI/12.01,1.01,14.01,16.
     +,      6.,1.,7.,8.,0.9213,0.0773,8.73E-4,5.03E-4/
        real FSCVOL(3) 
	DATA FSCVOL/0.0,0.05,195./


* Optical Glue BC-600 
        real DBC600
        real ABC600(4), ZBC600(4), WBC600(4)
        DATA DBC600/1.18/
        DATA ABC600,ZBC600,WBC600
     +/12.01,1.01,16.,14.01,6.,1.,8.,7.,60.,79.,3.,2./


C Air in the grooved lead for the SciFi
        real HALAIR(3) 
	DATA HALAIR/0.,0.05,195./

C** Light Guide
        real LGVOL(11) 
c	DATA LGVOL/3.5,0.,0.,2.0,2.00,2.00,0.00,2.0,
c     ,2.0,2.0,0./
	DATA LGVOL/35.,0.,0.,2.875,2.875,2.875,0.00,2.875,
     ,2.875,2.875,0./
c
c       unsymmetric legs to light guide
c
        real LGVOL2(11) 
	DATA LGVOL2/37.54,0.,0.,2.875,2.875,2.875,0.,2.875,
     ,2.875,2.875,0./

** aluminum wrapping
*        real ALWRAP(11) 
*	DATA ALWRAP/10.0,0.,0.,2.01,2.14,2.31,2.434,2.1,
*     ,2.1,2.1,0./

** rounding the edges

        real AIRCON(5)
        DATA AIRCON/2.54,2.8284,4.0659,4.0659,4.0659/
c
c        cylinder for 2" and 3" tubes.
c
c         DATA AIRCON/2.54,0.,2.54,0.,2.54/
c         DATA AIRCON/2.54,0.,3.81,0.,3.81/
   
        real TAPSQ(11)
	DATA TAPSQ/2.875,26.56505,90.0,2.875,2.875,2.875,0.00,0.0,
     ,2.875,2.875,0./
c	DATA TAPSQ/2.875,26.56505,90.,2.875,1.,2.875,0.00,2.875,
c     ,1.,2.875,0./ 

        real WEDGE(11)
	DATA WEDGE/35,0.,0.0,2.875,0.175,0.,0.00,2.875,
     ,0.175,0.,0./

        real SPVOL(3),ang,brad
        DATA SPVOL/100.,100.,205./        
        integer irot

        REAL THETB(3),PHB(3)
        DATA THETB/90.0,180.0,90.0/   !initial rotation angles for irot matrix
        DATA PHB/0.0,90.0,90.0/
c
c        LGVOL(1)=5-TAPSQ(1)
c
c       compute angle for wedge
c
      wedge(1) = lgvol(1)+tapsq(1)
      wedge(7)= 180.*atan2(wedge(6)-wedge(5),2*wedge(4))/3.14159
      wedge(11)= 180.*atan2(wedge(10)-wedge(9),2*wedge(8))/3.14159
c
      print *, ' angles=', lgvol2(7),lgvol2(11),tapsq(2),tapsq(7)
     &   ,tapsq(11)
c
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
c
c       call routine to setup properties of light guides and optical photons
c
        CALL setupCerenkov 

*******************************************************************

      IFIELD=0
      FIELDM=0.
      imfsci=38          ! med. #

      stmax=11000.0  ! steps   
      deemax=0.1    ! energy per step   
      tmaxfd=0.5    ! bending angle
      epsil=0.0001  ! boundry presision    
      stmin=0.0001  ! boundry distance

      CALL GSMIXT(38,'FIBERS$',AFSCI,ZFSCI,DFSCI,4,WFSCI)

      CALL GSTMED(7,'AIR$',15,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)

        CALL GSTMED(9,'TARGAL$',9,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)

	CALL GSTMED(30,'lightg$',imfsci,1,IFIELD,FIELDM,TMAXFD,STMAX
     +,DEEMAX,EPSIL,STMIN,0,0)

        CALL setupCerenkov 

        CALL GSVOLU('SPAC','BOX ',7, SPVOL, 3, IVol)
        CALL GSATT('SPAC','SEEN',0)

      CALL GSVOLU('LTGD','TRAP', 30, LGVOL, 11, IVol)
      CALL GSVOLU('LTG2','TRAP', 30, LGVOL2, 11, IVol)
      CALL GSVOLU('AIRC','CONE', 7, AIRCON, 5, IVol)
      CALL GSVOLU('TPSQ','TRAP', 30, TAPSQ, 11, IVol)
      CALL GSVOLU('TPMR','TRAP', 9, TAPSQ, 11, IVol)
      CALL GSVOLU('WEDG','TRAP', 7, WEDGE, 11, IVol)

c rotate each module depending on position

        
       CALL GSROTM(1,THETB(1),PHB(1),THETB(2),PHB(2),THETB(3),PHB(3))
       CALL GSROTM(2,THETB(1),PHB(1),(THETB(2)+90.),
     &PHB(2),(THETB(3)+90.),PHB(3))
       CALL GSROTM(3,90.,0.,0.,0.,0.,0.)

        CALL GSPOS('WEDG',1,'SPAC',-(lgvol(5)-wedge(5)/2),0.,
     &   (10-WEDGE(1)),0,'ONLY')
        CALL GSPOS('AIRC',1,'SPAC',0.,2*lgvol(1)+tapsq(1)+aircon(1),
     &  (10-TAPSQ(1)),3,'ONLY')
        CALL GSPOS('LTGD',1,'SPAC',(lgvol(5)-lgvol(4))/2,0.,
     &   (10-2*TAPSQ(1)-LGVOL(1)),0,'MANY')
       CALL GSPOS('TPSQ',1,'SPAC',0.,tapsq(1)/2,(10-TAPSQ(1)),0,'MANY')
       CALL GSPOS('TPMR',1,'SPAC',0.,-tapsq(1)/2,(10-TAPSQ(1)),2,'MANY')
c       CALL GSPOS('LTGD',2,'SPAC',0.,lgvol(1)+tapsq(1),
c     &  (10-TAPSQ(1)),3,'ONLY')
        CALL GSPOS('LTG2',1,'SPAC',0.,lgvol2(1)+tapsq(1),
     &   (10-TAPSQ(1)),3,'MANY')

      	CALL GGCLOS
      	CALL GPRINT('VOLU',0)
      	END
