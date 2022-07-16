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
      include "gcommon/gcking"


*************************************************************************
* Define Local Variables
*************************************************************************

      DIMENSION VERTEX(3),PLAB(3),RNDM(2)
      CHARACTER*20 CHNPAR
      real bid,bmass,bcharge,bplab(3),benergy,dummy,u(2047),v(2047)
      integer brun,bevent
*************************************************************************
* Set initial vertex and momentum values
*************************************************************************

      SAVE VERTEX,PLAB   
      DATA VERTEX/3*0./  
      DATA PLAB  /3*0./	 

*************************************************************************
* Read the output from genr8
*************************************************************************
*      ifile=1
*        OPEN(unit=11,file='p_eta_pi0.out',status='unknown')


*************************************************************************
* Vertex position is in the 30cm length H2 target
*************************************************************************
 101  numtrg=numtrg+1
      VERTEX(1)=2*urnd(numtrg)
      if(VERTEX(1).gt.2..or.VERTEX(1).lt.-2.) goto 101
      if(mod(numtrg,2).gt.0) VERTEX(1)=-VERTEX(1)
 102  numtrg=numtrg+1
      VERTEX(2)=2*urnd(numtrg)
      if(VERTEX(2).gt.2..or.VERTEX(2).lt.-2.) goto 102
      if(mod(numtrg,2).gt.0) VERTEX(2)=-VERTEX(2)
 103  numtrg=numtrg+1
      VERTEX(3) =-(110.+30.*urnd(numtrg)) 
      if(VERTEX(3).lt.-195..or.VERTEX(3).gt.-165.) goto 103

*************************************************************************
* Calculate momentum in the Lab. frame
*************************************************************************
*      numtrg=numtrg+1
      ntrk=int(gcuts(2))
*        read (11,*,end=1000) numrun,numev
*      do itk=1,ntrk
*        read (11,*,end=1000) numtr,ikine,prtmas
*        read (11,*,end=1000) chpart,px,py,pz,engprt

*      NP(ITK)=NUMTR
*      IDP(ITK)=IKINE
*      PM(ITK)=PRTMAS
*      PCH(ITK)=CHPART
*      PPX(ITK)=PX
*      PPY(ITK)=PY
*      PPZ(ITK)=PZ
*      PE(ITK)=ENGPRT 

*      PMOM = sqrt(px**2+py**2+pz**2)
*      THETA = acos(pz/pmom)
*      PHI = acos(px/sqrt(px**2+py**2))

*      PLAB(1) = PX
*      PLAB(2) = PY
*      PLAB(3) = PZ

C**Blake's kinematics
      PMOM = PKINE(1)
      THETA = PKINE(2)
      PHI = PKINE(3)

*      VERTEX(1) = PKINE(4)
*      VERTEX(2) = PKINE(5)
*      VERTEX(3) = PKINE(6)

      THETA = THETA*DEGRAD
      PHI   = PHI*DEGRAD
      PLAB(1) = PMOM*SIN(THETA)*COS(PHI)
      PLAB(2) = PMOM*SIN(THETA)*SIN(PHI)
      PLAB(3) = PMOM*COS(THETA)


*      goto 101
      if (idevt.eq.1) then       
      open(unit=5,file="intf.dat",status="old")
      read(5,*)intf
      read(5,*)chld
      endif


      open(unit=10,file=intf,status="old")
*      print *,'idevt=',idevt
*      print *,'mod((idevt),ntrk)',mod((idevt),ntrk)
*      print *,'ntrk=',ntrk
      read(10,*)brun,bevent
*      print *,brun,bevent

      do itk=1,ntrk      
      read(10,*)bindex,ikine,bmass
*      print *,bindex,ikine,bmass
      read(10,*)bcharge,plab(1),plab(2),plab(3),pkine(1)
*      print *,bcharge,plab(1),plab(2),plab(3),pkine(1)
*      print *,ikine,pkine(1),plab
*      print *
            
      NP(ITK)=bindex
      IDP(ITK)=IKINE
      PM(ITK)=bmass
      PCH(ITK)=bcharge
      PPX(ITK)=plab(1)
      PPY(ITK)=plab(2)
      PPZ(ITK)=plab(3)
      PE(ITK)=pkine(1) 

* 101  CONTINUE
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
      enddo
*************************************************************************
* Kinematics debug (controlled by ISWIT(1) )
*************************************************************************

      IF (IDEBUG.EQ.1) THEN
          IF (ISWIT(1).EQ.1) THEN
              CALL GPRINT('VERT',0)
              CALL GPRINT('KINE',0)
          END IF
      END IF

*      if (ifile.eq.1) go to 1001
* 1000 write (6,*) 'The end'
* 1001 continue

      END
