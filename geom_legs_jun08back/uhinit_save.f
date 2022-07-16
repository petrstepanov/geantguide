      SUBROUTINE UHINIT
*
* Author: Rafael Hakobyan
*
      include 'gcommon/gcuser'
      include 'gcommon/gccuts'

      CHARACTER*32 CHTITLE

      CALL HBOOK1(1,'Energy Deposit. in Pb', 100, 0.0, 5.0,  0.0)
      CALL HBOOK1(2,'Energy Deposit. in SciFi', 100, 0.0, 1.0,  0.0)
      CALL HBOOK1(94,'Energy Deposit. in gluebox', 100, 0.0, 0.4,  0.0)
      CALL HBOOK1(95,'Energy Deposit. in gluesci', 100, 0.0, 0.5,  0.0)
      CALL HBOOK1(99,'Energy Deposit. in glue', 100, 0.0, 0.5,  0.0)

      CALL HBOOK1(4,'Total Energy Deposit', 100, 0.0, 5.0,  0.0)
      CALL HBOOK1(10,'Energy deposition exitting main volume'
     *, 100, 0., 5.,  0.0)
      CALL HBOOK1(11,' ', 100, 0., 5., 0.0)
      CALL HBOOK1(12,'Initial energy dist.', 100, 0., 5., 0.0)
* This defines a 2D histogram
      CALL HBOOK2(13,'Initial x-y vertex',100,-12.,12.,100,-12.,12.,0.)
      CALL HBOOK1(14,'Kinetic energy while charged part. traversing Pb'
     *, 100, 0.0, 9.0, 0.0)
      CALL HBOOK1(15,'Kinetic energy while neutral part. traversing Pb'
     *, 100, 0.0, 0.5, 0.0)
      CALL HBOOK1(16,'Kin. energy while charged part. traversing SciFi'
     *, 100, 0.0, 1.0, 0.0)
      CALL HBOOK1(17,'Kin. energy while neutral part. traversing SciFi'
     *, 100, 0.0, 0.5, 0.0)
      CALL HBOOK1(18,'Deposite energy ratio', 100, 0.0, 1.0, 0.0)
      CALL HBOOK1(19,'Total deposite energy ratio', 100, 0.0, 1.0, 0.0)

      CALL HBOOK1(98,'Ratio =E_glue/E_phot', 100, 0.0, 0.5, 0.0)
* 2D histo
      CALL HBOOK2(21,'R_vs_pmom 2D',100,0.,1.,100,0.,1.,0.)
      CALL HBOOK2(22,'E_Pb_vs_pmom 2D',100,0.,1.,100,0.,1.,0.)
      CALL HBOOK2(23,'E_Sci_vs_pmom 2D',100,0.,1.,100,0.,1.,0.)
      CALL HBOOK2(24,'E_kin_vs_pmom 2D',100,0.,1.,100,0.,1.,0.)

      CALL HBOOK2(25,'E_kin_R_vs_pmom 2D',100,0.,1.,100,0.,1.,0.)
      CALL HBOOK2(26,'E_Pb_R_vs_pmom 2D',100,0.,1.,100,0.,1.,0.)
      CALL HBOOK2(27,'E_Sci_R_vs_pmom 2D',100,0.,1.,100,0.,1.,0.)
      CALL HBOOK2(28,'E_left_R_vs_pmom 2D',100,0.,5.,100,0.,1.,0.)

      CALL HBOOK2(29,'E_Pb_vs_pmom 2D',100,0.,1.,100,0.,1.,0.)
      CALL HBOOK2(30,'E_Sci_vs_pmom 2D',100,0.,1.,100,0.,1.,0.)
      CALL HBOOK2(31,'E_left_vs_pmom 2D',100,0.,1.,100,0.,1.,0.)

      CALL HBOOK1(100,'scint emmision angle theta',100,-1.,4.,0.)
      CALL HBOOK1(101,'scint emmision angle phi',100,-1.,7.,0.)
      CALL HBOOK2(102,'2 fibre end +',200,-3.0,3.0,200,5.0,11.0,0.)
      CALL HBOOK2(103,'2 fibre end -',200,-3.0,3.0,200,-3.0,3.0,0.)
      CALL HBOOK1(104,'phot per step', 100, 0.0, 100.0, 0.0)
      CALL HBOOK1(105,'2 + exit pz/p', 100, -1., 1., 0.0)

      CALL HBOOK1(106,'2 + exit px/p', 100, -1., 1., 0.0)
      CALL HBOOK1(107,'2 + exit py/p', 100, -1., 1., 0.0)
      CALL HBOOK1(108,'2 - exit pz/p', 100, -1., 1., 0.0)
      CALL HBOOK1(109,'2 - exit px/p', 100, -1., 1., 0.0)
      CALL HBOOK1(110,'2 - exit py/p', 100, -1., 1., 0.0)

      CALL HBOOK1(111,'boundary encounters', 100, -220., 220., 0.0)
      CALL HBOOK1(112,'boundary enc core', 100, -220., 220., 0.0)
      CALL HBOOK1(113,'boundary enc clad 1', 100, -220., 220., 0.0)
      CALL HBOOK1(114,'boundary enc clad 2', 100, -220., 220., 0.0)
      CALL HBOOK1(122,'exit core pz/p', 100, -1., 1., 0.0)
      CALL HBOOK1(123,'exit clad 1 pz/p', 100,-1., 1., 0.0)
      CALL HBOOK1(124,'exit clad 2 pz/p', 100,-1., 1., 0.0)
      CALL HBOOK1(125,'enter core pz/p', 100,-1., 1., 0.0)
      CALL HBOOK1(126,'enter clad 1 pz/p', 100,-1., 1., 0.0)
      CALL HBOOK1(127,'enter clad 2 pz/p', 100,-1., 1., 0.0)

      CALL HBOOK2(132,'21 fibre end +',200,-0.1,0.1,200,-0.1,0.1,0.)
      CALL HBOOK2(133,'21 fibre end -',200,-0.1,0.1,200,-0.1,0.1,0.)

      CALL HBOOK1(135,'21 + exit pz/p', 100, -1., 1., 0.0)
      CALL HBOOK1(136,'21 + exit px/p', 100, -1., 1., 0.0)
      CALL HBOOK1(137,'21 + exit py/p', 100, -1., 1., 0.0)
      CALL HBOOK1(138,'21 - exit pz/p', 100, -1., 1., 0.0)
      CALL HBOOK1(139,'21 - exit px/p', 100, -1., 1., 0.0)
      CALL HBOOK1(140,'21 - exit py/p', 100, -1., 1., 0.0)

      CALL HBOOK2(142,'22 fibre end +',200,-0.1,0.1,200,-0.1,0.1,0.)
      CALL HBOOK2(143,'22 fibre end -',200,-0.1,0.1,200,-0.1,0.1,0.)

      if (gcuts(1).eq.1) then
      CALL HBOOK2(152,'fibre end +',200,-100.,100.,200,-100.,100.,0.)
      CALL HBOOK2(153,'fibre end -',200,-100.,100.,200,-100.,100.,0.)
      endif

      if (gcuts(1).eq.3) then
      CALL HBOOK2(152,'fibre end +',200,-.1,.1,200,-.1,.1,0.)
      CALL HBOOK2(153,'fibre end -',200,-.1,.1,200,-.1,.1,0.)
      endif

      if (gcuts(1).eq.5) then
      CALL HBOOK2(152,'fibre end +',200,-15.0,15.0,200,-15.0,15.0,0.)
      CALL HBOOK2(153,'fibre end -',200,-15.0,15.0,200,-15.0,15.0,0.)
      endif


      CALL HBOOK1(145,'22 + exit pz/p', 100, -1., 1., 0.0)
      CALL HBOOK1(146,'22 + exit px/p', 100, -1., 1., 0.0)
      CALL HBOOK1(147,'22 + exit py/p', 100, -1., 1., 0.0)
      CALL HBOOK1(148,'22 - exit pz/p', 100, -1., 1., 0.0)
      CALL HBOOK1(149,'22 - exit px/p', 100, -1., 1., 0.0)
      CALL HBOOK1(150,'22 - exit py/p', 100, -1., 1., 0.0)
      CALL HBOOK1(160,'2  tof', 100, 0., 50., 0.0)
      CALL HBOOK1(161,'21 tof', 100, 0., 50., 0.0)
      CALL HBOOK1(162,'22 tof', 100, 0., 50., 0.0)
      CALL HBOOK1(163,'2  tof interupt', 100, 0., 50., 0.0)
      CALL HBOOK1(164,'21 interupt tof', 100, 0., 50., 0.0)
      CALL HBOOK1(165,'22 interupt tof', 100, 0., 50., 0.0)
      CALL HBOOK1(166,'+ 2  ends tof', 100, 0., 50., 0.0)
      CALL HBOOK1(167,'+ 21 ends tof', 100, 0., 50., 0.0)
      CALL HBOOK1(168,'+ 22 ends tof', 100, 0., 50., 0.0)
      CALL HBOOK1(169,'- 2  ends tof', 100, 0., 50., 0.0)
      CALL HBOOK1(170,'- 21 ends tof', 100, 0., 50., 0.0)
      CALL HBOOK1(171,'- 22 ends tof', 100, 0., 50., 0.0)

      CALL HBOOK1(180,'tofcore/tofg', 100, -0.2, 1.2, 0.0)
      CALL HBOOK1(181,'tofclad1/tofg', 100, -0.2, 1.2, 0.0)
      CALL HBOOK1(182,'tofclad2/tofg', 100, -0.2, 1.2, 0.0)
      CALL HBOOK1(183,'tofcore/tofg', 100, -0.2, 1.2, 0.0)
      CALL HBOOK1(184,'tofclad1/tofg', 100, -0.2, 1.2, 0.0)
      CALL HBOOK1(185,'tofclad2/tofg', 100, -0.2, 1.2, 0.0)
      CALL HBOOK2(186,'tofcore/tofg',100,-0.2,1.2,200,0.0,180.0,0.)
      CALL HBOOK2(187,'tofcore/tofg',100,-0.2,1.2,200,0.0,180.0,0.)
      CALL HBOOK2(188,'tofcore/tofg',100,-0.2,1.2,200,0.0,180.0,0.)


      CALL HBOOK1(199,'destep', 100,0., .00005, 0.0)
      CALL HBOOK1(200,'destep', 100,0., .001, 0.0)
      CALL HBOOK1(201,'int vs wavelength', 100, 300.0, 1050.0, 0.0)
      CALL HBOOK1(202,'int scnt energy', 100, 1.1808e-9, 4.1328e-9, 0.0)
      CALL HBOOK1(203,'init scint wvlnth (air)', 100, 300., 1050., 0.0)
      CALL HBOOK1(204,'+ final scnt E', 100, 1.1808e-9, 4.1328e-9, 0.0)
      CALL HBOOK1(205,'- final scnt E', 100, 1.1808e-9, 4.1328e-9, 0.0)
      CALL HBOOK1(206,'+ init scnt wvlnth (air)', 100, 300., 1050., 0.0)
      CALL HBOOK1(207,'- init scnt wvlnth (air)', 100, 300., 1050., 0.0)


c      do i=1,100000
c      CALL HFILL(201,iwlength(i),0.,1.)
c      enddo
 
      CALL HBOOK1(300,'spect', 100,300.,1050. , 0.0)
      CALL HBOOK1(302,'2 exit phi', 180, 0., 180., 0.0)
      CALL HBOOK1(303,'21 exit phi', 180, 0., 180., 0.0)
      CALL HBOOK1(304,'22 exit phi', 180, 0., 180., 0.0)

      CALL HBOOK1(305,'2 exit theta', 180, 0., 180., 0.0)
      CALL HBOOK1(306,'21 exit theta', 180, 0., 180., 0.0)
      CALL HBOOK1(307,'22 exit theta', 180, 0., 180., 0.0)
      CALL HBOOK2(308,'2 theta vs tof',200,0.,50.0,180,0.0,180.0,0.)
      CALL HBOOK2(309,'21 theta vs tof',200,0.,50.0,180,0.0,180.0,0.)
      CALL HBOOK2(310,'22 theta vs tof',200,0.,50.0,180,0.0,180.0,0.)

      CALL HBOOK1(500,'bounces in core', 100,0., 2000., 0.0)
      CALL HBOOK1(501,'bounces in clad1', 100,0., 2000., 0.0)
      CALL HBOOK1(502,'bounces in clad2', 100,0., 2000., 0.0)
      CALL HBOOK2(503,'2 bounce vs tof',200,0.0,50.0,200,0.0,4000.0,0.)
      CALL HBOOK2(504,'21 bounce vs tof',200,0.,50.0,200,0.0,4000.0,0.)
      CALL HBOOK2(505,'22 bounce vs tof',200,0.,50.0,200,0.0,4000.0,0.)
      CALL HBOOK1(506,'bounces in core end', 100,0., 2000., 0.0)
      CALL HBOOK1(507,'bounces in clad1 end', 100,0., 2000., 0.0)
      CALL HBOOK1(508,'bounces in clad2 end', 100,0., 2000., 0.0)
      CALL HBOOK2(509,'2 bnc vs tof end',200,0.0,50.0,200,0.0,4000.0,0.)
      CALL HBOOK2(510,'21 bnc vs tof end',200,0.,50.0,200,0.0,4000.0,0.)
      CALL HBOOK2(511,'22 bnc vs tof end',200,0.,50.0,200,0.0,4000.0,0.)
      CALL HBOOK2(602,'2 fibre end +',200,-3.0,3.0,200,5.0,11.0,0.)

      
      CALL HBOOK1(2002,'Backscatter',100,0.,0.01,0.)
      do i=1,3,2
      CALL HBOOK1(2100+i,'Edep in module',100,0.,1.0,0.)
      CALL HBOOK1(2150+i,'Edep in module(zeros)',100,0.,1.0,0.)

      CALL HBOOK1(2200+i,'Edep in module Pb',100,0.,1.0,0.)
      CALL HBOOK1(2300+i,'Edep in module SciFi',100,0.,0.20,0.)
      CALL HBOOK1(2400+i,'Edep in module Glue',100,0.,0.10,0.)
      enddo

       do i=2,2
      CALL HBOOK1(2100+i,'Edep in module',100,0.,1.0,0.)
      CALL HBOOK1(2150+i,'Edep in module(zeros)',100,0.,1.0,0.)

      CALL HBOOK1(2200+i,'Edep in module Pb',100,0.,1.0,0.)
      CALL HBOOK1(2300+i,'Edep in module SciFi',100,0.,0.2,0.)
      CALL HBOOK1(2400+i,'Edep in module Glue',100,0.,0.1,0.)
      enddo
      

      
      do i=4,48
      CALL HBOOK1(2100+i,'Edep in module',100,0.,0.05,0.)
      CALL HBOOK1(2150+i,'Edep in module(zeros)',100,0.,1.0,0.)
      CALL HBOOK1(2200+i,'Edep in module Pb',100,0.,0.05,0.)
      CALL HBOOK1(2250+i,'Edep in module Pb(zeros)',100,0.,0.05,0.)
      CALL HBOOK1(2300+i,'Edep in module SciFi',100,0.,0.010,0.)
      CALL HBOOK1(2350+i,'Edep in module SciFi(zeros)',100,0.,0.010,0.)
      CALL HBOOK1(2400+i,'Edep in module Glue',100,0.,0.010,0.)
      CALL HBOOK1(2450+i,'Edep in module Glue(zeros)',100,0.,0.010,0.)
      enddo
      
      CALL HIDOPT(0,'STAT')
      do i=1,48
      CALL HBOOK1(3000+i,'Edep in (radial depth)',100,0.,0.5,0.)
      enddo
      k=0
 
      do j=1,48
         do i=1,25
            do l=1,5
      k=k+1
*      if (j.le.3) then
c      CALL HBOOK1(3100+k,'Edep in SCINT (radial depth)',100,0.,50.,0.)
*      else
*      CALL HBOOK1(3100+k,'Edep in SCINT (radial depth)',100,0.,0.1,0.)
*      endif
            enddo
          enddo
      enddo
      k=0

      do j=1,48
      do i=1,25
      do l=1,5
      k=k+1
*      if (j.le.3) then
c      CALL HBOOK1(9100+k,'Photons  (radial depth)',100,0.,200.,0.)
*      else
*      CALL HBOOK1(9100+k,'Photons  (radial depth)',100,0.,40.,0.)
*      endif
   
      enddo
      enddo
      enddo
 



      CALL HIDOPT(0,'STAT')

***********************************************************************
* End of Subroutine
***********************************************************************
      END
