#include "\dev\fmk\kadev\kadev.ch"


function TKadevModNew()
local oObj

#ifdef CLIP

#else
	oObj:=TKadevMod():new()
#endif

oObj:self:=oObj
return oObj



#ifdef CPP

class TKadevMod: public TAppMod
{
	public:
	*void dummy();
	*void setGVars();
	*void mMenu();
	*void mMenuStandard();
	*void sRegg();
	*void initdb();
	*void srv();
	
#endif

#ifndef CPP
#include "class(y).ch"
CREATE CLASS TKadevMod INHERIT TAppMod
	EXPORTED:
	method dummy 
	method setGVars
	method mMenu
	method mMenuStandard
	method sRegg
	method initdb
	method srv
END CLASS
#endif

method dummy()
return


method initdb()

::oDatabase:=TDBKadevNew()

return nil



method mMenu()

private Izbor
private lPodBugom

SET EPOCH TO 1910

if gCentOn == "D"
	SET CENTURY ON
else
	SET CENTURY OFF
endif

SETKEY(K_SH_F1, {|| Calc()} )
Izbor := 1

CheckROnly(KUMPATH + "\K_0.DBF")

O_K_0
select k_0

TrebaRegistrovati(10)
use

#ifdef PROBA
	KEYBOARD "213"
#endif

@ 1,2 SAY padc(gTS+": "+gNFirma,50,"*")
@ 4,5 SAY ""

::mMenuStandard()

::quit()

return nil



method srv()
? "Pokrecem kadev aplikacijski server"
if (MPar37("/KONVERT", goModul))
	if LEFT(self:cP5,3)=="/S="
		cKonvSez:=SUBSTR(self:cP5,4)
		? "Radim sezonu: " + cKonvSez
		if cKonvSez<>"RADP"
			// prebaci se u sezonu cKonvSez
			goModul:oDataBase:cSezonDir:=SLASH+cKonvSez
 			goModul:oDataBase:setDirKum(trim(goModul:oDataBase:cDirKum)+SLASH+cKonvSez)
 			goModul:oDataBase:setDirSif(trim(goModul:oDataBase:cDirSif)+SLASH+cKonvSez)
 			goModul:oDataBase:setDirPriv(trim(goModul:oDataBase:cDirPriv)+SLASH+cKonvSez)
		endif
	endif
	goModul:oDataBase:KonvZN()
	goModul:quit(.f.)
endif
// modifikacija struktura
if (MPar37("/MODSTRU", goModul))
	if LEFT(self:cP5,3)=="/S="
		cSez:=SUBSTR(self:cP5,4)
		? "Radim sezonu: " + cKonvSez
		if cSez<>"RADP"
			// prebaci se u sezonu cKonvSez
			goModul:oDataBase:cSezonDir:=SLASH+cKonvSez
 			goModul:oDataBase:setDirKum(trim(goModul:oDataBase:cDirKum)+SLASH+cSez)
 			goModul:oDataBase:setDirSif(trim(goModul:oDataBase:cDirSif)+SLASH+cSez)
 			goModul:oDataBase:setDirPriv(trim(goModul:oDataBase:cDirPriv)+SLASH+cSez)
		endif
	endif
	cMsFile:=goModul:oDataBase:cName
	if LEFT(self:cP6,3)=="/M="
		cMSFile:=SUBSTR(self:cP6,4)
	endif
	AppModS(cMsFile)
	goModul:quit(.f.)
endif

return


method mMenuStandard

private opc:={}
private opcexe:={}

say_fmk_ver()

AADD(opc, "1. podaci                                 ")
AADD(opcexe, {|| mnu_data()})
AADD(opc, "2. pretrazivanje")
AADD(opcexe, {|| mnu_srch()})
AADD(opc, "3. rekalkulacija")
AADD(opcexe, {|| mnu_recalc()})
AADD(opc, "4. izvjestaji")
AADD(opcexe, {|| mnu_rpt()})
AADD(opc, "5. obrazac")
AADD(opcexe, {|| mnu_form()})
AADD(opc, "6. radna karta")
AADD(opcexe, {|| work_card()})
AADD(opc, "------------------------------------")
AADD(opcexe, {|| nil })
AADD(opc, "S. sifrarnici")
AADD(opcexe, {|| mnu_sif() })
AADD(opc, "------------------------------------")
AADD(opcexe, {|| nil })
AADD(opc, "9. administracija baze")
AADD(opcexe, {|| goModul:oDataBase:install() })
AADD(opc, "------------------------------------")
AADD(opcexe, {|| nil })
AADD(opc, "X. parametri")
AADD(opcexe, {|| mnu_params()})

private Izbor:=1

Menu_SC("kadev_os_meni", .t., lPodBugom)

return


method sRegg()
sreg("KADEV.EXE","KADEV")
return


method setGVars()
O_PARAMS

SetFmkSGVars()
SetSpecifVars()

O_PARAMS

public glBezVoj := ( IzFMKINI("KADEV","BezVojneEvidencije","N",KUMPATH)=="D" )
public gnLMarg:=1
public gnTMarg:=1
// lijeva margina teksta
public gTabela:=1          
// fino crtanje tabele
public gA43:="4"           
// format papira
public gnRedova:=64        
// za ostranicavanje - broj redova po stranici
public gOstr:="D"          
// ostranicavanje
public gPostotak:="D"      
// prikaz procenta uradjenog posla (znacajno kod
// dugih cekanja na izvrsenje opcije)
public gDodKar1:="Karakteristika 1"
public gDodKar2:="Karakteristika 2"
public gTrPromjena:="KP"
public gNFirma:=SPACE(40)
public gCentOn:="N"

O_PARAMS
private cSection:="1",cHistory:=" "; aHistory:={}

RPar("tb",@gTabela)
RPar("pr",@gnLMarg)
RPar("p1",@gnTMarg)
Rpar("a4",@gA43)
Rpar("rs",@gnRedova)
Rpar("os",@gOstr)
Rpar("po",@gPostotak)
Rpar("k1",@gDodKar1)
Rpar("k2",@gDodKar2)
Rpar("tp",@gTrPromjena)
Rpar("fi",@gNFirma)
Rpar("co",@gCentOn)

select params
use
release cSection, cHistory, aHistory

return



