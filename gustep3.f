      SUBROUTINE GUSTEP
*
* Author: Rafael Hakobyan
*
* Modified for histograming light guide profiles 
*     10/20/07  ES
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



      real x0,y0,phipos,edep,ue,wvlnth,ph
      integer k
      ntrk=itra

*
*lightguide
*       
      if (numed.eq.30.and.ipart.eq.50) then
*         if (vect(3).ge.10.0) then         
            if (vect(2).ge.2.0.and.vect(3).gt.6) then         
               CALL HFILL(102,vect(1),vect(3),1.)
               CALL HFILL(105,vect(6),0.,1.)
               CALL HFILL(106,vect(4),0.,1.)
               CALL HFILL(107,vect(5),0.,1.)
               CALL HFILL(166,tofg*1e9,0.,1.)
               istop=2
        
               if (acos(vect(6)).gt.1.570796) then
                 th=180. - asin((sin(acos(vect(6))))*1.0/1.6)/degrad
               else
                 th=asin((sin(acos(vect(6))))*1.0/1.6)/degrad    
               endif      
               CALL HFILL(305,th,0.,1.)
               CALL HFILL(308,tofg*1e9,th,1.)
               ph=acos(vect(4)/sin(th*degrad))/degrad
               CALL HFILL(302,ph,0.,1.)
            endif

            if (vect(3).le.0.) then
               CALL HFILL(103,vect(1),vect(2),1.)
               CALL HFILL(108,vect(6),0.,1.)
               CALL HFILL(109,vect(4),0.,1.)
               CALL HFILL(110,vect(5),0.,1.)
               CALL HFILL(169,tofg*1e9,0.,1.)

               istop=2
               if (acos(vect(6)).gt.1.570796) then
                  th=180. - asin((sin(acos(vect(6))))*1.0/1.6)/degrad
               else
                  th=asin((sin(acos(vect(6))))*1.0/1.6)/degrad
               endif
               !print *,th
               CALL HFILL(305,th,0.,1.)
               CALL HFILL(308,tofg*1e9,th,1.)
               ph=acos(vect(4)/sin(th*degrad))/degrad
               CALL HFILL(302,ph,0.,1.)
            endif
       

            if (inwvol.eq.2.and.med(1).eq.med(2)) then
               if (numed.eq.30) bnc2=bnc2+1
            endif
       
            if (ipart.eq.50) then
               if (istop.eq.2) then 

                  if (vect(3).ge.195) then
                     CALL HFILL(204,vect(7),0.,1.)
                     wnlnth=1239.842/vect(7)*1e-9
                     CALL HFILL(206,wvlnth,0.,1.)
                  endif
                  if (vect(3).le.-195) then
                     CALL HFILL(205,vect(7),0.,1.)
                     wnlnth=1239.842/vect(7)*1e-9
                     CALL HFILL(207,wvlnth,0.,1.)
                  endif

                  if (bnc2.gt.0.) then 
                     CALL HFILL(500,bnc2,0.,1.) !reflections
                     CALL HFILL(503,tofg*1e9,bnc2,1.) !reflections vs tof
                     if (vect(3).ge.195.or.vect(3).le.-195) then
                        CALL HFILL(506,bnc2,0.,1.) !reflections
                        CALL HFILL(509,tofg*1e9,bnc2,1.) !reflections vs tof
                     endif
                  endif
                  bnc2=0.
               endif
            endif

      endif      

*       print *,first_crossing

      if (first_crossing) then
*        print *,first_crossing
      if (ipart.eq.50) then
*         print *,'ig=',ig
       if (med(1).eq.2.and.med(2).eq.21) CALL HFILL(122,vect(6),0.,1.)
       if (med(1).eq.21.and.med(2).eq.22) CALL HFILL(123,vect(6),0.,1.)
       if (med(1).eq.22.and.med(2).eq.7) CALL HFILL(124,vect(6),0.,1.)
       if (med(1).eq.21.and.med(2).eq.2) CALL HFILL(125,vect(6),0.,1.)
       if (med(1).eq.22.and.med(2).eq.21) CALL HFILL(126,vect(6),0.,1.)
       if (med(1).eq.7.and.med(2).eq.22) CALL HFILL(127,vect(6),0.,1.)
       first_crossing=.false.
      endif
      endif

C** generated cerenkov tracking


          
      IF (NGKINE.GT.0) THEN
          CALL GSKING(0)
      ENDIF

      IF (IDEBUG.NE.0) THEN
	 CALL GDCXYZ
         CALL GSXYZ	
         CALL GDEBUG
      ENDIF

      END
