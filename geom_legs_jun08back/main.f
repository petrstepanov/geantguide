      PROGRAM MAIN
*
* Author: R. Hakobyan, Z. Papandreou
*

      integer mzebra,mhbook
      parameter (mzebra=50000000) !15000000
      parameter (mhbook=10000000)

      common/gcbank/q(mzebra)
      common/pawc/h(mhbook)

      CALL TIMEST(1000000.)

      call GZEBRA(mzebra)
      call HLIMIT(-mhbook)

* Start events processing.

      CALL UGINIT

      CALL GRUN

      CALL UGLAST

      STOP
      END
