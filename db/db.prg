#include "\dev\fmk\kadev\kadev.ch"
 

function TDbKadevNew()
local oObj
oObj:=TDbKadev():new()
oObj:self:=oObj
oObj:cName:="KADEV"
oObj:lAdmin:=.f.
return oObj


#ifdef CPP
class TDbKadev: public TDB 
{
     public:
     	TObject self;
	string cName;
	*void dummy();
	*void skloniSezonu(string cSezona, bool finverse, bool fda, bool fnulirati, bool fRS);
	*void install(string cKorisn,string cSifra,variant p3,variant p4,variant p5,variant p6,variant p7);
	*void setgaDBFs();
	*void obaza(int i);
	*void ostalef();
	*void kreiraj(int nArea);
}
#endif

#ifndef CPP
#include "class(y).ch"
CREATE CLASS TDbKadev INHERIT TDB

	EXPORTED:
	var    self
	var    cName
	method skloniSezonu
	method install	
	method setgaDBFs	
	method ostalef	
	method obaza	
	method kreiraj	
	method konvZn

END CLASS
#endif


method dummy
return


method setgaDBFs()

public gaDbfs := {;
{ F_K_0     , "K_0"        , P_KUMPATH },;
{ F_K_1     , "K_1"        , P_KUMPATH  },;
{ F_PROMJ   , "PROMJ"      , P_SIFPATH  },;
{ F_RJ      , "RJ"         , P_SIFPATH  },;
{ F_RMJ     , "RMJ"        , P_SIFPATH  },;
{ F_RJRMJ   , "RJRMJ"      , P_SIFPATH  },;
{ F_STRSPR  , "STRSPR"     , P_SIFPATH  },;
{ F_MZ      , "MZ"         , P_SIFPATH  },;
{ F_NERDAN  , "NERDAN"     , P_SIFPATH  },;
{ F_K1      , "K1"         , P_SIFPATH  },;
{ F_K2      , "K2"         , P_SIFPATH  },;
{ F_ZANIM   , "ZANIM"      , P_SIFPATH  },;
{ F_RRASP   , "RRASP"      , P_SIFPATH  },;
{ F_CIN     , "CIN"        , P_SIFPATH  },;
{ F_VES     , "VES"        , P_SIFPATH  },;
{ F_NAC     , "NAC"        , P_SIFPATH  },;
{ F_KBENRST , "KBENRST"    , P_SIFPATH  },;
{ F_GLOBUSL , "GLOBUSL"    , P_KUMPATH  },;
{ F_OBRAZDEF, "OBRAZDEF"   , P_KUMPATH  },;
{ F_USLOVI  , "USLOVI"     , P_KUMPATH  },;
{ F_RJES    , "RJES"       , P_SIFPATH  },;
{ F_DEFRJES , "DEFRJES"    , P_SIFPATH  };
}

return


method install(cKorisn,cSifra,p3,p4,p5,p6,p7)
	ISC_START(goModul,.f.)
return



method kreiraj(nArea)

if (nArea==nil)
	nArea:=-1
endif

if (nArea<>-1)
	CreSystemDb(nArea)
endif

CreFMKSvi()

if (nArea == -1 .or. nArea == (F_K_0))

  if !FILE(KUMPATH+"K_0.DBF")
	aDbf:={} 
	AADD(aDbf, {"id", "C", 13, 0} )
        AADD(aDbf, {"id2","C",11,0} )
	AADD(aDbf, {"Prezime","C",20,0} )
  	AADD(aDbf, {"ImeRod","C",15,0} )
  	AADD(aDbf, {"Ime",    "C",15,0} )
  	AADD(aDbf, {"Pol",    "C",1,0} )
  	AADD(aDbf, {"IdNac",  "C",2,0} )
 	AADD(aDbf, {"DatRodj","D",8,0} )
  	AADD(aDbf, {"MjRodj","C",30,0} )
  	AADD(aDbf, {"IdStrSpr","C",3,0} )
 	AADD(aDbf, {"IdZanim","C",4,0} )
  	AADD(aDbf, {"IdRJ","C",6,0} )
  	AADD(aDbf, {"IdRMJ","C",4,0} )
  	AADD(aDbf, {"DatURMJ","D",8,0} )
  	AADD(aDbf, {"DatUF","D",8,0} )
  	AADD(aDbf, {"DatVRMJ","D",8,0} )
  	AADD(aDbf, {"RadStE","N",11,2} )
  	AADD(aDbf, {"RadStB","N",11,2} )
  	AADD(aDbf, {"BrLK","C",12,0} )
 	AADD(aDbf, {"MjSt","C",25,0} )
  	AADD(aDbf, {"Ulst","C",30,0} )
 	AADD(aDbf, {"IdMZSt","C",4,0} )
 	AADD(aDbf, {"BrTel1","C",10,0} )
 	AADD(aDbf, {"BrTel2","C",10,0} )
  	AADD(aDbf, {"BrTel3","C",10,0} )
  	AADD(aDbf, {"Status","C",1,0} )
	AADD(aDbf, {"BracSt","C",1,0} )
 	AADD(aDbf, {"BrDjece","N",2,0} )
 	AADD(aDbf, {"Krv","C",3,0} )
 	AADD(aDbf, {"Stan","C",1,0} )
 	AADD(aDbf, {"IdK1","C",2,0} )
 	AADD(aDbf, {"IdK2","C",4,0} )
 	AADD(aDbf, {"KOp1","C",30,0} )
 	AADD(aDbf, {"KOp2","C",30,0} )
 	AADD(aDbf, {"IdRRasp","C",4,0} )
 	AADD(aDbf, {"SlVr","C",1,0} )
  	// sluzio vojni rok - D/N
	AADD(aDbf, {"VrSlVr","N",11,2} )
  	// vrijeme sluzenja vojnog roka
 	AADD(aDbf, {"SposVSl","C",1,0} )
  	// sposoban za vojnu sluzbu D,N,O
 	AADD(aDbf, {"IDVes","C",7,0} )
  	// ID VES-a
  	AADD(aDbf, {"IDCin","C",2,0} )
  	// ID Cin-a
	AADD(aDbf, {"NazSekr","C",20,0} )
	AADD(aDbf, {"Operater","C",10,0} )
  	AADD(aDbf, {"Date","D",8,0}  )
 	AADD(aDbf, {"Time","C",8,0} )

        DBCREATE2(KUMPATH+"K_0", aDbf)
  endif
endif

CREATE_INDEX("1" , "id"               , KUMPATH+"k_0")
CREATE_INDEX("2" , "btoe(prezime+ime)", KUMPATH+"k_0")
CREATE_INDEX("3" , "id2"              , KUMPATH+"k_0")
CREATE_INDEX("4" , "idrj+idrmj"       , KUMPATH+"k_0")

if (nArea == -1 .or. nArea == (F_K_1))
  if !FILE(KUMPATH + "K_1.DBF")
	aDbf:={ {"ID","C",13,0} ,;
                  {"DatumOd","D",8,0} ,;
                  {"DatumDo","D",8,0} ,;
                  {"IdPromj","C",2,0} ,;
                  {"IdK","C",4,0} ,;
                  {"Dokument","C",15,0} ,;
                  {"Opis","C",30,0} ,;
                  {"Nadlezan","C",20,0} ,;
                  {"IdRJ","C",6,0}     , ;
                  {"IdRMJ","C",4,0} ,;
                  {"nAtr1","N",11,2} ,;
                  {"nAtr2","N",11,2} ,;
                  {"cAtr1","C",10,0} ,;
                  {"cAtr2","C",10,0} ;
                }
        DBCREATE2(KUMPATH + "K_1", aDbf)
  endif
endif

CREATE_INDEX("1" , "id+dtos(datumOd)" , KUMPATH+"k_1")
CREATE_INDEX("2" , "dtos(datumOd)"    , KUMPATH+"k_1")
CREATE_INDEX("3" , "id+idpromj"       , KUMPATH+"k_1")


if (nArea == -1 .or. nArea == (F_PROMJ))

  if !file(SIFPATH + "PROMJ.DBF")
	
	aDbf:={ {"ID","C",2,0} ,;
                  {"Naz","C",20,0} ,;
                  {"Naz2","C",6,0} ,;
                  {"Tip","C",1,0}  ,;
                  {"Status","C",1,0} ,;
                  {"URadst","C",1,0} ,; 
                  {"SRMJ","C",1,0} ,; 
                  {"URRasp","C",1,0}, ; 
                  {"UStrSpr","C",1,0} ; 
                }
          DBCREATE2(SIFPATH+"promj",aDbf)
   endif

endif

CREATE_INDEX("id", "id", SIFPATH+"promj")
CREATE_INDEX("naz", "naz", SIFPATH+"promj")

if (nArea == -1 .or. nArea == (F_MZ))
  
  if !file( SIFPATH + "MZ.DBF" )

	aDbf:={ {"ID","C",4,0} ,;
                  {"Naz","C",20,0} ,;
                  {"Naz2","C",6,0} ;
                }
        DBCREATE2(SIFPATH + "MZ", aDbf)
  endif

endif

CREATE_INDEX("id", "id", SIFPATH+"mz")
CREATE_INDEX("naz", "naz", SIFPATH+"mz")

if (nArea == -1 .or. nArea == (F_NERDAN))

  if !file(SIFPATH+"NERDAN.DBF")
	
	aDbf:={ {"ID","C",4,0} ,;
                  {"Naz","C",20,0} ,;
                  {"Datum","D",8,0} ;
                }
        DBCREATE2( SIFPATH + "NERDAN", aDbf )
  endif

endif

CREATE_INDEX("id", "id", SIFPATH+"nerdan")
CREATE_INDEX("naz", "naz", SIFPATH+"nerdan")
CREATE_INDEX("dat", "datum", SIFPATH+"nerdan")


if (nArea == -1 .or. nArea == (F_RJ))

  if !file(SIFPATH+"RJ.dbf")

	aDbf:={ {"id","C",6,0} ,;
                  {"naz","C",50,0} ,;
                  {"naz2","C",6,0} ;
              }
        DBCREATE2(SIFPATH + "RJ", aDbf)

  endif

endif
CREATE_INDEX("id", "id", SIFPATH+"rj")
CREATE_INDEX("naz", "naz", SIFPATH+"rj")

if (nArea == -1 .or. nArea == (F_RMJ))
       
  if !file(SIFPATH+"RMJ.dbf")
   	 
	aDbf:={ {"id","C",4,0} ,;
                  {"naz","C",40,0} ,;
                  {"naz2","C",6,0} ;
                }
        DBCREATE2( SIFPATH + "RMJ", aDbf)
  endif

endif
CREATE_INDEX("id", "id", SIFPATH+"rmj")
CREATE_INDEX("naz", "naz", SIFPATH+"rmj")

if (nArea == -1 .or. nArea == (F_RJRMJ))

  if !file(SIFPATH+"RJRMJ.dbf")

	aDbf:={ {"IdRJ","C",6,0} ,;
                  {"IdRMJ","C",4,0} ,;
                  {"BrIzvrs","N",2,0} ,;
                  {"IdStrSprOd","C",3,0} ,;
                  {"IdStrSprDo","C",3,0} ,;
                  {"IdZanim1","C",4,0} ,;
                  {"IdZanim2","C",4,0} ,;
                  {"IdZanim3","C",4,0} ,;
                  {"IdZanim4","C",4,0} ,;
                  {"Bodova","N",7,2} ,;
                  {"SBenefRSt","C",1,0} ,;
                  {"IdK1","C",1,0}, ; 
                  {"IdK2","C",1,0}, ; 
                  {"IdK3","C",1,0}, ; 
                  {"IdK4","C",1,0}, ;
                  {"Opis","C",30,0} ;
                }
        DBCREATE2(SIFPATH+"RJRMJ",aDbf)
  endif

endif
CREATE_INDEX("id", "IDRJ+IDRMJ", SIFPATH+"rjrmj")


if (nArea == -1 .or. nArea == (F_STRSPR))
        if !file(SIFPATH+"StrSpr.dbf")
          aDbf:={ {"id","C",3,0} ,;
                  {"naz","C",20,0} ,;
                  {"naz2","C",6,0} ;
                }
          DBCREATE2(SIFPATH+"StrSpr",aDbf)
        endif
endif
CREATE_INDEX("id", "id", SIFPATH+"strspr")
CREATE_INDEX("naz", "naz", SIFPATH+"strspr")


if (nArea == -1 .or. nArea == (F_K1))
        if !file(SIFPATH+"K1.dbf")
          aDbf:={ {"id","C",2,0} ,;
                  {"naz","C",20,0} ,;
                  {"naz2","C",6,0} ;
                }
          DBCREATE2(SIFPATH+"K1",aDbf)
        endif
endif
CREATE_INDEX("id", "id", SIFPATH+"k1")
CREATE_INDEX("naz", "naz", SIFPATH+"k1")


if (nArea == -1 .or. nArea == (F_K2))

        if !file(SIFPATH+"K2.dbf")
          aDbf:={ {"id","C",4,0} ,;
                  {"naz","C",30,0} ,;
                  {"naz2","C",6,0} ;
                }
          DBCREATE2(SIFPATH+"K2",aDbf)
        endif
endif
CREATE_INDEX("id", "id", SIFPATH+"k2")
CREATE_INDEX("naz", "naz", SIFPATH+"k2")


if (nArea == -1 .or. nArea == (F_ZANIM))
        if !file(SIFPATH+"zanim.dbf")
          aDbf:={ {"id","C",4,0} ,;
                  {"naz","C",40,0} ,;
                  {"naz2","C",6,0} ;
                }
          DBCREATE2(SIFPATH+"zanim",aDbf)
        endif
endif
CREATE_INDEX("id", "id", SIFPATH+"zanim")
CREATE_INDEX("naz", "naz", SIFPATH+"zanim")


if (nArea == -1 .or. nArea == (F_RRASP))
        if !file(SIFPATH+"RRasp.dbf")
          aDbf:={ {"id","C",4,0} ,;
                  {"naz","C",30,0} ,;
                  {"naz2","C",6,0} ,;
                  {"cAtr","C",1,0} ;
                }
          DBCREATE2(SIFPATH+"RRasp",aDbf)
        endif
endif
CREATE_INDEX("id", "id", SIFPATH+"rrasp")
CREATE_INDEX("naz", "naz", SIFPATH+"rrasp")


if (nArea == -1 .or. nArea == (F_VES))
        if !file(SIFPATH+"VES.dbf")
          aDbf:={ {"id","C",7,0} ,;
                  {"naz","C",40,0} ,;
                  {"naz2","C",6,0} ;
                }
          DBCREATE2(SIFPATH+"VES",aDbf)
        endif
endif
CREATE_INDEX("id", "id", SIFPATH+"ves")
CREATE_INDEX("naz", "naz", SIFPATH+"ves")


if (nArea == -1 .or. nArea == (F_CIN))
        if !file(SIFPATH+"CIN.DBF")
          aDbf:={ {"id","C",2,0} ,;
                  {"naz","C",20,0} ,;
                  {"naz2","C",6,0} ;
                }
          DBCREATE2(SIFPATH+"CIN",aDbf)
        endif
endif
CREATE_INDEX("id", "id", SIFPATH+"cin")
CREATE_INDEX("naz", "naz", SIFPATH+"cin")


if (nArea == -1 .or. nArea == (F_NAC))
        if !file(SIFPATH+"NAC.DBF")
          aDbf:={ {"id","C",2,0} ,;
                  {"naz","C",20,0} ,;
                  {"naz2","C",6,0} ;
                }
          DBCREATE2(SIFPATH+"NAC",aDbf)
        endif
endif
CREATE_INDEX("id", "id", SIFPATH+"nac")
CREATE_INDEX("naz", "naz", SIFPATH+"nac")


if (nArea == -1 .or. nArea == (F_KBENRST))
        if !file(SIFPATH+"KBENRST.DBF")
          aDbf:={ {"id","C",1,0} ,;
                  {"vrijednost","N",5,2} ;
                }
          DBCREATE2(SIFPATH+"KBENRST",aDbf)
        endif
endif
CREATE_INDEX("id", "id", SIFPATH+"kbenrst")


if (nArea == -1 .or. nArea == (F_OBRAZDEF))

   if !file(KUMPATH+"OBRAZDEF.DBF")
     MsgO("Kreira se datoteka ObrazDef")
     aDbf:={}
     AADD(aDbf,{"Tip","C",1,0})
     AADD(aDbf,{"Grupa","C",1,0})
     AADD(aDbf,{"Red_Br","C",1,0})
     AADD(aDbf,{"id_uslova","C",8,0})
     AADD(aDbf,{"Komentar","C",25,0})
     AADD(aDbf,{"Uslov","C",200,0})
     DBCREATE2(KUMPATH+"obrazdef",aDbf)
     MsgC()
   endif
endif
CREATE_INDEX("1" , "tip+grupa+red_br", KUMPATH+"obrazdef")


if (nArea == -1 .or. nArea == (F_GLOBUSL))

   if !file(KUMPATH+'globusl.dbf')
     aDBF:={}
     AADD(aDbf,{"KOMENTAR","C",25,0})
     AADD(aDbf,{"USLOV","C",200,0})
     AADD(aDbf,{"IME_BAZE","C",10,0})
     DBCREATE2(KUMPATH+"GLOBUSL",aDbf)
   endif

endif
CREATE_INDEX("1" , "Komentar", KUMPATH+"GlobUsl")


if (nArea == -1 .or. nArea == (F_USLOVI))
  
  if !file(KUMPATH+'uslovi.dbf')
     aDBF:={}
     AADD(aDbf,{"ID"        , "C",   8, 0})
     AADD(aDbf,{"NAZ"       , "C",  25, 0})
     AADD(aDbf,{"USLOV"     , "C", 200, 0})
     DBCREATE2(KUMPATH+"USLOVI",aDbf)
   endif

endif
CREATE_INDEX("1" , "id", KUMPATH+"uslovi")
CREATE_INDEX("2" , "naz", KUMPATH+"uslovi")

if !file(SIFPATH+"RJES.DBF")
   aDbf:={ { "id"       , "C" ,  2 , 0 } ,;
           { "naz"      , "C" , 40 , 0 } ,;
           { "fajl"     , "C" , 12 , 0 } ,;
           { "zadbrdok" , "C" , 20 , 0 } ,;
           { "idpromj"  , "C" ,  2 , 0 } ;
         }
   DBCREATE2(SIFPATH+"RJES",aDbf)
endif
CREATE_INDEX("id" , "id" , SIFPATH+"RJES")
CREATE_INDEX("naz" , "naz" , SIFPATH+"RJES")


if !file(SIFPATH+"DEFRJES.DBF")
   aDbf:={ { "id"       , "C" ,   2 , 0 } ,;
           { "idrjes"   , "C" ,   2 , 0 } ,;
           { "izraz"    , "C" , 200 , 0 } ,;
           { "obrada"   , "C" ,   1 , 0 } ,;
           { "upit"     , "C" ,  20 , 0 } ,;
           { "uvalid"   , "C" , 100 , 0 } ,;
           { "upict"    , "C" ,  20 , 0 } ,;
           { "iizraz"   , "C" , 200 , 0 } ,;
           { "tipslova" , "C" ,   5 , 0 } ,;
           { "ppromj"   , "C" ,  10 , 0 } ,;
           { "ipromj"   , "C" ,   1 , 0 } ,;
           { "priun"    , "C" ,   1 , 0 } ;
         }
   DBCREATE2(SIFPATH+"DEFRJES",aDbf)
endif
CREATE_INDEX("1"  , "idrjes+id"           , SIFPATH+"DEFRJES")
CREATE_INDEX("2"  , "idrjes+ipromj+id"    , SIFPATH+"DEFRJES")
CREATE_INDEX("3"  , "idrjes+priun+id"     , SIFPATH+"DEFRJES")


return



method obaza(i)

local lIdIDalje
local cDbfName

lIdiDalje:=.f.

if i==F_PARAMS 
	lIdiDalje:=.t.
endif

if i==F_K_0 .or. ;
   i==F_K_1 .or. ;
   i==F_PROMJ .or. ;
   i==F_RJ .or. ;
   i==F_RMJ .or. ;
   i==F_RJRMJ .or. ;
   i==F_STRSPR .or. ;
   i==F_MZ .or. ;
   i==F_NERDAN .or. ;
   i==F_K1 .or. ;
   i==F_K2 .or. ;
   i==F_ZANIM .or. ;
   i==F_RRASP .or. ;
   i==F_CIN .or. ;
   i==F_VES .or. ;
   i==F_NAC .or. ;
   i==F_KBENRST .or. ;
   i==F_GLOBUSL .or. ;
   i==F_OBRAZDEF .or. ;
   i==F_USLOVI .or. ;
   i==F_RJES .or. ;
   i==F_DEFRJES
	
	lIdiDalje := .t.

endif

if lIdiDalje
	cDbfName:=DBFName(i,.t.)
	select(i)
	usex(cDbfName)
else
	use
	return
endif


return



method ostalef()
return



method konvZn() 
local cIz:="7"
local cU:="8"
local aPriv:={}
local aKum:={}
local aSif:={}
local GetList:={}
local cSif:="D"
local cKum:="D"
local cPriv:="D"

if !SigmaSif("KZ      ")
	return
endif

Box(,8,50)
	@ m_x+2, m_y+2 SAY "Trenutni standard (7/8)        " GET cIz   VALID   cIz$"78"  PICT "9"
  	@ m_x+3, m_y+2 SAY "Konvertovati u standard (7/8/A)" GET cU    VALID    cU$"78A" PICT "@!"
  	@ m_x+5, m_y+2 SAY "Konvertovati sifrarnike (D/N)  " GET cSif  VALID  cSif$"DN"  PICT "@!"
  	@ m_x+6, m_y+2 SAY "Konvertovati radne baze (D/N)  " GET cKum  VALID  cKum$"DN"  PICT "@!"
  	@ m_x+7, m_y+2 SAY "Konvertovati priv.baze  (D/N)  " GET cPriv VALID cPriv$"DN"  PICT "@!"
  	read
  	if LastKey()==K_ESC
		BoxC()
		return
	endif
  	if Pitanje(,"Jeste li sigurni da zelite izvrsiti konverziju (D/N)","N")=="N"
    		BoxC()
		return
  	endif
BoxC()

aPriv:= { }
aKum:= { F_K_0, F_K_1, F_USLOVI, F_GLOBUSL, F_OBRAZDEF }
aSif:={ F_PROMJ, F_MZ, F_NERDAN, F_RMJ, F_RJRMJ, F_STRSPR, F_K1, F_K2, F_ZANIM, F_RRASP, F_VES, F_CIN, ;
	F_NAC, F_KBENRST, F_RJES, F_DEFRJES, F_RJ }

if cSif=="N"
	aSif:={}
endif

if cKum=="N"
	aKum:={}
endif

if cPriv=="N"
	aPriv:={}
endif

KZNbaza(aPriv, aKum, aSif, cIz, cU)

return


method skloniSezonu(cSezona, fInverse, fDa, fNulirati, fRS)
save screen to cScr

if (fDa == nil)
	fDA := .f.
endif

if (finverse == nil)
	fInverse := .f.
endif

if (fNulirati == nil)
	fNulirati := .f.
endif

cls

// kumulativ
Skloni(KUMPATH, "K_0.DBF", cSezona,finverse,fda,fnul)
Skloni(KUMPATH, "K_1.DBF", cSezona,finverse,fda,fnul)
Skloni(KUMPATH, "USLOVI.DBF", cSezona,finverse,fda,fnul)
Skloni(KUMPATH, "GLOBUSL.DBF", cSezona,finverse,fda,fnul)
Skloni(KUMPATH, "OBRAZDEF.DBF", cSezona,finverse,fda,fnul)

// sifrarnici
Skloni(SIFPATH,"PROMJ.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"MZ.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"K1.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"K2.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"K1.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"NERDAN.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"RMJ.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"RJRMJ.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"STRSPR.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"ZANIM.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"RRASP.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"CIN.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"VES.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"NAC.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"KBENRST.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"RJES.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"DEFRJES.DBF",cSezona,finverse,fda,fnul)
Skloni(SIFPATH,"RJ.DBF",cSezona,finverse,fda,fnul)

?
?
?

Beep(4)

? "pritisni nesto za nastavak.."

restore screen from cScr

return



