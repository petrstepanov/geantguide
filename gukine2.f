      SUBROUTINE GUKINE
*
* Author: R. Hakobyan, Z. Papandrou
*      
* Generates Kinematics for primary track

*************************************************************************
* Include geant system common blocks
*************************************************************************

      INCLUDE 'gcommon/gcbank' 
      INCLUDE 'gcommon/gcflag' 
      INCLUDE 'gcommon/gckine' 
      INCLUDE 'gcommon/gconsp' 
      INCLUDE 'gcommon/gextra' 
      INCLUDE 'gcommon/ggenr8' 
      INCLUDE 'gcommon/gccuts' 
      INCLUDE 'gcommon/gntcwn'

*************************************************************************
* Define Local Variables
*************************************************************************

      DIMENSION VERTEX(3),PLAB(3),RNDM(2)
      CHARACTER*20 CHNPAR
      real bid,bmass,bcharge,bplab(3),benergy,dummy(10),rad2
      integer brun,bevent
*************************************************************************
* Set initial vertex and momentum values
*************************************************************************

      SAVE VERTEX,PLAB   
      DATA VERTEX/3*0./  
      DATA PLAB  /3*0./	
      real h1vert, lb1vert, lh1vert, x1, dx_pisa
c
c        single clad St. Gobain theta=21.3
c        single clad Kuraray    theta=20.4
c        multi  clad St. Gobain theta=27.4
c        multi  clad Kuraray    theta=26.7
c
      real cosmin, thmax, costh
      data thmax /27.4/
      save h1vert, lb1vert, lh1vert, dx_pisa
c      data h1vert, lb1vert, lh1vert /1.,1.,1./
c      data h1vert, lb1vert, lh1vert /1.,1.2292,1.2625/
c
c      data for outer top outside fine mesh
c
c      data h1vert, lb1vert, lh1vert /2.625,2.700,2.875/
c
c      data for inner top outside fine mesh 
c
c      data dx_pisa /0.8432/
      data dx_pisa /0./
      data h1vert, lb1vert, lh1vert /2.0,1.508,1.685/


      ntrk=int(gcuts(2))
c      print *, ' ikine=',ikine,' 1 pkine=',pkine

C**Blake's kinematics
      
      if (gcuts(1).eq.3.or.gcuts(1).eq.5) then
 105     CALL GRNDM(dummy,10)
         PKINE(1)=2.0e-9
c
         cosmin = cos(3.14159*thmax/180.)
         costh = cosmin + dummy(2)*(1-cosmin)
         PKINE(2) = 180.*acos(costh)/3.14159
c
c        take compliment to point in other direction
c
         pkine(2) = 180 - pkine(2)
         PKINE(3)=dummy(3)*360.

         PKINE(5)=2*h1vert*dummy(4)-h1vert
         x1 = -lh1vert+2*(1-dummy(4))*(lh1vert-lb1vert)
         PKINE(4)=2*lh1vert*dummy(5)-lh1vert
         if (pkine(4) .lt. x1) go to 105
cdebiug         if (pkine(4) .gt. -lh1vert+2*(lh1vert-lb1vert)) go to 105
c
c        add pisa shift
c
c         pkine(4) = pkine(4)+dx_pisa
      endif

      PMOM = PKINE(1)
      THETA = PKINE(2)
      PHI = PKINE(3)

      VERTEX(1) = PKINE(4)
      VERTEX(2) = PKINE(5)
      VERTEX(3) = PKINE(6)
c      print *, ' 2 pkine=',pkine
c      print *, ' vertex=',vertex

      THETA = THETA*DEGRAD
      PHI   = PHI*DEGRAD
      PLAB(1) = PMOM*SIN(THETA)*COS(PHI)
      PLAB(2) = PMOM*SIN(THETA)*SIN(PHI)
      PLAB(3) = PMOM*COS(THETA)

*************************************************************************
* Extract constants describing particle IPART from data structure JPART
*************************************************************************

      CALL GFPART(IKINE,CHNPAR,ITRTYP,AMASS,CHARGE,TLIFE,UB,NWB)


*************************************************************************
* Store parameters of primary vertex for use with GSKINE 
*************************************************************************

      CALL GSVERT(VERTEX,0,0,0,0,NVERT)

*************************************************************************
* Store parameters of a track in JKINE with attached primary vertex NVERT
*************************************************************************

      CALL GSKINE(PLAB,IKINE,NVERT,0,0,NT)

*************************************************************************
* Histogram initial energy
*************************************************************************

      CALL HFILL(12,PMOM,0.,1.)

*************************************************************************
* Histogram initial vertex on x-y plane.
*************************************************************************
      

      CALL HFILL(13,VERTEX(1),VERTEX(2),1.)
C      enddo
*************************************************************************
* Kinematics debug (controlled by ISWIT(1) )
*************************************************************************

      IF (IDEBUG.EQ.1) THEN
          IF (ISWIT(1).EQ.1) THEN
              CALL GPRINT('VERT',0)
              CALL GPRINT('KINE',0)
          END IF
      END IF

      END
