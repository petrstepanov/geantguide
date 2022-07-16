      SUBROUTINE GUSTEP
*
* Author: Rafael Hakobyan
*

*************************************************************************
* Include geant system common blocks
*************************************************************************

      INCLUDE 'gcommon/gcflag' 
      INCLUDE 'gcommon/gckine' 
      INCLUDE 'gcommon/gcking' 
      INCLUDE 'gcommon/gctmed' 
      INCLUDE 'gcommon/gctrak' 
      INCLUDE 'gcommon/gcuser' 
      INCLUDE 'gcommon/gcvolu'
      INCLUDE 'gcommon/gccuts'
      INCLUDE 'gcommon/gcphys'
      INCLUDE 'gcommon/gntcwn'
      INCLUDE 'gcommon/ggenr8'
      INCLUDE 'gcommon/gconsp'



      real x0,y0,phipos,edep,ue,wvlnth,ph1,ph2,ph
      integer k
      ntrk=itra

      

*************************************************************************
* Deposited energies in the detectors for the given particle
*************************************************************************


      xpos(itra)=vect(1)
      ypos(itra)=vect(2)
      zpos(itra)=vect(3)
      
       MED(1)=MED(2)
       MED(2)=NUMED  
      
    
C** genereate scintillation photons
         IMSCNT=gcuts(5)

          


*lightguide       
      if (numed.eq.30.and.ipart.eq.50) then
         if (vect(3).ge.(10.0)) then         
          CALL HFILL(102,vect(1),vect(2),1.)
          CALL HFILL(105,vect(6),0.,1.)
          istop=2

      if (numed.eq.30) then      
      xps(1)=vect(1)
      yps(1)=vect(2)
      zps(1)=vect(3)
*      call HFNT(998)
      endif

        
          if (acos(vect(6)).gt.1.570796) then
          th=180. - asin((sin(acos(vect(6))))*1.0/1.6)/degrad
          else
          th=asin((sin(acos(vect(6))))*1.0/1.6)/degrad
          endif      
          CALL HFILL(305,th,0.,1.)
       
         if (vect(5).ge.0) then
         ph=acos(vect(4)/sin(th*degrad))/degrad
         elseif (vect(5).le.0) then
         ph=360.-acos(vect(4)/sin(th*degrad))/degrad 
         endif
         if (th.le.90.0) CALL HFILL(302,ph,0.,1.)
         endif
         

         if (vect(3).le.(10-2*lgvol1)) then
          CALL HFILL(103,vect(1),vect(2),1.)
       
          istop=2
          if (acos(vect(6)).gt.1.570796) then
          th=180. - asin((sin(acos(vect(6))))*1.0/1.6)/degrad
          else
          th=asin((sin(acos(vect(6))))*1.0/1.6)/degrad
          endif
          !print *,th
          CALL HFILL(305,th,0.,1.)
       
         if (vect(5).ge.0) then
         ph=acos(vect(4)/sin(th*degrad))/degrad
         elseif (vect(5).le.0) then
         ph=360.-acos(vect(4)/sin(th*degrad))/degrad 
         endif
          CALL HFILL(302,ph,0.,1.)
         endif


      endif      


          
      IF (NGKINE.GT.0) THEN
          CALL GSKING(0)
      ENDIF

      IF (IDEBUG.NE.0) THEN
	 CALL GDCXYZ
         CALL GSXYZ	
         CALL GDEBUG
      ENDIF

      END
