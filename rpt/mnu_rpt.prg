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

function mnu_rpt()
private opc := {}
private opcexe := {}
private izbor := 2

AADD(opc, STRKZN("1. pregled godi�njih odmora             ", "8", gKodnaS ) )
AADD(opcexe, {|| gododmori() })
AADD(opc, STRKZN("2. pregled sta�a u firmi", "8", gKodnaS ) )
AADD(opcexe, {|| stazufirmi() })

Menu_SC("izvjestaji")
return



