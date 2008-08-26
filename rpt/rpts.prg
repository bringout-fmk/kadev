#include "kadev.ch"


function GodOdmori()

gnLMarg:=0; gTabela:=1; gOstr:="D"

O_RJ
O_K_0
O_K_1
SET ORDER TO TAG "3"

cGodina:=STR(YEAR(DATE()),4)
cStatus:=PADR("A;",20)
cPrikInt:="N"
qqIdRj:=""

O_PARAMS
Private cSection:="4",cHistory:=" ",aHistory:={}
RPar("p1",@cGodina)
RPar("p2",@cStatus)
RPar("p3",@cPrikInt)
RPar("p4",@qqIdRj)

qqIdRj:=PADR(qqIdRj,80)

Box(,6,77)
DO WHILE .t.
 @ m_x+2,m_y+2 SAY "Pregled godisnjih odmora za godinu:" get cGodina PICT "9999"
 @ m_x+3,m_y+2 SAY "Obuhvaceni radnici sa statusom    :" get cStatus PICT "@!"
 @ m_x+4,m_y+2 SAY "Prikazati intervale koristenja g.o.? (D/N):" get cPrikInt VALID cPrikInt$"DN" PICT "@!"
 @ m_x+5,m_y+2 SAY "Uslov za RJ (prazno-sve)" get qqIdRj  PICT "@!S20"
 read; ESC_BCR
 aUsl1:=Parsiraj(cStatus,"STATUS")
 aUslf:=Parsiraj(qqIdRj,"IdRj","C")
 if aUsl1<>NIL .and. aUslF<>NIL; exit; endif
ENDDO
BoxC()

qqIdRj:=TRIM(qqIdRj)

WPar("p1",cGodina)
WPar("p2",cStatus)
WPar("p3",cPrikInt)
WPar("p4",qqIdRj)
select params; use


// indeksi i filteri
// -----------------
SELECT K_0
SET ORDER TO TAG "4"
SET FILTER TO &aUsl1 .and. &aUslF


// priprema matrice aKol za f-ju StampaTabele()
// --------------------------------------------
aKol:={}                                       
nKol:=0
AADD(aKol, { "RADNIK"    , {|| cImeRadnika  }, .f., "C", 50, 0, 1, ++nKol } )
AADD(aKol, { "BR.DANA NA", {|| nImaDana     }, .t., "N", 10, 0, 1, ++nKol } )
AADD(aKol, { "KOJE IMA"  , {|| "#"          }, .f., "C", 10, 0, 2,   nKol } )
AADD(aKol, { "PRAVO"     , {|| "#"          }, .f., "C", 10, 0, 3,   nKol } )
AADD(aKol, { "ISKORISTIO", {|| nIskorDana   }, .t., "N", 10, 0, 1, ++nKol } )
AADD(aKol, { "DANA"      , {|| "#"          }, .f., "C", 10, 0, 2,   nKol } )
AADD(aKol, { "PREOSTALO" , {|| nImaDana-;
                               nIskorDana   }, .t., "N", 10, 0, 1, ++nKol } )
AADD(aKol, { "DANA"      , {|| "#"          }, .f., "C", 10, 0, 2,   nKol } )

IF cPrikInt=="D"
  AADD(aKol, { "1.DIO"     , {|| cDio1        }, .f., "C", 29, 0, 1, ++nKol } )
  AADD(aKol, { "2.DIO"     , {|| cDio2        }, .f., "C", 29, 0, 1, ++nKol } )
ENDIF


// �tampanje izvje�taja
// --------------------
SELECT K_0; GO TOP

START PRINT CRET

PRIVATE cImeRadnika:="", nImaDana:=0, nIskorDana:=0, cDio1:="", cDio2:=""

IF gPrinter=="L"
  gPO_Land()
ENDIF

?? space(gnLMarg); ?? "KADEV: Izvjestaj na dan",date()
? space(gnLMarg); IspisFirme("")
? "Obuhvacene radne jedinice: "
IF EMPTY(qqIdRj)
  ?? "SVE"
ELSE
  aUslf2:=Parsiraj(qqIdRj,"Id","C")
  SELECT RJ; SET FILTER TO &aUslf2
  GO TOP
  DO WHILE !EOF()
    ? "       - "+NAZ+" ("+ID+")"
    SKIP 1
  ENDDO
  SELECT K_0
ENDIF
?

StampaTabele(aKol,{|| FSvaki1()},,gTabela,,;
     IF(gPrinter=="L","L4",),"Pregled koristenja prava na godisnji odmor za "+cGodina+". godinu",;
                             {|| FFor1()},IF(gOstr=="D",,-1),,,,,)

IF gPrinter=="L"
  gPO_Port()
ENDIF

FF

END PRINT

CLOSERET


FUNCTION FFor1()
  nImaDana:=0; nIskorDana:=0
  cDio1:=cDio2:=""
  cImeRadnika:=TRIM(prezime)+" ("+TRIM(imerod)+") "+TRIM(ime)
  SELECT (F_K_1)
  SEEK K_0->id + "G1"
  DO WHILE !EOF() .and. idpromj=="G1"
    IF STR(nAtr1,4)==cGodina
      IF nAtr2>0; nImaDana:=nAtr2; ENDIF
      nIskorDana += ImaRDana(DatumOd,DatumDo)
      IF EMPTY(cDio1)
        cDio1:="OD "+DTOC(DatumOd)+". DO "+DTOC(DatumDo)+"."
      ELSEIF EMPTY(cDio2)
        cDio2:="OD "+DTOC(DatumOd)+". DO "+DTOC(DatumDo)+"."
      ELSE
        MsgBeep("Greska? "+cImeRadnika+" ima i 3.dio god.odmora!")
      ENDIF
    ENDIF
    SKIP 1
  ENDDO
  SELECT (F_K_0)
RETURN .t.


PROCEDURE FSvaki1()
RETURN


**********************
**********************
PROCEDURE IspisFirme(cidrj)
local nOArr:=select()

?? "Firma: "
B_ON; ?? gNFirma; B_OFF
if !empty(cidrj)
  select rj; hseek cidrj; select(nOArr)
  ?? "  RJ",rj->naz
endif
return




PROCEDURE StazUFirmi()
  gnLMarg:=0; gTabela:=1; gOstr:="D"

  cStatus:=PADR("A;",20)

  O_PARAMS
  Private cSection:="4",cHistory:=" ",aHistory:={}
  RPar("p2",@cStatus)

  Box(,6,77)
  DO WHILE .t.
   @ m_x+2,m_y+2 SAY "Obuhvaceni radnici sa statusom    :" get cStatus PICT "@!"
   read; ESC_BCR
   aUsl1:=Parsiraj(cStatus,"STATUS")
   if aUsl1<>NIL ; exit; endif
  ENDDO
  BoxC()

  WPar("p2",cStatus)
  select params; use

  CrePom()
  O_K_0
  if !flock(); Msg("Neko vec radi sa podacima..."); closeret; endif
  RekRstAll(.t.)
  O_K_0
  cPom := PRIVPATH+"POM"
  SELECT (F_POM); USEX (cPom); SET ORDER TO TAG "1" ; GO TOP


  // indeksi i filteri
  // -----------------
  SELECT (F_POM)
  SET FILTER TO &aUsl1


  // priprema matrice aKol za f-ju StampaTabele()
  // --------------------------------------------
  aKol:={}
  nKol:=0
  AADD(aKol, { "R.BR."     , {|| STR(nRBr,4)+"."}, .f., "C",  5, 0, 1, ++nKol } )
  AADD(aKol, { "RADNIK"    , {|| cImeRadnika    }, .f., "C", 50, 0, 1, ++nKol } )
  AADD(aKol, { "JMB"       , {|| ID             }, .f., "C", 13, 0, 1, ++nKol } )
  AADD(aKol, { "R.STAZ EF.", {|| RSTuSTR(aRStE) }, .f., "C", 14, 0, 1, ++nKol } )
  AADD(aKol, { "R.STAZ B." , {|| RSTuSTR(aRStB) }, .f., "C", 14, 0, 1, ++nKol } )
  AADD(aKol, { "R.STAZ UK.", {|| RSTuSTR(aRStU) }, .f., "C", 14, 0, 1, ++nKol } )
  AADD(aKol, { "STATUS"    , {|| PADC(status,6) }, .f., "C",  6, 0, 1, ++nKol } )


  // �tampanje izvje�taja
  // --------------------
  SELECT (F_POM); GO TOP

  START PRINT CRET

  PRIVATE cImeRadnika:="", nRBr:=0
  aRStE := aRStB := aRStU := {0,0,0}

  IF gPrinter=="L"
    gPO_Land()
  ENDIF

  ?? space(gnLMarg); ?? "KADEV: Izvjestaj na dan",date()
  ? space(gnLMarg); IspisFirme("")
  ?

  StampaTabele(aKol,{|| FSvaki2()},,gTabela,,;
       IF(gPrinter=="L","L4",),"Pregled radnog staza u firmi",;
                               {|| FFor2()},IF(gOstr=="D",,-1),,,,,)

  IF gPrinter=="L"
    gPO_Port()
  ENDIF

  // FF

  END PRINT

CLOSERET



FUNCTION FFor2()
  LOCAL nArr:=SELECT()
  SELECT K_0
  SEEK (F_POM)->ID
  cImeRadnika:=TRIM(prezime)+" ("+TRIM(imerod)+") "+TRIM(ime)
  SELECT (nArr)
  aRstE:=GMJD(RadStE); aRstB:=GMJD(RadStB); aRStU:=ADDGMJD(aRStE,aRStB)
  ++nRBr
RETURN .t.


PROCEDURE FSvaki2()
RETURN




********************
function CrePom()
*
********************
select (F_POM); USE
// kreiranje pomocne baze POM.DBF
// ------------------------------
cPom:=PRIVPATH+"POM"

IF ferase(PRIVPATH+"POM.DBF")==-1
  MsgBeep("Ne mogu izbrisati POM.DBF!")
  ShowFError()
ENDIF
IF ferase(PRIVPATH+"POM.CDX")==-1
  MsgBeep("Ne mogu izbrisati POM.CDX!")
  ShowFError()
ENDIF

aDbf := {}
AADD(aDBf,{ 'ID'     , 'C' ,  13 ,  0 })
AADD(aDBf,{ 'RADSTE' , 'N' ,  11 ,  2 })
AADD(aDBf,{ 'RADSTB' , 'N' ,  11 ,  2 })
AADD(aDBf,{ 'STATUS' , 'C' ,   1 ,  0 })

DBCREATE2 (cPom, aDbf)
USEX (cPom)
INDEX ON ID TAG "1"
SET ORDER TO TAG "1" ; GO TOP
return .t.


FUNC RSTuSTR(aX)
RETURN ( STR(aX[1],2)+"g."+STR(aX[2],2)+"m."+STR(aX[3],2)+"d." )

