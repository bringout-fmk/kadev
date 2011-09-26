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


function mnu_sif()
private izbor := 1
private opc := {}
private opcexe := {}

o_tables()

AADD(opc, "1. radna jedinica                       ")
AADD(opcexe, {|| p_rj() })
AADD(opc, "2. radno mjesto ")
AADD(opcexe, {|| p_rmj() })
AADD(opc, "3. zanimanje")
AADD(opcexe, {|| p_zanim() })
AADD(opc, "4. strucna sprema ")
AADD(opcexe, {|| p_strspr() })
AADD(opc, "5. promjene ")
AADD(opcexe, {|| p_promj() })
AADD(opc, "6. mjesna zajednica ")
AADD(opcexe, {|| p_mz() })
AADD(opc, "7. " + gDodKar1 )
AADD(opcexe, {|| p_k1() })
AADD(opc, "8. " + gDodKar2 )
AADD(opcexe, {|| p_k2() })
AADD(opc, "9. nacija ")
AADD(opcexe, {|| p_nac() })
AADD(opc, "A. ratni raspored ")
AADD(opcexe, {|| p_rrasp() })
AADD(opc, "B. cin ")
AADD(opcexe, {|| p_cin() })
AADD(opc, "C. " + if(glBezVoj, "poznavanje stranog jezika", "ves") )
AADD(opcexe, {|| p_ves() })
AADD(opc, "D. sistematizacija ")
AADD(opcexe, {|| p_rjrmj() })
AADD(opc, "E. stope benef.r.st ")
AADD(opcexe, {|| p_kbenrst() })
AADD(opc, "F. neradni dani ")
AADD(opcexe, {|| p_nerdan() })
AADD(opc, "--------------------------- ")
AADD(opcexe, {|| nil })
AADD(opc, "R. rjesenja ")
AADD(opcexe, {|| p_rjes() })

Menu_SC("sifrarnik")

return


