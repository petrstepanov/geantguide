      SUBROUTINE GUOUT

*
* Author: Rafael Hakobyan
*

************************************************************************
* Include geant system common blocks
************************************************************************

      INCLUDE 'gcommon/gcflag' 
      INCLUDE 'gcommon/gcuser'
      INCLUDE 'gcommon/gckine' 
      INCLUDE 'gcommon/gctrak'  
      INCLUDE 'gcommon/ggenr8' 
      INCLUDE 'gcommon/gextra'
      INCLUDE 'gcommon/gntcwn'
      INCLUDE 'gcommon/gccuts'
      INCLUDE 'gcommon/gctime'  

      Integer t
      t=0
* Put end of event histogram increments here (e.g. calorimetry)

      if (mod(idevt,1).eq.0) then
C         print *,idevt,' events have been simulated'

         timlast=timnow
         CALL TIMEX(TIMNOW)
         tmean=(TIMNOW - TIMLAST)/1.
         tsum=(tsum+tmean)
         left=(nevent-idevt)*tsum/idevt*1.60
C         print "(F10.2,A)",left,' minutes left',TIMNOW


         if(idevt.eq.nevent) print *,'Finished successfully'
      endif 

      
      ntr=ntrk
 
 

      

      

      call HFNT(999)
      nmod=48
*      call HFNT(1000)
      do i=1,48
         share(i)=0.
         pbshare(i)=0.
         scishare(i)=0.
         glueshare(i)=0.
      enddo

      CALL HFILL(1,EDPB(1),0.,1.)
      CALL HFILL(2,EDSCI(1),0.,1.)

     
      ETOTAL=0.
      CALL HFILL(24,PMOM,ESCORE(10),1.)
      CALL HFILL(25,PMOM,(ESCORE(10)/PMOM),1.)
      DO 100 i=1,10

* Energy Deposit in the Lead and SciFis.

         CALL HFILL(I,ESCORE(I),0.,1.)
	 ETOTAL=ETOTAL+ESCORE(I)
           if(i.eq.1) then
              CALL HFILL(22,PMOM,ESCORE(1),1.)
              CALL HFILL(26,PMOM,(ESCORE(1)/PMOM),1.)
           endif
          if (i.eq.2) then
            CALL HFILL(18,ESCORE(2)/ESCORE(1),0.,1.)
            CALL HFILL(19,(ESCORE(2)/(ESCORE(1)+ESCORE(2))),0.,1.)
            CALL HFILL(27,PMOM,(ESCORE(2)/PMOM),1.)
            CALL HFILL(28,PMOM,((PMOM-ESCORE(1)-ESCORE(2))/PMOM),1.)
*            CALL HFILL(20,(ESCORE(2)/PMOM),0.,1.)
            CALL HFILL(21,PMOM,(ESCORE(2)/PMOM),1.)
            CALL HFILL(23,PMOM,ESCORE(2),1.)
            CALL HFILL(29,PMOM,ESCORE(1),1.)
            CALL HFILL(30,PMOM,ESCORE(2),1.)
            CALL HFILL(31,PMOM,(PMOM-ESCORE(1)-ESCORE(2)),1.)
            ESCORE(I)=0.
            ESCORE(I-1)=0.
          endif
           if(i.eq.4) CALL HFILL(94,ESCORE(i),0.,1.)
           if(i.eq.5) CALL HFILL(95,ESCORE(i),0.,1.)
           if(i.eq.9) CALL HFILL(99,ESCORE(i),0.,1.)
           if(i.eq.9) CALL HFILL(98,ESCORE(i)/PMOM,0.,1.)
          if (i.gt.2) ESCORE(I)=0.
100   CONTINUE
       do i=1,25
         CALL HFILL(1100+i,EDSTEP(i),0.,1.)
         CALL HFILL(1200+i,PBSTEP(i),0.,1.)
         CALL HFILL(1300+i,SCSTEP(i),0.,1.)
         CALL HFILL(1400+i,BCSTEP(i),0.,1.)
         EDSTEP(i)=0.
         PBSTEP(i)=0.
         SCSTEP(i)=0.
         BCSTEP(i)=0.
       enddo

      CALL HFILL(11,ETOTAL,0.,1.)

      do k=1,20
      IDP(k)=0
      enddo
      CALL VZERO (PM,20)
      CALL VZERO (PCH,20)
      CALL VZERO (PPX,20)
      CALL VZERO (PPY,20)
      CALL VZERO (PPZ,20)
      CALL VZERO (PE,20)
      CALL VZERO (EDPB,20)
      CALL VZERO (EDSCI,20)
      CALL VZERO (EDBC,20)
      CALL VZERO (EDH2,20)
      CALL VZERO (EDST,20)
      CALL VZERO (EDCDC,20)
      CALL VZERO (EDAL,20)
      CALL VZERO (xpos,20)
      CALL VZERO (ypos,20)
      CALL VZERO (zpos,20)
      CALL VZERO (bnc2,1)
      CALL VZERO (bnc21,1)
      CALL VZERO (bnc22,1)
      CALL VZERO (vect1,1)
      CALL VZERO (vect2,1)
      CALL VZERO (vect3,1)
      CALL VZERO (vect4,1)
      CALL VZERO (vect5,1)
      CALL VZERO (vect6,1)
      CALL VZERO (vect7,1)
      CALL VZERO (tofg,1)
      CALL VZERO (tagE,5)


     
            k=0.
        do j=1,48
        do i=1,25
        do l=1,5
*         if (rscore(i).gt.0) then
*         CALL HFILL(3000+i,RSCORE(i),0.,1.)
*         endif
         k=k+1        

        !histogram 3351 an up are Edep for tracks
        do t=1,ntr


         if (scirscore(t,j,i,l).gt.0) then !fill hist only if edep>0
*fill track cells
      CALL HFILL(3100+k+250+125*(t-1),(SCIRSCORE(t,j,i,l)*1000),0.,1.)
C      CALL HFILL(9100+k+250+125*(t-1),photscore(t,j,i,l),0.,1.)
*            print *,SCIRSCORE(j,i,l)*1000

*fill regardless of track
         CALL HFILL(3100+k,(SCIRSCORE(t,j,i,l)*1000),0.,1.)
         if (photscore1(t,j,i,l).gt.0) then
         CALL HFILL(9100+k,photscore1(t,j,i,l),0.,1.)
         endif
         if (photscore2(t,j,i,l).gt.0) then
         CALL HFILL(9100+k+125,photscore2(t,j,i,l),0.,1.)
         endif

         endif 

         scirscore(t,j,i,l)=0.
         rscore(j,i,l)=0.
         photscore1(t,j,i,l)=0.
         photscore2(t,j,i,l)=0.

        enddo
        enddo
        enddo
*setting k=0 here will fill the histograms for the first module with the info for all the rest of the modules which should be ok, since the reactions are isotropic
       k=0
        enddo

*      first_crossing=.true.


C** generated cerenkov tracking

      CALL GTRIGC

      END

*********Histogram Detail***************
* 3101 - 3225 is cell with hits only
* 3226 - 3350 is cell with zeros as well
* 3351 - 3475 is cell for track 1
* 3376 - 3600 is cell for track 2, etc...
 
