/* 
 * This file is part of the bring.out FMK, a free and open source 
 * accounting software suite,
 * Copyright (c) 1996-2011 by bring.out doo Sarajevo.
 * It is licensed to you under the Common Public Attribution License
 * version 1.0, the full text of which (including FMK specific Exhibits)
 * is available in the file LICENSE_CPAL_bring.out_FMK.md located at the 
 * root directory of this source code archive.
 * By using this software, you agree to be bound by its terms.
 */


#include "kadev.ch"

#ifndef CPP
EXTERNAL RIGHT,LEFT
//EXTERNAL BTOE
//EXTERNAL OSVAL
//EXTERNAL GS
//EXTERNAL DC
//EXTERNAL ZadDanGO
//EXTERNAL DatVrGO
//EXTERNAL MLOWER
//EXTERNAL MUPPER
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


