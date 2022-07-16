
      SUBROUTINE GGSCNT
C.
C.    ******************************************************************
C.    *                                                                *
C.    *   This routine is called for each tracking step of a           *
C.    *   particle in a scintillator. A fixed number of                *
C.    *   photons is generated in random direction with a given momentum
C.    *   distribuion. The parameters are                              *
C.    *   then transformed into the Master Reference System, and they  *
C.    *   are added to the particle stack.                             *
C.    *                                                                *
C.    *   ==>Called by : GUSTEP                                        *
C.    *      Authors     B.Leverington, R.Jones, F.Carminati           *
C.    *                                                                *
C.    ******************************************************************
C.
      include "gcommon/gcbank"
      include "gcommon/gcjloc"
      include "gcommon/gctmed"
      include "gcommon/gcunit"
      include "gcommon/gctrak"
      include "gcommon/gckine"
      include "gcommon/gcking"
      include "gcommon/gconsp"
      include "gcommon/cerenkov"
      INCLUDE 'gcommon/gntcwn'
      INCLUDE 'gcommon/gcuser' 


*
      INTEGER itr2
      REAL RPHOT(3),ngp,wvlnth
      LOGICAL ROTATE
      PARAMETER (RFACT=369.81E9)
      
*
*   ------------------------------------------------------------------
*
      NPCKOV=nbins
*      print *,'ngphot=',ngphot
      ngp=ngphot
      CALL HFILL(104,ngp,0.,1.)
      IF(NGPHOT.eq.0) THEN
         GO TO 999
      ELSEIF(NGPHOT.GT.(MXPHOT)) THEN
         WRITE(CHMAIL,10000) NGPHOT-MXPHOT
10000   FORMAT(' **** GGSCNT Overflow in the photon stack, ',I10,
     +         ' photons are lost')
         CALL GMAIL(0,0)
         NGPHOT = MXPHOT
       ENDIF
*
* ***  Set up rotation to Particle frame
*
*      CALL GFANG(VECT(4),COSTH,SINTH,COSPH,SINPH,ROTATE)
*

* ***  Distribute the photons in origin, direction, momentum
         wvlnth=HRNDM1(201)  !wavelength in air to get momentum
         CALL HFILL(203,wvlnth,0.,1.)
         PPHOT=1239.842/wvlnth*1e-9 !photon momentum
 
      COSMX = THRIND/Q(JINDEX+NPCKOV)
      SINMX2 = (1.-COSMX)*(1.+COSMX)

      DO 40 J=1,NGPHOT
         CALL GRNDM(RPHOT, 1)
         IF(IGNEXT.NE.0) THEN
            DS=(STEP-PREC)*RPHOT(1)+PREC
         ELSE
            DS = STEP*RPHOT(1)
         ENDIF
         XPHOT(1,J) = VECT(1)-VECT(4)*DS
         XPHOT(2,J) = VECT(2)-VECT(5)*DS
         XPHOT(3,J) = VECT(3)-VECT(6)*DS
         XPHOT(11,J)= TOFG+(STEP-DS)*GETOT/(VECT(7)*CLIGHT)
*
* *** Sample the momentum of the photon
   20    CALL GRNDM(RPHOT, 3)

*
* *** Find in which bin we are
         KMIN = JMIN
         KMAX = NPCKOV


   30    KMED = (KMIN+KMAX)/2

         IF(Q(JTCKOV+1+KMED).LT.PPHOT) THEN
            KMIN = KMED
         ELSE
            KMAX = KMED
         ENDIF

         IF(KMAX-KMIN.GT.1) GOTO 30
         RATIO = (PPHOT-Q(JTCKOV+1+KMIN))/
     +           (Q(JTCKOV+KMIN+2)-Q(JTCKOV+1+KMIN))
         RATI1  = (1.-RATIO)
         

* *** Find the density function value corresponding to the
* *** momentum sampled
         RINDEX = Q(JINDEX+KMIN)*RATI1+Q(JINDEX+KMIN+1)*RATIO
*         print *,JINDEX,RINDEX,RATIO,RATI1
*         print *,Q(JINDEX)        
         COST   = COS(RPHOT(2)*pi)
         SINT2  = (1.-COST)*(1.+COST)
         SINT = SQRT(SINT2)

         PHI  = TWOPI*RPHOT(3)

         emitt = RPHOT(2)*pi
         emitp = phi
         call HFILL(100,emitt,0.,1.)
         call HFILL(101,emitp,0.,1.)

         SINP = SIN(PHI)
         COSP = COS(PHI)

         XPHOT(4,J) = SINT*COSP
         XPHOT(5,J) = SINT*SINP
         XPHOT(6,J) = COST
         XPHOT(7,J) = PPHOT
         CALL HFILL(202,xphot(7,J),0.,1.)
         XPHOT(8,J) = COST*COSP
         XPHOT(9,J) = COST*SINP
         XPHOT(10,J) = -SINT

   40 CONTINUE
  999 END
