      SUBROUTINE GUSTEP
*
* Author: Rafael Hakobyan
*
* Modified for histograming light guide profiles 
*     6/12/08 for WC geometries  ES
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
      INCLUDE 'gcommon/cerenkov'

      integer k, kevent
      integer numed_old
      real xentrance, yentrance, zentrance
      real vx, vy, vz, vnorm, vperp, vtheta, vphi
      real vtheta_exit, vphi_exit
      real delta
      real running_acceptance
      save  numed_old,xentrance, yentrance, zentrance
      save kevent, running_acceptance, vtheta, vphi
c
c     define relative to center of input or exit
c
      real x0in, y0in, z0in, x0out, y0out,z0out
      save x0in, y0in, z0in, x0out, y0out,z0out
      data x0in, y0in, z0in, x0out, y0out,z0out
     +    /  0.,   0., 10.,    0.,    0.,       -42./
c     +    /  0.,   0., 10.,    0.,    0.,       0./
c     +    /  0.,   0., -65.65,    0.,    77.96,   7.125/
c     +    /  0.,   0., -65.65,    0.,    72.88,   7.125/

      data numed_old /0./
      data kevent /0/
      data kacc /0/

      ntrk=itra
c
      kevent = kevent + 1
c      print *, ' kevent=',kevent,' inwvol=',inwvol,' numed=',
c     +       numed,' numed_old=',numed_old,' istop=',istop
c
c     check medium
c
      if (inwvol.ne.0 .and. numed_old.eq.0) then
c          print *, ' kevent=',kevent,' Entrance face'
c
c         histogram entrance plots
c
          xentrance = vect(1)
          yentrance = vect(2)
          zentrance = vect(3)
          vx = vect(4)
          vy = vect(5)
          vz = vect(6)
          vnorm = sqrt(vx**2 + vy**2 + vz**2)
          vperp = sqrt(vx**2 + vy**2)
c   
c         convert to positive z
c
          vphi = 180*atan2(vy,-vx)/pi
          vtheta = 180 - 180*acos(vz/vnorm)/pi
          vx = vx/vnorm
          vy = vy/vnorm
          vz = vz/vnorm
c          print *, ' vx=',vx,' vy=',vy,' vz=',vz,' phi=',
c     +          vphi,' theta=',vtheta
c
          call hf1 (101, xentrance, 1.)
          call hf1 (102, yentrance, 1.)
          call hf1 (103, zentrance, 1.)
          call hf1 (104, vphi,1.)
          call hf1 (105, vtheta,1.)
          call hf2 (111, xentrance, yentrance, 1.)
          call hf2 (112, zentrance, yentrance, 1.)
          call hf2 (113, zentrance, xentrance, 1.)
      endif
c
      if (inwvol.ne.0) then
c
c         entering new volume
c
c          print *, ' kevent=',kevent,' ntrk=',ntrk,' numed_old=',
c     +    numed_old,' numed=',numed,' ipart=',ipart,' inwvol=',
c     +    inwvol,' vect=',vect
c
c         remember medium
c
          numed_old = numed
      endif
c
c     check for exit out of light guide into air
c
      if (inwvol.ne.0 .and. numed.eq.7) then
           kacc = kacc + 1
           running_acceptance = float(kacc)/float(kevent)
c           print *, ' kevent=',kevent,' acc=',running_acceptance, 
c     +           'Output face'
c
          xexit = vect(1)
          yexit = vect(2)
          zexit = vect(3)
          vx = vect(4)
          vy = vect(5)
          vz = vect(6)
          vnorm = sqrt(vx**2 + vy**2 + vz**2)
          vperp = sqrt(vx**2 + vy**2)
c   
c         convert to positive z
c
          vphi_exit = 180*atan2(vy,-vx)/pi
          vtheta_exit = 180 - 180*acos(vz/vnorm)/pi
c
c         correct for refraction at light guide boundary
c
          vtheta_exit = 180*asin(sin(vtheta_exit*pi/180.)/Rnguide)/pi
c
c         entrance histograms if successful
c         check success by cuts on output plane.
c
          delta = 0.2
          if (abs(zexit-z0out) < delta) then
c
c            success
c
             call hf1 (121, xentrance, 1.)
             call hf1 (122, yentrance, 1.)
             call hf1 (123, zentrance, 1.)
             call hf1 (304, vphi_exit,1.)
             call hf1 (305, vtheta_exit,1.)
c
             call hf1 (231, xexit, 1.)
             call hf1 (232, yexit, 1.)
             call hf1 (233, zexit, 1.)
             call hf2 (131, xentrance, yentrance, 1.)
             call hf2 (132, zentrance, yentrance, 1.)
             call hf2 (133, zentrance, xentrance, 1.)
             call hf2 (214, xexit, yexit, 1.)
             call hf2 (215, vtheta, vtheta_exit,1.)
c            print *, ' xentrance=',xentrance,' yentrance=',
c     +              yentrance,' zentrance=',zentrance
c              print *, ' xexit=',xexit,' yexit=',yexit,' zexit=',zexit
          else
c              print *, ' track failed'
          endif
c
c          histograms at exit
c
c
          call hf1 (201, xexit, 1.)
          call hf1 (202, yexit, 1.)
          call hf1 (203, zexit, 1.)
          call hf2 (211, xexit, yexit, 1.)
          call hf2 (212, zexit, yexit, 1.)
          call hf2 (213, zexit, xexit, 1.)
c
c         terminate particle
c
          istop = 2
      endif
* 
      if (istop.ne.0) numed_old = 0

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
