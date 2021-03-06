      SUBROUTINE IDTITL
C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C                .      .    .                                       .
C SUBPROGRAM:    IDTITL      PULL TITLE FROM IDRA ARRAY
C   PRGMMR: LIN              ORG: W/NMC412   DATE: 97-02-10
C
C ABSTRACT: SQUEEZE A TITLE OUT OF IDRA BY COPYING THE
C   SIGNIFICANT CONTENTS OF IT WITHOUT DISTURBING IDRA ITSELF.
C   THE COMPRESSED COPY WILL BE PLACED ON THE MAP VIA PUTLAB.
C
C PROGRAM HISTORY LOG:
C   YY-MM-DD  ORIGINAL AUTHOR UNKNOWN
C   88-07-25  HENRICHSEN DOCUMENT.
C   93-05-11  LILLY CONVERT SUB. TO FORTRAN 77
C   97-02-10  LIN   CONVERT SUB. TO CFT-77
C
C USAGE:    CALL IDTITL
C
C   OUTPUT ARGUMENT LIST:
C     COMMON   - /KPLOT / LABEL(2,1024),LABIX,NOBUF,IDRA(50)
C
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 77
C   MACHINE:  NAS
C
C$$$
C
C
      COMMON /KPLOT / LABEL(2,1024),LABIX,NOBUF,IDRA(50)
      COMMON /ADJUST/  IXADJ, IYADJ
C
C
      CHARACTER*1  LNDRA(140)
      CHARACTER*8  CNDRA(18)
      CHARACTER*1  LIDRA(140)
      CHARACTER*1  OO           

      INTEGER*8    IWORK(14)
      INTEGER      IPRIOR(2)
C
      DATA         OO   /Z'00'/

      EQUIVALENCE(IWORK(1),LIDRA(1))
      EQUIVALENCE(CNDRA,LNDRA)
C
      IDOTS = 400 + IXADJ
      JDOTS = 80 + IYADJ
      HEIGHT = 1.0
      ANGLE = 0.0
      IPRIOR(1) = 0
      IPRIOR(2) = 2
      ITAG = 0
C
C     Remove extra spaces from the title
C
      DO K = 1,14
         IWORK(K) = IDRA(K+2)
      END DO
      call byteswap(IWORK(1), 8, 14)
      NCHAR = 0
      ISP = 0
      DO K = 1,112 
        IF(LIDRA(K) .NE. OO) THEN
          IF(LIDRA(K) .EQ. ' ') THEN
            ISP = ISP + 1
            IF(ISP .EQ. 1) THEN
              NCHAR = NCHAR + 1
              LNDRA(NCHAR) = ' '     
            END IF
          ELSE
            NCHAR = NCHAR + 1
            LNDRA(NCHAR) = LIDRA(K)
            ISP = 0
          END IF
        END IF
      END DO
C
C
      CALL PUTLAB(IDOTS,JDOTS,HEIGHT,CNDRA,ANGLE,NCHAR,IPRIOR,ITAG)
      PRINT *,' IDTITL TITLE: ',LNDRA
C
      RETURN
      END
