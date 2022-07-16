      SUBROUTINE UGLAST
*
* Author: Rafael Hakobyan
*
*************************************************************************
* Include geant system common blocks
*************************************************************************
 
      INCLUDE 'gcommon/gcflag'   
      dimension vmeanT(25), vmeanL(25), vmeanS(25), vmeanG(25)      
      dimension vsdevT(25), vsdevL(25), vsdevS(25), vsdevG(25)      
      dimension vnevnT(25), vnevnL(25), vnevnS(25), vnevnG(25)      
      dimension verrT(25), verrL(25), verrS(25), verrG(25)      

      CALL GLAST

*************************************************************************
* Save histograms to file
*************************************************************************

      CALL HROUT(0,icycle,' ')
      CALL HREND('BCAL')


*************************************************************************
* End of Subroutine
*************************************************************************

      END
