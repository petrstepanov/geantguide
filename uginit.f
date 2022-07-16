      SUBROUTINE UGINIT

*'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*
*     Author:    Rafael hakobyan                                    *
*       Date:    Jan,20, 2005                                       *
*                rafael@regie5.phys.uregina.ca                      *
*     or         rafael@jlab.org                                    *
*  To initialise GEANT/USER  program and read data cards            *
*                                                                   *
*'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*
      parameter (nmax=20) 

      INCLUDE 'gcommon/gckine'
      INCLUDE 'gcommon/gextra'
      INCLUDE 'gcommon/gntcwn'
      include "gcommon/cerenkov"
      INCLUDE 'gcommon/gcking' 
      INCLUDE 'gcommon/gcuser' 
      data med/0.,0.,0./
      first_crossing=.true.

*      COMMON/QUEST/IQUEST(100)
 
*      IQUEST(10)=256000
       numtrg=0
      trgnum=10000000      
      
C** spectra input   
 
        call HROPEN(2,'BCAL','spect.hbook',' ',4096,istat)
        CALL HIDOPT(0,'STAT')

        if (istat.ne.0) then
          stop 'cry foul'
        endif
 
        call HRIN(0,9999,0)
        do i=1,100000
        iwlength(i)=HRNDM1(20)
        enddo
        call HREND('RZfile')
        close(2)




      CALL HROPEN(1,'BCAL','gntbcal.hbook','NE',4096,istat)



      if (istat.ne.0) then
         print*, 'Error in opening ntuple file'
         stop
      endif


      CALL HBNT(999,'BCAL', ' ')

      CALL HBNAME(999,'GLUEX',NTR,'NTR[0,20],'//
     *          'NP(NTR),IDP(NTR),PM(NTR),PCH(NTR),'//
     *          'PPX(NTR),PPY(NTR),PPZ(NTR),PE(NTR),'//
     *          'EDSCI(NTR),EDPB(NTR),EDBC(NTR),EDH2(NTR),'//
     *          'EDST(NTR),EDCDC(NTR),EDAL(NTR)')

      CALL HBNT(1000,'Blake', ' ')
      CALL HBNAME(1000,'Blakes',nmod,'nmod[0,48],'//
     *           'share(nmod),pbshare(nmod),scishare(nmod),'//
     *           'glueshare(nmod)')

      
      CALL HBNT(1001,'new ntuple',' ')
      CALL HBNAME(1001,'fibre',NUMED,'NUMED,'//
     *           'bnc2,bnc21,bnc22,vect1,'//
     *           'vect2,vetc3,vect4,vect5,'//
     *           'vect6,vect7,tofg')


* Initialise GEANT

      CALL GINIT
      
      do i=1,trgnum
        urnd(i)=rndm(-1)
      enddo

      CALL FFSET('LINP',1)
      OPEN(UNIT=1,FILE='input.dat',STATUS='OLD')
      CALL GFFGO
      CLOSE(1)

      CALL GZINIT

* BCal Geometry and materials description

      CALL UGEOM
      call gphysi

      CALL GPRINT('MATE',0)
      CALL GPRINT('TMED',0)
      CALL GPRINT('VOLU',0)

      CALL UHINIT

      END
