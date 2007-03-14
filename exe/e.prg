#include "\dev\fmk\kadev\kadev.ch"

#ifndef CPP
EXTERNAL RIGHT,LEFT
#endif

#ifdef LIB

function Main(cKorisn,cSifra,p3,p4,p5,p6,p7)
	MainKadev(cKorisn,cSifra,p3,p4,p5,p6,p7)
return

#endif


function MainKadev(cKorisn,cSifra,p3,p4,p5,p6,p7)
*{
local oKadev

oKadev:=TKadevModNew()
cModul:="KADEV"

PUBLIC goModul

goModul:=oKadev
oKadev:init(NIL, cModul, D_KADEV_VERZIJA, D_KADEV_PERIOD , cKorisn, cSifra, p3,p4,p5,p6,p7)

oKadev:run()

return 


