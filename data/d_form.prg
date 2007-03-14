#include "\dev\fmk\kadev\kadev.ch"


function mnu_form()

o_tables()

select rmj
#ifndef C50
set order to tag "ID"
#else
set order to I_ID
#endif
select k_0
set relation to idRmj into rmj

select rj
#ifndef C50
set order to tag "ID"
#else
set order to I_ID
#endif
select k_0
set relation to idRj into rj additive


select rjrmj
#ifndef C50
set order to tag "ID"
#else
set order to I_ID
#endif
select k_0
set relation to idRj+idrmj into rjrmj additive

select strspr
#ifndef C50
set order to tag "ID"
#else
set order to I_ID
#endif
select k_0
set relation to IdStrSpr into strspr additive

select mz
#ifndef C50
set order to tag "ID"
#else
set order to I_ID
#endif
select k_0
set relation to IdMzSt into mz additive


select k1
#ifndef C50
set order to tag "ID"
#else
set order to I_ID
#endif
select k_0
set relation to IdK1 into k1 additive

select k2
#ifndef C50
set order to tag "ID"
#else
set order to I_ID
#endif
select k_0
set relation to IdK2 into k2 additive


select zanim
#ifndef C50
set order to tag "ID"
#else
set order to I_ID
#endif
select k_0
set relation to IdZanim into zanim additive

select nac
#ifndef C50
set order to tag "ID"
#else
set order to I_ID
#endif
select k_0
set relation to Idnac into nac additive

select rrasp
#ifndef C50
set order to tag "ID"
#else
set order to I_ID
#endif
select k_0
set relation to IdRRasp into rrasp additive

select cin
#ifndef C50
set order to tag "ID"
#else
set order to I_ID
#endif
select k_0
set relation to IdCin into cin additive

select VES
#ifndef C50
set order to tag "ID"
#else
set order to I_ID
#endif
select k_0
set relation to IdVEs into ves additive

select rjrmj
#ifndef C50
set order to tag "ID"
#else
set order to I_ID
#endif
select k_0
set relation to idrj+idrmj into rjrmj additive

select k_0

PUBLIC aRez,aGrupa,aKatUsl,aKatVal,aZagl

IzborObrasca()

PRIVATE Izb2:=1
DO WHILE .T.
  PRIVATE opc[4]
//  @ 4,5 SAY ""
  opc[1]="1. ispravka definicije       "
  opc[2]="2. generisanje kalkulacije"
  opc[3]="3. izbor obrasca"
  opc[4]="4. brisanje obrasca"
  h[1]=" Prepravka baza koje definisu parametre obrasca "
  h[2]=" Generacija  izvjestaja "
  h[3]=" Izbor baze za definiciju obrasca "
  h[4]=" Nepovratno uklanjanje obrasca "
  Izb2:=Menu("omain",opc,Izb2,.F.)

  DO CASE
    CASE Izb2==0
     EXIT
   CASE Izb2==1
     Edit()
   CASE Izb2==2
     Generisi()
   CASE Izb2==3
     IzborObrasca()
   CASE Izb2==4
     BrisiObrazac()
 END CASE
ENDDO

@ 1,39 SAY SPACE(40) COLOR "N/N"

closeret


**************************
**************************
function BrisiObrazac()
  LOCAL lInsert:=READINSERT(.t.)
  private cImeFOB:=".DBF        "
  if VarEdit( { {"Puni naziv obrasca koji zelite izbrisati",;
                 "cImeFOB",;
                 "PostojiFajl(cImeFOB)",;
                 "@!", } },;
              11, 1, 15, 78, "BRISANJE OBRASCA", "B1" )
    IF FERASE(KUMPATH+ALLTRIM(cImeFOB))!=0
      Msg("Brisanje nije uspjelo. Navedeni obrazac se vjerovatno koristi kao tekuci!",3)
    ENDIF
  endif
  READINSERT(lInsert)
return (nil)


**************************
**************************
function PostojiFajl(cF)
 local lVrati := FILE(KUMPATH+ALLTRIM(cF))
 if !lVrati
   Msg("Navedeni fajl ne postoji!",3)
 endif
return lVrati


**************************
**************************
function IzborObrasca()
local nRed

private opc
private h

 opc:={}
 aFiles:=DIRECTORY(KUMPATH+"obraz*.dbf")
 h:=ARRAY(LEN(aFiles)+1)
 i:=0
 AEVAL(aFiles,{|elem| h[++i]:="",AADD(opc,PADR(elem[1],15))})
 AADD(opc,PADR("Novi obrazac",15))
 h[i+1]:="Kreiranje novog obrasca"

 Izb3:=1

do while .t.

 Izb3:=Menu("izobr",opc,Izb3,.f.)
 do case
  case Izb3==0
    exit
    return
  case Izb3<LEN(opc)
    select obrazdef
    #ifndef C50
    usex (KUMPATH+opc[Izb3]) alias obrazdef
    index on brisano tag "BRISAN"
    index on tip+grupa+red_br tag "1"
// CREATE_INDEX("1" , "tip+grupa+red_br", KUMPATH+"obrazdef")
    REINDEX
    set order to tag "1"
    #else
    use (KUMPATH+opc[Izb3]) index obrazde1 alias obrazdef
    DBreindex()
    #endif
    @ 1,39 SAY PADR('Tekuci obrazac: '+opc[Izb3],40) COLOR "GR+/N"
  otherwise
   set cursor on
   Box("nobr",1,46,.f.)
   cIdObr=SPACE(3)
   @ m_x+1,m_y+2 SAY "Unesi tri slova za identifikaciju obrasca:" GET cIdObr
   READ
   BoxC()
   set cursor off

   if FILE(KUMPATH+"obraz"+cIdObr+".dbf")
     Msg("Fajl vec postoji !!!",10)
   else
         aDbf:={}
         AADD(aDbf,{"Tip","C",1,0})
         AADD(aDbf,{"Grupa","C",1,0})
         AADD(aDbf,{"Red_Br","C",1,0})
         AADD(aDbf,{"Komentar","C",25,0})
         AADD(aDbf,{"Uslov","C",200,0})
         AADD(aDbf,{"brisano","C",1,0})
         DBCREATE2(KUMPATH+"obraz"+cIdObr,aDbf)
   endif
 endcase

enddo
**************************
**************************
function Generisi()
aUslovi:={}
select globusl
DBEVAL( {|| AADD(aUslovi, {Komentar,' ', trim(Uslov), trim(ime_baze) } ) };
      )

if len(aUslovi)==0
  MsgO("Prekidam generisanje izvjestaja. Nije kreiran nijedan globalni uslov!")
  Inkey(0)
  MsgC()
  return
endif

Box("musl",10,30,.f.)
@ m_x,m_y+2 SAY "<SPACE> markiranje"
MABROWSE(aUslovi,m_x+1,m_y+1,m_x+10,m_y+30)
BoxC()

if ASCAN(aUslovi, {|aElem| aElem[2]='*'})==0
  return
endif


IF ASCAN(aUslovi,{|x| ALLTRIM(x[4])!="K_0".and.x[2]=='*'})!=0
  SELECT K_0
  SET RELATION TO
  SELECT RJRMJ
  SET RELATION TO
ENDIF

// set alternate to obrazac            // bilo
// ima li potrebe za upitima?
// --------------------------

lTDatumOd := .f.
lTDatumDo := .f.
d0 := CTOD("")
d1 := CTOD("")

nRed := 0

nArr:=SELECT()
SELECT OBRAZDEF
GO TOP
DO WHILE !EOF()
  cStr := komentar + uslov
  IF "&D0" $ cStr
    ++ nRed
    lTDatumOd:=.t.
  ENDIF
  IF "&D1" $ cStr
    ++ nRed
    lTDatumDo:=.t.
  ENDIF
  SKIP 1
ENDDO
SELECT (nArr)

IF nRed>0
  Box("#DODATNI USLOVI ZA GENERACIJU IZVJESTAJA",2+nRed,77)
   nRed:=0
   IF lTDatumOd
     @ m_x+1+(++nRed), m_y+2 SAY "Od datuma" GET D0
   ENDIF
   IF lTDatumDo
     @ m_x+1+(++nRed), m_y+2 SAY "Do datuma" GET D1
   ENDIF
   READ
   IF LASTKEY()==K_ESC
     BoxC(); RETURN
   ENDIF
  BoxC()
ENDIF

START PRINT RET        // sada

                          // *****************************************
FOR gi:=1 to Len(aUslovi) // odradi kalkulaciju za sve globalne uslove
                          // *****************************************

  InitGlobMatr()   // inicijalizuje matricu prora~una

  IF gi==1
    IF gPrinter=="L"
      gPO_Land()
      GuSt2(25+LEN(aKatVal)*10,"L4")
    ELSE
      GuSt2(25+LEN(aKatVal)*10,"4")
    ENDIF
  ENDIF

  select (aUslovi[gi][4]); go top

  if aUslovi[gi][2]=='*'
    cPomDev:=SET(_SET_DEVICE)         //  izlaz na
    SET DEVICE TO SCREEN              //  ekran
    GlobalUsl:=  {|| &(aUslovi[gi][3])}
    nCount:=0
    Box("count",1,30,.f.)
    @ m_x,m_y+2 SAY aUslovi[gi][1]

    do while !eof()
      select (aUslovi[gi][4])
      if EVAL(GlobalUsl)
        for i:=1 to LEN(aRez)
           for j:=1 to len(aRez[i])   // aRez[i] tipa je aGrupa
              // aRez[i][j] je tipa {bUslov,{0,0...,0}}
              IF (lUslR:=EVAL(aRez[i][j][2]))
               for x:=1 to LEN(aKatVal)  // ovo je broj kategorija
                   lUslK:=EVAL(aKatUsl[x][2])
                   if lUslK
                     IF ALLTRIM(aUslovi[gi][4])=="RJRMJ"
                       (aRez[i][j][3][x])+=brizvrs
                     ELSE
                       (aRez[i][j][3][x])++
                     ENDIF
                   endif
                 // aRez[i][j][2] - tipa aKatVal
               next
              ENDIF
           next
        next
        ++nCount
        @ m_x+1,m_y+10 SAY nCount
      endif  // if eval(globusl)
      skip
    enddo

    BoxC()

    ***************** kalkulacija sumarnih rezultata

    for i:=1 to LEN(aRez)
       AFILL(aKatVal,0)
       for j:=1 to len(aRez[i])   // aRez[i] tipa je aGrupa
          // aRez[i][j] je tipa {bUslov,{0,0...,0}}
          for x:=1 to LEN(aKatVal)  // ovo je broj kategorija
            aKatVal[x]+=aRez[i][j][3][x]
          next
       next
       aKatvv:=ACLONE(aKatVal)
       AADD(aRez[i],{PADR("UKUPNO:",25),NIL,aKatvv})
    next

    ******************* Ispis rezultata

    // set console off     // bilo
    // set alternate on    // bilo

    SET(_SET_DEVICE,cPomDev)  // nije vise izlaz na ekran

    ?
    ? PADC(' '+alltrim(aUslovi[gi][1])+' ',70,"*")
    ?

    ? SPACE(25)
    for i:=1 to LEN(aKatVal)
       ?? padl(alltrim(aKatUsl[i][1]),10)
    next
    ? SPACE(25)+REPLICATE("=",len(aKatVal)*10)
    for i:=1 to LEN(aRez)
      ?
      ? aZagl[i]
      ? replicate("-",25+10*len(aKatVaL))
      for j:=1 to len(aRez[i])   // aRez[i] tipa je aGrupa
         // aRez[i][j] je tipa {bUslov,{0,0...,0}}
         ? aRez[i][j][1]
         for x:=1 to LEN(aKatVal)  // ovo je broj kategorija
           ?? (aRez[i][j][3])[x]
         next
      next
     ? replicate("-",25+10*len(aKatVaL))
    next

    // set alternate off  // bilo
    // set console on     // bilo

  endif // if .... '*'

       // ************************************
next   // kraj petlje " gi=1 to LEN(aUslovi) "
       // ************************************

IF gPrinter=="L"
  gPO_Port()
ENDIF
FF

END PRINT             // sada

// set alternate to   // bilo


// cKomLin:="q "+SET(_SET_DEFAULT)+"\obrazac.txt"

// set cursor on
// run &cKomLin
// set cursor off

return


************************
************************
function InitGlobMatr()
select obrazdef
aRez:={}
aGrupa:={}
aKatUsl:={}
aKatVal:={}
aZagl:={}

seek "K"
do while Tip=="K"
  // cUsl:=TRIM(Uslov)
  cUsl:=Uslov
  cUsl:=STRTRAN(cUsl,"&D0",DTOC(D0))
  cUsl:=STRTRAN(cUsl,"&D1",DTOC(D1))
  cUsl:=TRIM(cUsl)
  cPom:=komentar
  cPom:=STRTRAN(cPom,"&D0",DTOC(D0))
  cPom:=STRTRAN(cPom,"&D1",DTOC(D1))
  AADD(aKatUsl,{cPom,{|| &cUsl}})
  AADD(aKatVal,0)
  skip
enddo


seek "Z"
do while Tip=="Z"
  cUsl:=Uslov
  cUsl:=STRTRAN(cUsl,"&D0",DTOC(D0))
  cUsl:=STRTRAN(cUsl,"&D1",DTOC(D1))
  cUsl:=LEFT(cUsl,70)
  AADD(aZagl,cUsl)
  skip
enddo


seek "R"
do while Tip="R"
 cGrupa:=Grupa
 aGrupa:={}
 do while grupa==cGrupa .and. Tip=="R"
   aKatvv:={}
   aKatvv:=ACLONE(aKatVal)

   // cUsl:=TRIM(Uslov)
   cUsl:=Uslov
   cUsl:=STRTRAN(cUsl,"&D0",DTOC(D0))
   cUsl:=STRTRAN(cUsl,"&D1",DTOC(D1))
   cUsl:=TRIM(cUsl)

   cPom:=komentar
   cPom:=STRTRAN(cPom,"&D0",DTOC(D0))
   cPom:=STRTRAN(cPom,"&D1",DTOC(D1))
   AADD(aGrupa,{cPom,{|| &cUsl},aKatvv})
   skip
 enddo
 AADD(aRez,aGrupa)
enddo

Altd()

return




****************************************
****************************************
function Edit()
Izb11:=1
PRIVATE opc[2]
opc[1]:="Globalni uslovi    "
opc[2]:="Definicija obrasca"
h[1]:="Globalni uslovi odredjuju jedinicu,duznosti,prisutnost"
h[2]:="Definicija redova i zaglavlja (po grupama), kolona obrasca"
do while .t.
 Izb11:=Menu("edmeni",opc,Izb11,.F.)

 DO CASE
   CASE Izb11==0
       EXIT

   CASE Izb11==1
      select globusl
      go top
       ImeKol:={ {'Komentar',{|| komentar}}    ,;
                 {'Uslov'   ,{|| LEFT(Uslov,60)+".."}}, ;
                 {'DBF-baza',{|| ime_baze}}   ;
               }
       Kol:={1,2,3}
       ObjDbEdit('usl',10,77,{|| EdGlobUsl()},"<Ctrl-N> Dodaj, <Ctrl-T> Brisi, <F2> Edit, <F4> Dupliciraj ","",.f.)

   CASE Izb11==2
      select obrazdef
      go top
      ImeKol:={{'Tip',{|| tip}},;
               {'Grupa',{|| grupa}}, ;
               {'R.Br.'   ,{|| red_br}}, ;
               {'Komentar'   ,{|| Komentar}}, ;
               {'Uslov'   ,{|| LEFT(Uslov,70)+".."}} ;
        }
       Kol:={1,2,3,4,5}
       ObjDbEdit('usl',10,77,{|| EdObrazDef()},"<Ctrl-N> Dodaj, <Ctrl-T> Brisi, <F2> Edit, <F4> Dupliciraj","",.f.)

 ENDCASE
enddo

return

************************
************************
function EdGlobUsl()
local Ch,c1,c2

Ch:=LastKey()
do case
  case Ch==K_CTRL_N .or. Ch==K_F4 .or. Ch==K_F2


    if Ch==K_CTRL_N
      APPEND BLANK
    endif

     Scatter()
     Box('EdIstIsp',3,70,.f.)
      set cursor on
      @ m_x+1,m_y+2 SAY "Komentar:" GET _Komentar PICTURE "@!"
      @ m_x+2,m_y+2 SAY "Uslov:" GET _Uslov PICTURE "@S60"
      @ m_x+3,m_y+2 SAY "Ime baze:" GET _ime_baze PICTURE "@!"
      READ
      set cursor off
     BoxC()
     if Ch==K_F4
       append blank
     endif
     Gather()
    return DE_REFRESH

  case Ch==K_CTRL_T

     if Pitanje("p94","Izbrisati kriterij: "+trim(komentar)+" ?","N")="D"
       DELETE
       return DE_REFRESH
     else
       return DE_CONT
     endif

  case Ch==K_ENTER
     RETURN DE_ABORT
  case Ch==K_ESC
     RETURN DE_ABORT
  otherwise
    return DE_CONT
endcase

************************
************************
function EdObrazDef()
 local Ch

Ch:=LastKey()
do case
  case Ch==K_CTRL_N .or. Ch==K_F4 .OR. Ch==K_F2

    if Ch==K_CTRL_N
      APPEND BLANK
    endif

     Scatter()
     Box('EdIstIsp',6,77,.f.)
      set cursor on
      @ m_x+1,m_y+2 SAY "Tip:" GET _Tip PICTURE "@!"  VALID _Tip $ "KRZ"
      @ m_x+1,m_y+12 SAY "Grupa:" GET _Grupa  PICTURE "@!"
      @ m_x+1,m_y+22 SAY "R.br.:" GEt _red_Br PICTURE "@!"
      @ m_x+3,m_y+2 SAY "Komentar:" GET _Komentar
      @ m_x+5,m_y+2 SAY "Uslov:" GET _Uslov VALID validuslov(_Uslov) PICTURE "@S60"
      READ
     BoxC()
     if Ch==K_F4
       append blank
     endif
     Gather()
    return DE_REFRESH

  case Ch==K_CTRL_T

     if Pitanje("p95","Izbrisati stavku: "+tip+"-"+grupa+"-"+red_Br+"-"+trim(komentar)+" ?","N")="D"
       DELETE
       skip
       if eof(); skip -1; endif
       return DE_REFRESH
     else
       return DE_CONT
     endif

  case Ch==K_ENTER
     RETURN DE_ABORT
  case Ch==K_ESC
     RETURN DE_ABORT
  otherwise
    return DE_CONT
endcase


******************************
******************************
function validuslov(cUslov)
 D0:=D1:=CTOD("")

 if !(Tip $ "KR")
   return .t.
 endif

 bErrorHandler:={|objError| GlobalErrorHandler(objError,.t.)}
 bLastHandler:=ErrorBlock(bErrorHandler)

 BEGIN SEQUENCE

 nOldArr:=SELECT()
 select k_0
 xRez:=&cUslov .and. .t.
 select(nOldArr)

 RECOVER USING ObjErrInfo

  BEEP(5)
  if ObjErrInfo:genCode = EG_SYNTAX
     MsgO(ObjErrInfo:description+':Neispravna sintaksa !!!!')
  elseif ObjErrInfo:genCode = EG_NOFUNC
     MsgO(ObjErrInfo:description+':Nepoznata funkcija !!!!')
  elseif ObjErrInfo:genCode = EG_ARG
     MsgO(ObjErrInfo:description+':Neispravan argument funkcije !!!!')
  elseif ObjErrInfo:genCode = EG_BOUND
     MsgO(ObjErrInfo:description+':Nepostojeci index u matrici !!!!')
  elseif ObjErrInfo:genCode = EG_NOVAR
     MsgO(ObjErrInfo:description+':Nepostojeca varijabla !!!!')
  elseif ObjErrInfo:genCode = EG_NOALIAS
     MsgO(ObjErrInfo:description+':Neispravna oznaka baze (ALIAS) !!!!')
  else
     MsgO(ObjErrInfo:description+':Greska !!!!')
  endif
  Inkey(0)
  MsgC()
  SELECT(nOldArr)

  ErrorBlock(bLastHandler)
  return .f.
 END SEQUENCE

ErrorBlock(bLastHandler)
return .t.

