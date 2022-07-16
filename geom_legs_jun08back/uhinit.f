      SUBROUTINE UHINIT
*
* Author: Rafael Hakobyan
*
      include 'gcommon/gcuser'
      include 'gcommon/gccuts'

      CHARACTER*32 CHTITLE
      integer nbins
c
c     define relative to center of input or exit
c
      real x0in, y0in, z0in, x0out, y0out,z0out
      data x0in, y0in, z0in, x0out, y0out,z0out
     +    /  0.,   0., -65.65,    0.,    77.96,   7.125/
c     +    /  0.,   0., -65.65,    0.,    72.88,   7.125/
      real side, dely
      data side, dely /4.,10./
c
c     histograms at entrance
c
      nbins = 20
      call hbook1 (101,'Entrance x',nbins,x0in-side,x0in+side,0.)
      call hbook1 (102,'Entrance y',nbins,y0in-side,y0in+side,0.)
      call hbook1 (103,'Entrance z',nbins,z0in-side,z0in+side,0.)
      call hbook1 (104,'Entrance phi',360,-180.,180.,0.)
      call hbook1 (105,'Entrance theta',90,0.,90.,0.)
c
      call hbook2 (111,'Entrance y vs x',
     +     nbins,x0in-side,x0in+side,nbins,y0in-side,y0in+side,0.)
      call hbook2 (112,'Entrance y vs z',
     +     nbins,z0in-side,z0in+side,nbins,y0in-side,y0in+side,0.)
      call hbook2 (113,'Entrance x vs z',
     +     nbins,z0in-side,z0in+side,nbins,x0in-side,x0in+side,0.)
c
      call hbook1 (121,'Entrance x (success)',nbins,x0in-side,
     +     x0in+side,0.)
      call hbook1 (122,'Entrance y (success)',nbins,y0in-side,
     +     y0in+side,0.)
      call hbook1 (123,'Entrance z (success)',nbins,z0in-side,
     +     z0in+side,0.)
c
      call hbook2 (131,'Entrance y vs x (success)',
     +     nbins,x0in-side,x0in+side,nbins,y0in-side,y0in+side,0.)
      call hbook2 (132,'Entrance y vs z (success)',
     +     nbins,z0in-side,z0in+side,nbins,y0in-side,y0in+side,0.)
      call hbook2 (133,'Entrance x vs z (success)',
     +     nbins,z0in-side,z0in+side,nbins,x0in-side,x0in+side,0.)
c
c     histograms at output
c
      call hbook1 (201,'Exit x',nbins,x0out-side,x0out+side,0.)
      call hbook1 (202,'Exit y',nbins,y0out-dely,y0out+side,0.)
      call hbook1 (203,'Exit z',nbins,z0out-side,z0out+side,0.)
      call hbook1 (304,'Exit phi',360,-180.,180.,0.)
      call hbook1 (305,'Exit theta',90,0.,90.,0.)
c
      call hbook1 (231,'Exit x (success)',nbins,x0out-side,
     +     x0out+side,0.)
      call hbook1 (232,'Exit y (success)',nbins,y0out-dely,
     +     y0out+side,0.)
      call hbook1 (233,'Exit z (success)',nbins,z0out-side,
     +     z0out+side,0.)
      call hbook1 (204,'Exit x (y.le.5)',nbins,x0out-side,x0out+side,0.)
      call hbook1 (205,'Exit y (y.le.5)',nbins,y0in-side,y0in+side,0.)
      call hbook1 (206,'Exit z (y.le.5)',nbins,z0out-side,z0out+side,0.)
      call hbook1 (207,'Exit x (70.le.y.le.75)',nbins,x0out-side,
     +     x0out+side,0.)
      call hbook1 (208,'Exit y (70.le.y.le.75)',nbins,y0out-dely,
     +     y0out+side,0.)
      call hbook1 (209,'Exit z (70.le.y.le.75)',nbins,z0out-side,
     +     z0out+side,0.)
c
      call hbook2 (211,'Exit y vs x',
     +     nbins,x0out-side,x0out+side,nbins,y0out-dely,y0out+side,0.)
      call hbook2 (212,'Exit y vs z',
     +     nbins,z0out-side,z0out+side,nbins,y0out-dely,y0out+side,0.)
      call hbook2 (213,'Exit x vs z',nbins,z0out-side,z0out+side,
     +     nbins,x0out-side,x0out+side,0.)
      call hbook2 (214,'Exit x vs z (success)',nbins,z0out-side,
     +     z0out+side,nbins,x0out-side,x0out+side,0.)
      call hbook2 (215,'Exit x vs z (y.le.5)',nbins,z0out-side,
     +     z0out+side,nbins,x0out-side,x0out+side,0.)
      call hbook2 (216,'Exit x vs z (70.le.y.le.75)',nbins,z0out-side,
     +     z0out+side,nbins,x0out-side,x0out+side,0.)
      call hbook2 (217,'Exit y vs z (y.le.5)',
     +     nbins,z0out-side,z0out+side,nbins,y0in-side,y0in+dely,0.)
      call hbook2 (218,'Exit x vs z (planacon)',nbins,z0out-side,
     +     z0out+side,nbins,x0out-side,x0out+side,0.)

      CALL HIDOPT(0,'STAT')

***********************************************************************
* End of Subroutine
***********************************************************************
      END
