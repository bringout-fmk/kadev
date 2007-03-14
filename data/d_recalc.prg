#include "\dev\fmk\kadev\kadev.ch"


function mnu_recalc()
PRIVATE Izbr:=1

PRIVATE opc[2]
opc[1]="1. rekalkulacija statusa     "
opc[2]="2. rekalkulacija rad.staza"


DO WHILE .T.

  h[1]:=""
  h[2]:=""
  Izbr:=Menu("reka",opc,Izbr,.F.)

  O_K_0
  if !flock(); Msg("Neko vec radi sa podacima..."); closeret; endif

  DO CASE
    CASE Izbr==0
      return
    CASE Izbr==1
      RekStatAll()
    CASE Izbr==2
      RekRstAll()
  END CASE

END DO

closeret



function RekStatAll()
local nOldArr

PushWa()
nOldArr:=SELECT()

O_K_1
O_PROMJ
O_RJRMJ
O_KBENRST
O_RRASP


#ifndef C50
select k_1    ; set order to tag "1"
select promj  ; set order to tag "ID"
select rjrmj  ; set order to tag "ID"
select kbenrst; set order to tag "ID"
select rrasp  ; set order to tag "ID"
#else
select k_1    ; set order to I_ID
select promj  ; set order to I_ID
select rjrmj  ; set order to I_ID
select kbenrst; set order to I_ID
select rrasp  ; set order to I_ID
#endif

select k_1
set relation to IdPromj into promj
set relation to IdRj+IdRmj into rjrmj addi

select k_0
set relation to idRrasp into RRasp


dDoDat:=DATE()
Box("b0XX",1,32,.f.)
 set cursor on
 @ m_x+1,m_y+2 SAY "Kalkulacija do datuma:" GET dDoDat
 read
BoxC()
if lastkey()==K_ESC
  closeret
endif

select(nOldArr)

IF gPostotak=="D"
  Postotak(1,RECCOUNT2(),"Rekalkulisanje statusa")
ELSE
  Box("b0XY",1,55,.f.)
ENDIF
n1:=0
go top
do while !eof()
  IF gPostotak!="D"
    @ m_x+1,m_y+2 SAY k_0->(id+": "+prezime+" "+ime)
  ELSE
    Postotak(2,++n1)
  ENDIF
  select k_1
  seek k_0->id
  RekalkStatus(dDoDat)
  select(nOldArr)
  skip
enddo
IF gPostotak=="D"
 Postotak(0)
ELSE
 BoxC()
ENDIF

PopWa()

closeret

**************************
**************************
function RekalkStatus(dDoDat)
local cIntStat:=" "     // intervalni status (kod nezavrsenih interv.promjena)
replace k_0->status with ""          ,;
        k_0->IdRJ    with ""         ,;
        k_0->IdRMJ   with ""         ,;
        k_0->DatURmj with CTOD("")   ,;
        k_0->DatVRmj with CTOD("")   ,;
        k_0->IdRRASP with ""         ,;
        k_0->SlVr    with ""         ,;
        k_0->VrSlVr with 0           ,;
        k_0->IdStrSpr with ""        ,;
        k_0->DatUF with CTOD("")     ,;
        k_0->IdZanim with ""

do while id=k_0->id .and. (DatumOd<dDoDat)

   if promj->tip<>"X"
     IF EMPTY(cIntStat)                           // MS 18.9.00.
       replace k_0->status with promj->status
     ELSE                                         // MS 18.9.00.
       replace k_0->status with cIntStat          // MS 18.9.00.
     ENDIF                                        // MS 18.9.00.
   endif

   if promj->srmj=="1"  // SRMJ=="1" - promjena radnog mjesta
       replace k_0->idRj with IdRj
       replace k_0->idRMJ with IdRMJ
       replace k_0->DatURMJ with DatumOd
       replace k_0->DatURMJ with DatumOd
       if empty(k_0->DatUF)
         replace k_0->DatUF with DatumOd
       endif
       replace k_0->DatVRmj with CTOD("")
   else
       replace k_1->idRj with k_0->IdRj
       replace k_1->idRMJ with k_0->IdRMJ
   endif

   if promj->urrasp=="1" // setovanje ratnog rasporeda
      replace k_0->IdRRasp with cAtr1
   endif

   if promj->ustrspr=="1" // setovanje ratnog rasporeda
      replace k_0->IdStrSpr with cAtr1
      replace k_0->IdZanim  with cAtr2
   endif

   if promj->uradst=" " .and. promj->tip=" " // fiksna promjena koja
      replace k_1->IdRMJ with ""            //  - ne ulazi u rst -
      replace k_1->IdRJ with ""
      replace k_0->DatVRMJ with DatumOd
   endif

   if promj->tip=="I"  // intervalna promjena

     if !(empty(DatumDo) .or. (DatumDo>dDoDat)) // zatvorena
       if promj->status="M" .and. rrasp->catr="V" // catr="V" -> sluzenje vojnog roka
         replace k_0->SlVr with "D"
         replace k_0->VrSlVr with k_0->VrSlVr + (DatumDo-DatumOd)
       endif
     endif

     if empty(DatumDo) .or. (DatumDo>dDoDat)
       replace k_0->DatVRMJ with DatumOd
       cIntStat := promj->status                  // MS 18.9.00.
     else   // vr{i se zatvaranje promjene
       if promj->uRrasp="1"  // ako je intervalna promjena setovala RRasp
          replace k_0->IdRRasp with ""
       endif
       replace k_0->status with "A" // promjena je zatvorena
     endif
   endif
   skip
enddo
RETURN (NIL)


***********************************************************************
// lPom=.t. -> radni staz u firmi zapisuj u POM.DBF, a ne diraj K_0.DBF
***********************************************************************
function RekRStAll(lPom)
local nOldArr

IF lPom==NIL; lPom:=.f.; ENDIF

PushWa()
nOldArr:=SELECT()

O_K_1
O_PROMJ
O_RJRMJ
O_KBENRST
O_RRASP

#ifndef C50
select k_1    ; set order to tag "1"
select promj  ; set order to tag "ID"
select rjrmj  ; set order to tag "ID"
select kbenrst; set order to tag "ID"
select rrasp  ; set order to tag "ID"
#else
select k_1    ; set order to I_ID
select promj  ; set order to I_ID
select rjrmj  ; set order to I_ID
select kbenrst; set order to I_ID
select rrasp  ; set order to I_ID
#endif

select k_1
set relation to IdPromj into promj
set relation to IdRj+IdRmj into rjrmj addi

select rjrmj
set relation to sbenefrst into kbenrst

select k_0
set relation to idRrasp into RRasp

IF lPom
  dDoDat:=DATE()      // ?
ELSE
  dDoDat:=DATE()
  Box("b0XX",1,32,.f.)
   set cursor on
   @ m_x+1,m_y+2 SAY "Kalkulacija do datuma:" GET dDoDat
   read
  BoxC()
  if lastkey()==K_ESC
    closeret
  endif
endif

select(nOldArr)

IF gPostotak=="D"
  Postotak(1,RECCOUNT2(),"Rekalkulisanje radnog staza")
ELSE
  Box("b0XY",1,55,.f.)
ENDIF
n1:=0
go top
do while !eof() 

  IF gPostotak!="D"
    @ m_x+1,m_y+2 SAY k_0->(id+": "+prezime+" "+ime)
  ELSE
    Postotak(2,++n1)
  ENDIF
  select k_1
  seek k_0->id
  RekalkRSt(dDoDat,lPom)
  select(nOldArr)
  skip
enddo

IF gPostotak=="D"
  IF lPom
    Postotak(-1)
  ELSE
    Postotak(0)
  ENDIF
ELSE
  BoxC()
ENDIF

*select k_1
*set relation to
*select k_0
*set relation to
*select rjrmj
*set relation to
PopWa()
closeret


***********************************************************************
// lPom=.t. -> radni staz u firmi zapisuj u POM.DBF, a ne diraj K_0.DBF
***********************************************************************
function RekalkRst(dDoDat,lPom)
 LOCAL nArr:=0, nRStUFe:=0, nRStUFb:=0
  IF lPom==NIL; lPom:=.f.; ENDIF
  nRstE:=0
  nRstB:=0
  KBfR:=0
  dOdDat:=CTOD("")
  fOtvoreno:=.f.
  do while id=k_0->id .and. (DatumOd<dDoDat)
    if promj->Tip="X" .and. promj->URadSt = "="
      nRstE   := nAtr1
      nRstB   := nAtr2
      nRstUFe := nAtr1
      nRstUFb := nAtr2
    endif
    if promj->Tip="X" .and. promj->URadSt = "+"
      nRstE   += nAtr1
      nRstB   += nAtr2
      nRstUFe += nAtr1
      nRstUFb += nAtr2
    endif
    if promj->Tip="X" .and. promj->URadSt = "-"
        nRstE-=nAtr1
        nRstB-=nAtr2
    endif
    if promj->Tip="X" .and. promj->URadSt = "A"
        nRstE:=(nRstE+nAtr1)/2
        nRstB:=(nRstB+nAtr2)/2
    endif
    if promj->Tip="X" .and. promj->URadSt = "*"
        nRstE:=nRstE*nAtr1
        nRstB:=nRstB*nAtr2
    endif
    if promj->Tip=="X" // ignorisi ovu promjenu
       skip
       loop
    endif
    if fOtvoreno
          nPom:=(DatumOd-dOdDat)
          nPom2:=nPom*kBfR/100
          if nPom<0 .and. promj->tip=="I"      // .and. ... dodao MS 18.9.00.
            MsgO("Neispravne promjene kod "+k_0->prezime+" "+k_0->ime)
            Inkey(0)
            MsgC()
//            MsgBeep( "nPom="+STR(nPom)+", DatumOd="+;
//                     DTOC(DatumOd)+", dOdDat="+DTOC(dOdDat) )
            return
          else
            nRstE+=nPom
            nRstB+=nPom2
          endif
    endif
    if promj->Tip==" " .and. promj->URadSt $ "12" //postavljenja,....
      dOdDat:=DatumOd          // otpocinje proces kalkulacije
      if promj->URadSt=="1"
       KBfR:=kbenrst->vrijednost
      else   // za URadSt = 2 ne obracunava se beneficirani r.st.
       KBfR:=0
      endif
      fOtvoreno:=.t.     // Otvaram pocetak trajanja promjene ....
    else
      fOtvoreno:=.f.
    endif
    if promj->Tip=="I" .and. promj->URadSt==" "
      if empty(DatumDo)  // otvorena intervalna promjena koja se ne uracunava
        fOtvoreno:=.f.   // u radni staz - znaci nema vise
      else
        fOtvoreno:=.t.
        dOdDat:=iif(DatumDo>dDoDat,dDoDat,DatumDo) // ako je DatumDo unutar
        // promjene veci od Datuma kalkulacije onda koristi dDoDat
        KBfR:=kbenrst->vrijednost
      endif
    endif
    if promj->Tip=="I" .and. promj->URadSt $ "12"
      nPom:=iif(empty(DatumDo),dDoDat,if(DatumDo>dDoDat,dDoDat,DatumDo))-DatumOd
      if promj->URadSt=="1"
        nPom2:=nPom*kbenrst->vrijednost/100
      else   // za URadSt = 2 ne obracunava se beneficirani r.st.
        nPom2:=0
      endif
      if nPom<0
        MsgO("Neispravne intervalne promjene kod "+k_0->prezime+" "+k_0->ime)
        Inkey(0)
        MsgC()
        BoxC()
        return
      else
        nRstE+=nPom
        nRstB+=nPom2
        fOtvoreno:=.t.
        dOdDat:=iif(empty(DatumDo),dDoDat,iif(DatumDo>dDoDat,dDoDat,DatumDo))
        KBfR:=kbenrst->vrijednost
      endif
    endif
    skip
  enddo
  if fOtvoreno
    nPom:=(dDoDat-dOdDat)
    nPom2:=nPom*kBfR/100
    if nPom<0
      MsgO("Neispravne promjene ili dat. kalkul. za "+k_0->prezime+" "+k_0->ime)
      Inkey(0)
      MsgC()
      BoxC()
      return
    else
      nRstE+=nPom
      nRstB+=nPom2
    endif
  endif

  if lPom
    nArr:=SELECT()
    SELECT (F_POM)
     APPEND BLANK
       REPLACE ID     WITH K_0->ID        ,;
               RADSTE WITH nRstE-nRStUFe  ,;
               RADSTB WITH nRstB-nRStUFb  ,;
               STATUS WITH K_0->STATUS
    SELECT (nArr)
  else
    replace k_0->RadStE with nRStE
    replace k_0->RadStB with nRStB
  endif
RETURN (NIL)

