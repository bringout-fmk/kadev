#include "\dev\fmk\kadev\kadev.ch"



function MUPPER(cInput)
 IF gKodnaS=="7"
   cInput:=STRTRAN(cInput,"{","[")
   cInput:=STRTRAN(cInput,"|","\")
   cInput:=STRTRAN(cInput,"~","^")
   cInput:=STRTRAN(cInput,"}","]")
   cInput:=STRTRAN(cInput,"`","@")
 ELSE  // "8"
   cInput:=STRTRAN(cInput,"ç","æ")
   cInput:=STRTRAN(cInput,"Ð","Ñ")
   cInput:=STRTRAN(cInput,"Ÿ","¬")
   cInput:=STRTRAN(cInput,"†","")
   cInput:=STRTRAN(cInput,"§","¦")
 ENDIF
return UPPER(cInput)


function MLOWER(cInput)
 IF gKodnaS=="7"
   cInput:=STRTRAN(cInput,"[","{")
   cInput:=STRTRAN(cInput,"\","|")
   cInput:=STRTRAN(cInput,"^","~")
   cInput:=STRTRAN(cInput,"]","}")
   cInput:=STRTRAN(cInput,"@","`")
 ELSE  // "8"
   cInput:=STRTRAN(cInput,"æ","ç")
   cInput:=STRTRAN(cInput,"Ñ","Ð")
   cInput:=STRTRAN(cInput,"¬","Ÿ")
   cInput:=STRTRAN(cInput,"","†")
   cInput:=STRTRAN(cInput,"¦","§")
 ENDIF
return LOWER(cInput)


FUNCTION BtoE(cInput)
 IF gKodnaS=="7"
   cInput:=STRTRAN(cInput,"[","S"+CHR(255))
   cInput:=STRTRAN(cInput,"\","D"+CHR(255))
   cInput:=STRTRAN(cInput,"^","C"+CHR(254))
   cInput:=STRTRAN(cInput,"]","C"+CHR(255))
   cInput:=STRTRAN(cInput,"@@","Z"+CHR(255))
   cInput:=STRTRAN(cInput,"{","s"+CHR(255))
   cInput:=STRTRAN(cInput,"|","d"+CHR(255))
   cInput:=STRTRAN(cInput,"~","c"+CHR(254))
   cInput:=STRTRAN(cInput,"}","c"+CHR(255))
   cInput:=STRTRAN(cInput,"`","z"+CHR(255))
 ELSE  // "8"
   cInput:=STRTRAN(cInput,"æ","S"+CHR(255))
   cInput:=STRTRAN(cInput,"Ñ","D"+CHR(255))
   cInput:=STRTRAN(cInput,"¬","C"+CHR(254))
   cInput:=STRTRAN(cInput,"","C"+CHR(255))
   cInput:=STRTRAN(cInput,"¦","Z"+CHR(255))
   cInput:=STRTRAN(cInput,"ç","s"+CHR(255))
   cInput:=STRTRAN(cInput,"Ð","d"+CHR(255))
   cInput:=STRTRAN(cInput,"Ÿ","c"+CHR(254))
   cInput:=STRTRAN(cInput,"†","c"+CHR(255))
   cInput:=STRTRAN(cInput,"§","z"+CHR(255))
 ENDIF
RETURN PADR(cInput,100)


function MsgPPromj()
 Box(,22,34)
  @ m_x+ 1,m_y+2 SAY "Vazeca polja su:                "
  @ m_x+ 2,m_y+2 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
  @ m_x+ 3,m_y+2 SAY " DATUMOD- dat.pocetka promjene  "
  @ m_x+ 4,m_y+2 SAY " DATUMDO- dat.kraja promjene    "
  @ m_x+ 5,m_y+2 SAY "   NATR1- numer.karakteristika 1"
  @ m_x+ 6,m_y+2 SAY "   NATR2- numer.karakteristika 2"
  @ m_x+ 7,m_y+2 SAY "   NATR3- numer.karakteristika 3"
  @ m_x+ 8,m_y+2 SAY "   NATR4- numer.karakteristika 4"
  @ m_x+ 9,m_y+2 SAY "   NATR5- numer.karakteristika 5"
  @ m_x+10,m_y+2 SAY "   NATR6- numer.karakteristika 6"
  @ m_x+11,m_y+2 SAY "   NATR7- numer.karakteristika 7"
  @ m_x+12,m_y+2 SAY "   NATR8- numer.karakteristika 8"
  @ m_x+13,m_y+2 SAY "   NATR9- numer.karakteristika 9"
  @ m_x+14,m_y+2 SAY "   CATR1- karakteristika 1      "
  @ m_x+15,m_y+2 SAY "   CATR2- karakteristika 2      "
  @ m_x+16,m_y+2 SAY "     IDK- sifra karakteristike  "
  @ m_x+17,m_y+2 SAY "DOKUMENT- broj dokumenta        "
  @ m_x+18,m_y+2 SAY "    OPIS- opis nastanka promjene"
  @ m_x+19,m_y+2 SAY "NADLEZAN- nadlezno lice         "
  @ m_x+20,m_y+2 SAY "    IDRJ- sifra radne jedinice  "
  @ m_x+21,m_y+2 SAY "   IDRMJ- sifra radnog mjesta   "
  inkey(0)
 BoxC()
return .f.



function OSVAL(aIDDef,cIzraz)
 LOCAL i:=0, nArr:=SELECT()
 IF cIzraz==NIL
   cIzraz77:=".t."
 ELSE
   cIzraz77:=cIzraz
 ENDIF
 SELECT DEFRJES
  FOR i:=1 TO LEN(aIDDef)
    cIDDef:="ID"+aIDDef[i]
    SEEK RJES->id+aIDDef[i]
    IF FOUND()
      cDRIzraz:=ALLTRIM(izraz)
      &cIdDef:=&cDRIzraz
    ENDIF
  NEXT
  RefreshGets()
 SELECT(nArr)
RETURN &cIzraz77


function GS()
 LOCAL aRstE,aRstB,aRStU
  aRstE:=GMJD(K_0->RadStE)
  aRstB:=GMJD(K_0->RadStB)
  aRStU:=ADDGMJD(aRStE,aRStB)
RETURN aRStU[1]


function DC(xVr,aRadi)
 LOCAL i:=0, xVrati:=0
 altd()
  FOR i:=1 TO LEN(aRadi)
    IF xVr>=aRadi[i,1] .and. xVr<aRadi[i,2]
      xVrati:=aRadi[i,3]
      EXIT
    ENDIF
  NEXT
RETURN xVrati



function GenNerDan()

aDani:={0,0,0,0,0,0,0}
//      N P U S C P S
//      1 2 3 4 5 6 7
cGodina:="2000"
cSubote   := "1"   
// 1-samo prva radna
cNedjelje := "0"   
// 0-sve neradne

IF !VarEdit({ {"Za godinu"                                                ,"cGodina"   ,""                ,"9999" ,""},;
               {"SUBOTE   (0-sve neradne/1-prva u mjes.radna/9-sve radne)" ,"cSubote"   ,"cSubote$'019'"   ,"9"    ,""},;
               {"NEDJELJE (0-sve neradne/1-prva u mjes.radna/9-sve radne)" ,"cNedjelje" ,"cNedjelje$'019'" ,"9"    ,""} },;
               7,1,20,78,"USLOV ZA NERADNE SUBOTE I NEDJELJE","B1")
   return
ENDIF

dLastD:=CTOD("01.01."+cGodina)
dDatum:=CTOD("01.01."+cGodina)

DO WHILE YEAR(dDatum)==VAL(cGodina)
   IF MONTH(dDatum)<>MONTH(dLastD); aDani:={0,0,0,0,0,0,0}; ENDIF
   IF DOW(dDatum)==1        // nedjelja
     IF cNedjelje=="0" .or. cNedjelje=="1".and.aDani[1] > 0
       APPEND BLANK
       Scatter()
         _id    := cGodina
         _naz   := "NEDJELJA"
         _datum := dDatum
       Gather()
     ENDIF
   ELSEIF DOW(dDatum)==7    // subota
     IF cSubote=="0" .or. cSubote=="1".and.aDani[7] > 0
       APPEND BLANK
       Scatter()
         _id    := cGodina
         _naz   := "NERADNA SUBOTA"
         _datum := dDatum
       Gather()
     ENDIF
   ENDIF
   ++aDani[DOW(dDatum)]
   dLastD:=dDatum
   dDatum:=dDatum+1
ENDDO

return


function ZadDanGO(dPDanGO,nDanaGO)
  LOCAL nArr:=SELECT(), nSubota:=0
  IF EMPTY(dPDanGO).or.nDanaGO==0; RETURN (CTOD("")); ENDIF
  SELECT (F_NERDAN); IF !USED(); O_NERDAN; ENDIF
  SET ORDER TO TAG "DAT"
  DO WHILE nDanaGO>0
    IF DOW(dPDanGO)==7; ++nSubota; ENDIF
    SEEK dPDanGO
//    IF !FOUND().and.!(DOW(dPDanGO)==7.and.nSubota>2)  // znaŸi radni je dan
    IF !FOUND()  // znaŸi radni je dan
      --nDanaGO      // smanjujemo preostali broj dana GO
    ENDIF
    IF nDanaGO>0; ++dPDanGO; ENDIF
  ENDDO
  SELECT (nArr)
RETURN (dPDanGO)


function DatVrGO(dZDanGO)
  LOCAL nArr:=SELECT()
  IF EMPTY(dZDanGO); RETURN (CTOD("")); ENDIF
  SELECT (F_NERDAN); IF !USED(); O_NERDAN; ENDIF
  SET ORDER TO TAG "DAT"
  DO WHILE .t.
    ++dZDanGO
    SEEK dZDanGO
    IF !FOUND()      // znaŸi radni je dan
      EXIT
    ENDIF
  ENDDO
  SELECT (nArr)
RETURN (dZDanGO)


function ImaRDana(dOd,dDo)
 LOCAL nDana:=0, i:=0, nSubota:=0
 LOCAL nArr:=SELECT()
 SELECT (F_NERDAN); IF !USED(); O_NERDAN; ENDIF
 SET ORDER TO TAG "DAT"
 FOR i:=0 TO IF(dDo-dOd==0,0,dDo-dOd)
   IF DOW(dOd+i)==7; ++nSubota; ENDIF
   SEEK dOd+i
//   IF !FOUND().and.!(DOW(dOd+i)==7.and.nSubota>2); ++nDana; ENDIF
   IF !FOUND(); ++nDana; ENDIF
 NEXT
 SELECT (nArr)
RETURN nDana


// -----------------------------------------------
// ova funkcija vjerovatno ne treba vise ???????
// -----------------------------------------------
function __Tacno(aUsl)
local i
private cPom

if len(aUsl)==0
	return .t.
endif

for i:=1 to len(aUsl)
	cPom:=aUsl[i]
 	if &cPom
   		return .t.
 	endif
next
return .f.

// -----------------------------------------------
// ni ova 
// -----------------------------------------------
function __TacnoN(aUsl,bIni,bWhile,bSkip,bEnd)
local i
private cPom

if len(aUsl)==0
 return .t.
endif

EVAL(bIni)

do while EVAL(bWhile)

for i:=1 to len(aUsl)
 cPom:=aUsl[i]
 if &cPom
   return .t.
 endif
next

EVAL(bSkip)
enddo

Eval(bEnd)
return .f.



function IzborFajla(cPutanja,cAtrib)
 PRIVATE opc:={},Izb:=1,h:={}
 opc:=ListaFajlova(cPutanja,cAtrib)
 AEVAL(opc,{|x| AADD(h,IscitajZF(SUBSTR(x,4)))})
 IF LEN(opc)<1
   MsgBeep("'"+cPutanja+"': ne postoji nijedan trazeni fajl!##Obratite se servisu SIGMA-COM-a")
   Izb:=0    // <- ovo mo§da i ne treba
   RETURN ""
 ENDIF
 Izb:=Menu("",opc,Izb,.t.,"1-1")
 IF Izb>0; Menu("",opc,0,.f.); ENDIF
return IF( Izb==0 , "" , SUBSTR(opc[izb],4) )



function ListaFajlova(cPutanja,cAtrib)
 LOCAL aNiz:=DIRECTORY(cPutanja,cAtrib)
 LOCAL i:=0,aVrati:={}
 ASORT(aNiz,,,{|x,y| x[1]<y[1]})
 AEVAL(aNiz,{|x| ++i, AADD(aVrati,IF(i<10,STR(i,1),CHR(55+i))+". "+x[1])} )
return aVrati


function IscitajZF(cFajl)
 LOCAL nP1:=0,nP2:=0,nH:=0,cVrati:=""
 nH:=FOPEN(cFajl,2)
 FSEEK(nH,0); cVrati:=FREADSTR(nH,80)
 nP1:=AT('"',cVrati); nP2:=RAT('"',cVrati)
 FCLOSE(nH)
return IF( nP1<nP2, SUBSTR(cVrati,nP1+1,nP2-nP1-1), "")



