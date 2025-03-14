#include "DARWIN_OPTIONS.h"

CBOP
C     !ROUTINE: DARWIN_DIAGNOSTICS_INIT

C     !INTERFACE:
      SUBROUTINE DARWIN_DIAGNOSTICS_INIT( myThid )

C     !DESCRIPTION:
C     Routine to initialize Darwin diagnostics

C     !USES:
      IMPLICIT NONE
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#include "PTRACERS_SIZE.h"
#include "PTRACERS_PARAMS.h"
#ifdef ALLOW_RADTRANS
#include "RADTRANS_SIZE.h"
#endif
#include "DARWIN_SIZE.h"
#include "DARWIN_INDICES.h"

C     !INPUT PARAMETERS:
C     myThid :: Number of this instance of DARWIN_DIAGNOSTICS_INIT
      INTEGER myThid
CEOP

#ifdef ALLOW_DARWIN
#ifdef ALLOW_DIAGNOSTICS

C     !FUNCTIONS:
      INTEGER     ILNBLNK
      EXTERNAL    ILNBLNK
      CHARACTER*16 DIAGS_MK_UNITS
      EXTERNAL     DIAGS_MK_UNITS

C     !LOCAL VARIABLES:
C     msgBuf :: Informational/error meesage buffer
c     CHARACTER*(MAX_LEN_MBUF) msgBuf
      INTEGER j
      INTEGER        diagNum
      CHARACTER*8    diagName
      CHARACTER*16   diagCode
      CHARACTER*16   diagUnits
      CHARACTER*(80) diagTitle
      INTEGER      ilnb
      CHARACTER*7  trcUnits
      CHARACTER*30 locName
      CHARACTER*4  diagSufx

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|

      WRITE(diagName,'(A)')'plankC'
      WRITE(diagTitle,'(A)')'Total plankton carbon biomass'
      diagUnits = 'mmol C/m^3      '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'Chl'
      WRITE(diagTitle,'(A)')'Total Chlorophyll a'
      diagUnits = 'mg Chl a/m^3    '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'PP'
      WRITE(diagTitle,'(A)')'Primary Production'
      diagUnits = 'mmol C/m^3/s    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'Nfix'
      WRITE(diagTitle,'(A)')'N fixation'
      diagUnits = 'mmol N/m^3/s    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'Denit'
      WRITE(diagTitle,'(A)')'Denitrification'
      diagUnits = 'mmol N/m^3/s    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'DenitN'
      WRITE(diagTitle,'(A)')'Nitrogen loss due to denitrification'
      diagUnits = 'mmol N/m^3/s    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

#ifdef DARWIN_ALLOW_CSTORE
      WRITE(diagName,'(A)')'EXU'
      WRITE(diagTitle,'(A)')'Carbon exudation'
      diagUnits = 'mmol C/m^3/s    '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'BioSyn'
      WRITE(diagTitle,'(A)')'Biosynthesis rate'
      diagUnits = 'mmol C/m^3/s    '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'DmdN'
      WRITE(diagTitle,'(A)')'Carbon demand from N limit'
      diagUnits = 'mmol C/m^3/s    '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'DmdP'
      WRITE(diagTitle,'(A)')'Carbon demand from P limit'
      diagUnits = 'mmol C/m^3/s    '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'DmdFe'
      WRITE(diagTitle,'(A)')'Carbon demand from Fe limit'
      diagUnits = 'mmol C/m^3/s    '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'DmdSi'
      WRITE(diagTitle,'(A)')'Carbon demand from Si limit'
      diagUnits = 'mmol C/m^3/s    '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'Dmdmin'
      WRITE(diagTitle,'(A)')'Minimum carbon demand'
      diagUnits = 'mmol C/m^3/s    '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )
#endif

#ifdef ALLOW_RADTRANS
      DO j = 1, nlam
        WRITE(diagName,'(A,I3.3)')'PAR',j
        WRITE(diagTitle,'(A,I3)')'PAR waveband ',j
        diagUnits = 'uEin/m^2/s      '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I3.3)')'PARF',j
        WRITE(diagTitle,'(A,I3)')'PAR at W point, waveband ',j
        diagUnits = 'uEin/m^2/s      '
        diagCode  = 'SM P    LR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

#ifdef DARWIN_DIAG_IOP
        WRITE(diagName,'(A,I3.3)')'a',j
        WRITE(diagTitle,'(A,I3)')
     &        'total absorption for waveband ',j
        diagUnits = '1/m             '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I3.3)')'bt',j
        WRITE(diagTitle,'(A,I3)')
     &        'total scattering for waveband ',j
        diagUnits = '1/m             '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I3.3)')'bb',j
        WRITE(diagTitle,'(A,I3)')
     &        'total backscattering for waveband ',j
        diagUnits = '1/m             '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I3.3)')'aplk',j
        WRITE(diagTitle,'(A,I3)')
     &        'absorption by plankton for waveband ',j
        diagUnits = '1/m             '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I3.3)')'btplk',j
        WRITE(diagTitle,'(A,I3)')
     &        'scattering by plankton for waveband ',j
        diagUnits = '1/m             '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I3.3)')'bbplk',j
        WRITE(diagTitle,'(A,I3)')
     &        'backscattering by plankton for waveband ',j
        diagUnits = '1/m             '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I3.3)')'aprt',j
        WRITE(diagTitle,'(A,I3)')
     &        'absorption by particles for waveband ',j
        diagUnits = '1/m             '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I3.3)')'btprt',j
        WRITE(diagTitle,'(A,I3)')
     &        'scattering by particles for waveband ',j
        diagUnits = '1/m             '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I3.3)')'bbprt',j
        WRITE(diagTitle,'(A,I3)')
     &        'backscattering by particles for waveband ',j
        diagUnits = '1/m             '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I3.3)')'aCDOM',j
        WRITE(diagTitle,'(A,I3)')
     &        'absorption by CDOM for waveband ',j
        diagUnits = '1/m             '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )
#endif

      ENDDO
#endif /* ALLOW_RADTRANS */

      WRITE(diagName,'(A)')'atten'
      WRITE(diagTitle,'(A)')'attenuation in layer'
      diagUnits = '1               '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'PARF'
      WRITE(diagTitle,'(A)')'PAR at top of layer'
      diagUnits = 'uEin/m^2/s      '
      diagCode  = 'SM P    LR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'PAR'
      WRITE(diagTitle,'(A,I3)')'total PAR at layer center'
      diagUnits = 'uEin/m^2/s      '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

c nutrient consumption
      WRITE(diagName,'(A)')'C_DIN'
      WRITE(diagTitle,'(A)')'consumption of DIN'
      diagUnits = 'mmol N/m3/s     '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'C_NO3'
      WRITE(diagTitle,'(A)')'consumption of NO3'
      diagUnits = 'mmol N/m3/s     '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'C_NO2'
      WRITE(diagTitle,'(A)')'consumption of NO2'
      diagUnits = 'mmol N/m3/s     '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'C_NH4'
      WRITE(diagTitle,'(A)')'consumption of NH4'
      diagUnits = 'mmol N/m3/s     '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'C_PO4'
      WRITE(diagTitle,'(A)')'consumption of PO4'
      diagUnits = 'mmol P/m3/s     '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'C_Si'
      WRITE(diagTitle,'(A)')'consumption of Si'
      diagUnits = 'mmol Si/m3/s    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'C_Fe'
      WRITE(diagTitle,'(A)')'consumption of Fe'
      diagUnits = 'mmol Fe/m3/s    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

c additional source terms of nutrients
      WRITE(diagName,'(A)')'S_DIN'
      WRITE(diagTitle,'(A)')'non-transport source of DIN'
      diagUnits = 'mmol N/m3/s     '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'S_NO3'
      WRITE(diagTitle,'(A)')'non-transport source of NO3'
      diagUnits = 'mmol N/m3/s     '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'S_NO2'
      WRITE(diagTitle,'(A)')'non-transport source of NO2'
      diagUnits = 'mmol N/m3/s     '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'S_NH4'
      WRITE(diagTitle,'(A)')'non-transport source of NH4'
      diagUnits = 'mmol N/m3/s     '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'S_PO4'
      WRITE(diagTitle,'(A)')'non-transport source of PO4'
      diagUnits = 'mmol P/m3/s     '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'S_Si'
      WRITE(diagTitle,'(A)')'non-transport source of Si'
      diagUnits = 'mmol Si/m3/s    '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'S_Fe'
      WRITE(diagTitle,'(A)')'non-transport source of Fe'
      diagUnits = 'mmol Fe/m3/s    '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      DO j = 1, nDarwin
        WRITE(diagName, '(2A)') 'gDAR', PTRACERS_ioLabel(j)
C--     Set default name & tracer Units:
        WRITE(locName,'(A,I4.4,A)') 'Tracer ', j
        trcUnits  = 'kg/kg  '
C-      use units & names from data.ptracers :
        ilnb = ILNBLNK(PTRACERS_units(j))
        IF ( ilnb.GE.1 ) THEN
         ilnb = LEN(trcUnits)
         trcUnits = PTRACERS_units(j)(1:ilnb)
        ENDIF
        ilnb = ILNBLNK(PTRACERS_names(j))
        IF ( ilnb.GE.1 ) THEN
         ilnb = MIN(LEN(locName),ilnb)
         WRITE(locName,'(A)') PTRACERS_names(j)(1:ilnb)
        ENDIF
        ilnb = MAX(ILNBLNK(locName),1)
        WRITE(diagTitle,'(2A)') locName(1:ilnb), ' tendency from DARWIN'
        diagUnits = DIAGS_MK_UNITS( trcUnits//'/s', myThid )
        diagCode  = 'SMR     MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName, '(2A)') 'gECO', PTRACERS_ioLabel(j)
        ilnb = MAX(ILNBLNK(locName),1)
        WRITE(diagTitle,'(2A)') locName(1:ilnb),
     &        ' tendency from DARWIN w/o sink/swim'
        diagUnits = DIAGS_MK_UNITS( trcUnits//'/s', myThid )
        diagCode  = 'SMR     MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )
      ENDDO

#ifdef DARWIN_DIAG_PERTYPE
      DO j = 1, nplank
        WRITE(diagName,'(A,I4.4)')'PP',j
        WRITE(diagTitle,'(A,I4)')'Primary Production plankton ',j
        diagUnits = 'mmol C/m^3/s    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'PC',j
        WRITE(diagTitle,'(A,I4)')
     &        'Carbon-specific phototrophic growth rate plankton ',j
        diagUnits = '1/s             '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'HP',j
        WRITE(diagTitle,'(A,I4)')'Heterotrophic production plankton ',j
        diagUnits = 'mmol C/m^3/s    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'HC',j
        WRITE(diagTitle,'(A,I4)')
     &        'Carbon-specific heterotrophic growth rate plankton ' ,j
        diagUnits = '1/s             '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'GR',j
        WRITE(diagTitle,'(A,I4)')'Grazing loss of plankton ',j
        diagUnits = 'mmol C/m^3/s    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'GrGn',j
        WRITE(diagTitle,'(A,I4)')'Grazing gain of plankton ',j
        diagUnits = 'mmol C/m^3/s    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'GrGC',j
        WRITE(diagTitle,'(A,I4)')
     &        'Carbon-specific grazing rate plankton ',j
        diagUnits = '1/s             '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'Mort',j
        WRITE(diagTitle,'(A,I4)')'Mortality loss plankton ',j
        diagUnits = 'mmol C/m^3/s    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I            diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'Resp',j
        WRITE(diagTitle,'(A,I4)')'Respiration loss plankton ',j
        diagUnits = 'mmol C/m^3/s    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I            diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'limN',j
        WRITE(diagTitle,'(A,I4)')'N growth limitation plankton ',j
        diagUnits = '[0/1]    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I            diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'limP',j
        WRITE(diagTitle,'(A,I4)')'P growth limitation plankton ',j
        diagUnits = '[0/1]    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I            diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'limF',j
        WRITE(diagTitle,'(A,I4)')'Fe growth limitation plankton ',j
        diagUnits = '[0/1]    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I            diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'limS',j
        WRITE(diagTitle,'(A,I4)')'Si growth limitation plankton ',j
        diagUnits = '[0/1]    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I            diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'fnut',j
        WRITE(diagTitle,'(A,I4)')'Nutrient growth factor plankton ',j
        diagUnits = '[0/1]    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I            diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'fIph',j
        WRITE(diagTitle,'(A,I4)')'Light growth factor plankton ',j
        diagUnits = '[0/1]    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I            diagName, diagCode, diagUnits, diagTitle, 0, myThid )

        WRITE(diagName,'(A,I4.4)')'fTph',j
        WRITE(diagTitle,'(A,I4)')'Temperature growth factor plankton ',j
        diagUnits = '[0/1]    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I            diagName, diagCode, diagUnits, diagTitle, 0, myThid )
      ENDDO
#endif

#ifdef DARWIN_ALLOW_CSTORE
#ifdef DARWIN_ALLOW_CSTORE_DIAGS
      DO j = 1, nPhoto
        WRITE(diagName,'(A,I4.4)')'EXU',j
        WRITE(diagTitle,'(A,I4)')'Exudation plankton ',j
        diagUnits = 'mmol C/m^3/s    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )
      ENDDO

      DO j = 1, nPhoto
        WRITE(diagName,'(A,I4.4)')'BS',j
        WRITE(diagTitle,'(A,I4)')'Biosynthesis rate plankton ',j
        diagUnits = 'mmol C/m^3/s    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )
      ENDDO

      DO j = 1, nPhoto
        WRITE(diagName,'(A,I4.4)')'DN',j
        WRITE(diagTitle,'(A,I4)')
     &        'Carbon demand from N limit plankton ',j
        diagUnits = 'mmol C/m^3/s    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )
      ENDDO

      DO j = 1, nPhoto
        WRITE(diagName,'(A,I4.4)')'DP',j
        WRITE(diagTitle,'(A,I4)')
     &        'Carbon demand from P limit plankton ',j
        diagUnits = 'mmol C/m^3/s    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )
      ENDDO

      DO j = 1, nPhoto
        WRITE(diagName,'(A,I4.4)')'DFe',j
        WRITE(diagTitle,'(A,I4)')
     &        'Carbon demand from Fe limit plankton ',j
        diagUnits = 'mmol C/m^3/s    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )
      ENDDO

      DO j = 1, nPhoto
        WRITE(diagName,'(A,I4.4)')'DSi',j
        WRITE(diagTitle,'(A,I4)')
     &        'Carbon demand from Si limit plankton ',j
        diagUnits = 'mmol C/m^3/s    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )
      ENDDO

      DO j = 1, nPhoto
        WRITE(diagName,'(A,I4.4)')'Dmin',j
        WRITE(diagTitle,'(A,I4)')'Minimum carbon demand plankton ',j
        diagUnits = 'mmol C/m^3/s    '
        diagCode  = 'SMRP    MR      '
        CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I             diagName, diagCode, diagUnits, diagTitle, 0, myThid )
      ENDDO
#endif
#endif

      WRITE(diagName,'(A)')'sfcSolFe'
      WRITE(diagTitle,'(A)')'Soluble iron input at sea surface'
      diagUnits = 'mmol Fe/m2/s    '
      diagCode  = 'SM P    L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'scvLosFe'
      WRITE(diagTitle,'(A)')'Iron loss from scavenging'
      diagUnits = 'mmol Fe/m3/s    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'scavRate'
      WRITE(diagTitle,'(A)')'Iron scavenging rate'
      diagUnits = '1/s             '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'sedFe'
      WRITE(diagTitle,'(A)')'Iron input from sediment'
      diagUnits = 'mmol Fe/m3/s    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'freeFeLs'
      WRITE(diagTitle,'(A)')'Iron loss due to free iron limit'
      diagUnits = 'mmol Fe/m3/s    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'sedFlxFe'
      WRITE(diagTitle,'(A)')'Iron sediment flux'
      diagUnits = 'mmol Fe/m2/s    '
      diagCode  = 'SM P    U1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

#ifdef DARWIN_ALLOW_CARBON
      WRITE(diagName,'(A)')'apCO2'
      WRITE(diagTitle,'(A)')'atmospheric pCO2'
      diagUnits = 'atm             '
      diagCode  = 'SM P    L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'apCO2sat'
      WRITE(diagTitle,'(A)')'atmospheric pCO2 sat'
      diagUnits = 'atm             '
      diagCode  = 'SM P    L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'pH'
      WRITE(diagTitle,'(A)')'pH'
      diagUnits = '1               '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'pCO2'
      WRITE(diagTitle,'(A)')'Partial Pressure of CO2 in the ocean'
      diagUnits = 'atm             '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'CO3'
      WRITE(diagTitle,'(A)')'Concentration of carbonate'
      diagUnits = 'mol/kg          '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'KspTPClc'
      WRITE(diagTitle,'(A)')'Solubility product for calcite'
      diagUnits = 'mol^2/kg^2      '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'OmegaC'
      WRITE(diagTitle,'(A)')'Calcite saturation ratio'
      diagUnits = '1               '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'fugfCO2'
      WRITE(diagTitle,'(A)')'Fugacity factor of CO2 at surface'
      diagUnits = '1               '
      diagCode  = 'SM P    L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'fCO2'
      WRITE(diagTitle,'(A)')'Fugacity of CO2 (atm)'
      diagUnits = 'atm             '
      diagCode  = 'SM P    L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'fluxCO2'
      WRITE(diagTitle,'(A)')'Flux of CO2 - air-sea exch'
      diagUnits = 'mmol C/m2/s     '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'fluxO2'
      WRITE(diagTitle,'(A)')'Flux of O2 - air-sea exch'
      diagUnits = 'mmol O2/m2/s    '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'VfluxCO2'
      WRITE(diagTitle,'(A)')'Virtual flux of CO2'
      diagUnits = 'mmol C/m2/s     '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'VfluxAlk'
      WRITE(diagTitle,'(A)')'Virtual flux of alkalinity'
      diagUnits = 'meq/m2/s        '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'gDICsurf'
      WRITE(diagTitle,'(A)')
     &            'Tendency of DIC due to air-sea exch + oldvirt.flux'
      diagUnits = 'mmol C/m3/s     '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'gALKsurf'
      WRITE(diagTitle,'(A)')'Tendency of ALK due to oldvirt.flux'
      diagUnits = 'meq/m3/s        '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'gO2surf'
      WRITE(diagTitle,'(A)')'Tendency of O2 due to air-sea exch'
      diagUnits = 'mmol O2/m3/s    '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'C_DIC'
      WRITE(diagTitle,'(A)')'Consumption of DIC'
      diagUnits = 'mmol C/m3/s     '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'C_DICPIC'
      WRITE(diagTitle,'(A)')'Consumption of DIC due to PIC'
      diagUnits = 'mmol C/m3/s     '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'respDIC'
      WRITE(diagTitle,'(A)')'DIC due to respiration'
      diagUnits = 'mmol C/m3/s     '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'rDIC_DOC'
      WRITE(diagTitle,'(A)')'DIC due to remineralization of DOC'
      diagUnits = 'mmol C/m3/s     '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'rDIC_POC'
      WRITE(diagTitle,'(A)')'DIC due to remineralization of POC'
      diagUnits = 'mmol C/m3/s     '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'dDIC_PIC'
      WRITE(diagTitle,'(A)')'DIC due to dissolution of PIC'
      diagUnits = 'mmol C/m3/s     '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'C_ALK'
      WRITE(diagTitle,'(A)')'Consumption of alkalinity'
      diagUnits = 'meq/m3/s        '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'S_ALK'
      WRITE(diagTitle,'(A)')'Non-transport source of alkalinity'
      diagUnits = 'meq/m3/s        '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'C_O2'
      WRITE(diagTitle,'(A)')'Consumption of oxygen'
      diagUnits = 'mmol O2/m3/s    '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'S_O2'
      WRITE(diagTitle,'(A)')'Non-transport source of oxygen'
      diagUnits = 'mmol O2/m3/s    '
      diagCode  = 'SMR     MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

# ifdef DARWIN_ALLOW_RADI
      WRITE(diagName,'(A)')'DICFsed '
      WRITE(diagTitle,'(A)')'DIC sediment flux'
      diagUnits = 'mmol C/m2/s     '
      diagCode  = 'SM      U1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'ALKFsed '
      WRITE(diagTitle,'(A)')'ALK sediment flux'
      diagUnits = 'meq/m2/s        '
      diagCode  = 'SM      U1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'O2Fsed  '
      WRITE(diagTitle,'(A)')'O2 sediment flux'
      diagUnits = 'mmol O2/m2/s    '
      diagCode  = 'SM      U1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'POCFbur '
      WRITE(diagTitle,'(A)')'POC buried flux'
      diagUnits = 'mmol C/m2/s     '
      diagCode  = 'SM      U1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I     diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'CALFbur '
      WRITE(diagTitle,'(A)')'Calcite buried flux'
      diagUnits = 'mmol C/m2/s     '
      diagCode  = 'SM      U1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'sedFlPOC'
      WRITE(diagTitle,'(A)')'POC flux from water column to sediment'
      diagUnits = 'mmol C/m2/s     '
      diagCode  = 'SM P    U1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I     diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'sedFlPIC'
      WRITE(diagTitle,'(A)')'PIC flux from water column to sediment'
      diagUnits = 'mmol C/m2/s     '
      diagCode  = 'SM P    U1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'TcorrO2 '
      WRITE(diagTitle,'(A)')
     &      'Temperature correction factor for diffusive O2 flux'
      diagUnits = '1               '
      diagCode  = 'SM P    M1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I     diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'TcorrALK'
      WRITE(diagTitle,'(A)')
     &      'Temperature correction factor for diffusive ALK flux'
      diagUnits = '1               '
      diagCode  = 'SM P    M1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I     diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'TcorrDIC'
      WRITE(diagTitle,'(A)')
     &      'Temperature correction factor for diffusive DIC flux'
      diagUnits = '1               '
      diagCode  = 'SM P    M1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'OmegCbot'
      WRITE(diagTitle,'(A)')'Calcite saturation ratio above the seabed'
      diagUnits = '1               '
      diagCode  = 'SM P    M1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )
# endif /* DARWIN_ALLOW_RADI */
#endif /* DARWIN_ALLOW_CARBON */

#ifdef DARWIN_DIAG_TENDENCIES
      WRITE(diagName,'(A)')'gDICEpr'
      WRITE(diagTitle,'(A)')
     &            'Tendency of DIC due to E/P/runoff'
      diagUnits = 'mmol C/m3/s     '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'gNO3Epr'
      WRITE(diagTitle,'(A)')
     &            'Tendency of DIC due to E/P/runoff'
      diagUnits = 'mmol N/m3/s     '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'gNO2Epr'
      WRITE(diagTitle,'(A)')
     &            'Tendency of DIC due to E/P/runoff'
      diagUnits = 'mmol N/m3/s     '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'gNH4Epr'
      WRITE(diagTitle,'(A)')
     &            'Tendency of DIC due to E/P/runoff'
      diagUnits = 'mmol N/m3/s     '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'gPO4Epr'
      WRITE(diagTitle,'(A)')
     &            'Tendency of PO4 due to E/P/runoff'
      diagUnits = 'mmol P/m3/s     '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'gFeTEpr'
      WRITE(diagTitle,'(A)')
     &            'Tendency of FeT due to E/P/runoff'
      diagUnits = 'mmol Fe/m3/s    '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'gSiO2Epr'
      WRITE(diagTitle,'(A)')
     &            'Tendency of SiO2 due to E/P/runoff'
      diagUnits = 'mmol Si/m3/s    '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

# ifdef DARWIN_ALLOW_CARBON
      WRITE(diagName,'(A)')'gALKEpr'
      WRITE(diagTitle,'(A)')
     &            'Tendency of ALK due to E/P/runoff'
      diagUnits = 'meq/m3/s        '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'gO2Epr'
      WRITE(diagTitle,'(A)')
     &            'Tendency of O2 due to E/P/runoff'
      diagUnits = 'mmol O2/m3/s    '
      diagCode  = 'SM      L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )
# endif
#endif /* DARWIN_DIAG_TENDENCIES */

#ifdef ALLOW_EXF
      WRITE(diagName,'(A)')'surfPAR'
      WRITE(diagTitle,'(A)')'PAR forcing at surface'
      diagUnits = 'uEin/m^2/s      '
      diagCode  = 'SM P    L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'surfiron'
      WRITE(diagTitle,'(A)')'iron forcing at surface'
      diagUnits = 'mmol Fe/m^2/s   '
      diagCode  = 'SM P    L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'DARice'
      WRITE(diagTitle,'(A)')'ice area fraction'
      diagUnits = 'm^2/m^2         '
      diagCode  = 'SM P    L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'DARwind'
      WRITE(diagTitle,'(A)')'wind speed used for carbon exchange'
      diagUnits = 'm/s             '
      diagCode  = 'SM P    L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      WRITE(diagName,'(A)')'surfpCO2'
      WRITE(diagTitle,'(A)')'atmospheric surface pCO2'
      diagUnits = 'mol/mol         '
      diagCode  = 'SM P    L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I           diagName, diagCode, diagUnits, diagTitle, 0, myThid )
#endif

#endif /* ALLOW_DIAGNOSTICS */
#endif /* ALLOW_DARWIN */

      RETURN
      END

