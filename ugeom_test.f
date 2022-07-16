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
       
        integer irot

        REAL THETB(3),PHB(3)
        DATA THETB/90.0,180.0,90.0/   !initial rotation angles for irot matrix
        DATA PHB/0.0,90.0,90.0/
c
        tpsq1=0.
        tpsq1=tapsq(1)
        LGVOL(1)=5-TAPSQ(1)
        lgvol1=0.
        lgvol1=lgvol(1) 

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

*       CALL GSPOS('AIRC',1,'SPAC',0.,0.,(10-AIRCON(1)),0,'ONLY')
        CALL GSPOS('LTGD',1,'SPAC',0.,0.,(10-2*TAPSQ(1)-LGVOL(1)),0
     &,'ONLY')
       CALL GSPOS('TPSQ',1,'SPAC',0.,1.,(10-TAPSQ(1)),0,'ONLY')
       CALL GSPOS('TPMR',1,'SPAC',0.,-1.,(10-TAPSQ(1)),2,'ONLY')
       CALL GSPOS('LTGD',2,'SPAC',0.,5.,(10-TAPSQ(1)),3
     &,'ONLY')

      	CALL GGCLOS
      	CALL GPRINT('VOLU',0)
      	END
