#include "\dev\fmk\kadev\kadev.ch"

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



