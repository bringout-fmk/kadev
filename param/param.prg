#include "\dev\fmk\kadev\kadev.ch"


// ------------------------------------------
// menij parametara
// ------------------------------------------
function mnu_params()

O_PARAMS
private cSection := "1"
private cHistory := " "
private aHistory := {}
private aPars := {}

// citaj parametre
RPar("tp", @gTrPromjena)
RPar("pr", @gnLMarg)
RPar("tb", @gTabela)
Rpar("a4", @gA43)
Rpar("rs", @gnRedova)
Rpar("os", @gOstr)
Rpar("po", @gPostotak)
Rpar("k1", @gDodKar1)
Rpar("k2", @gDodKar2)
Rpar("fi", @gNFirma)
Rpar("co", @gCentOn)

UsTipke()

set cursor on

AADD(aPars, { "Naziv firme", ;
	"gNFirma",,,})
AADD(aPars, { "Lijeva margina pri stampanju", ;
	"gNLMarg", , "99" })
AADD(aPars, { "Tip tabele  (0/1/2)", ;
	"gTabela", "gTabela>=0.and.gTabela<3", "9",  } )
AADD(aPars, {"Broj redova po stranici", ;
	"gnRedova", "gnRedova>0", "999", } )
AADD(aPars, {"Da li treba ostranicavanje (D/N) ?", ;
	"gOstr", "gOstr $ 'DN'", "@!", } )
AADD(aPars, {"Prikaz postotka uradjenog posla (D/N) ?", ;
	"gPostotak", "gPostotak $ 'DN'", "@!", } )
AADD(aPars, {"Format papira za ispis  ( 3 - A3 , 4 - A4 )", ;
	"gA43", "gA43 $ '43'", "9", } )
AADD(aPars, {"Dodatna karakteristika 1 (opis)", ;
	"gDodKar1", "", "",  } )
AADD(aPars, {"Dodatna karakteristika 2 (opis)", ;
	"gDodKar2", "", "",  } )
AADD(aPars, {"Sifra promjene za brzi pregled i unos", ;
	"gTrPromjena", "", "",  } )
AADD(aPars, {"U datumima prikazivati potpunu godinu (D/N) ?", ;
	 "gCentOn", "gCentOn$'DN'", "@!", } )

VarEdit(aPars, 7, 1, 21, 78, "***** Parametri rada programa", "B1" )

BosTipke()

if LastKey() <> K_ESC
	WPar("tp",gTrPromjena)
  	WPar("pr",gnLMarg)
  	WPar("tb",gTabela)
  	Wpar("a4",gA43)
  	Wpar("rs",gnRedova)
  	Wpar("os",gOstr)
  	Wpar("po",gPostotak)
  	Wpar("k1",gDodKar1)
  	Wpar("k2",gDodKar2)
  	Wpar("fi",gNFirma)
  	Wpar("co",gCentOn)
  	select params
	use
endif

if gCentOn=="D"
	SET CENTURY ON
else
  	SET CENTURY OFF
endif

return


