#include "\dev\fmk\kadev\kadev.ch"


// ----------------------------------------------
// radna karta
// ----------------------------------------------
function work_card()

O_K_1
O_K_0
O_RJRMJ
O_RJ
O_RMJ
O_ZANIM
O_STRSPR

#ifndef C50
select k_1  ; set order to tag "1"
select k_0  ; SET order to tag "4"
select rjrmj; set order to tag "ID"
#else
select k_1  ; set order to I_ID
select k_0  ; SET order to I_RJRMJ
select rjrmj; set order to I_ID
#endif

  SET CURSOR ON

  cOdRJ:=cDoRj:=SPACE(6)

  Box('RKar',7,40,.F.)
  @ m_x+1,m_y+2 SAY 'Od RJ:' GET cOdRJ  PICTURE '@!'
  READ
  IF LastKey()==K_ESC ; BoxC() ; RETURN ; ENDIF

  @ m_x+2,m_y+2 SAY 'Do RJ:' GET cDoRJ;
       PICTURE '@!' VALID cDoRj>=cOdRJ
  READ


  IF LastKey()==K_ESC ; BoxC() ; RETURN ; END IF


  //ImeDat=PADR("RK",8)
  //@ m_x+7,m_y+2 SAY 'Naziv datoteke:' GET ImeDat PICTURE '@! AAAAAAAA';
  //VALID !EMPTY(ImeDat)
  //READ

  BoxC()

  SET CURSOR OFF

  IF LastKey()==K_ESC ; RETURN ; END IF

 start print cret
 //set alternate to &ImeDat
 //SET alternate on
 //set console off

 ? "Pregled sistematizacije mjesta (radna karta) za RJ:",cOdRJ,"-",cDoRJ
 ? SPACE(50),"na Datum:",DATE()
 ? REPLICATE('=',80)
 ?

 SEEK cOdRJ
 crj:=IdRj
 nPopRJ:=0; nPopRJS:=0
 select rj; hseek crj; select rjrmj
 ? "****",crj,"****", rj->naz
 ? replicate('-',80)

 //Box('Cnt',1,10,.f.)
 nCnt:=0
 do while idRj <= cDoRJ .and. !eof()

  //@ m_x+1,m_y+2 SAY nCnt++

  cRmj:=IdRmj

  if BrIzvrs=0
    skip
    loop
  endif

  if cRJ<>IdRj
   if nPopRJS<>0
     ?
     ? '************ Popunjeno:',str(nPopRJ/nPopRJS*100,6,2),'% ************'
     ?
     ?
   endif

     cRj:=IdRJ
     nPopRJ:=nPopRJS:=0
     ?
     select rj; hseek crj; select rjrmj
     ? "****",cRj,"****", rj->naz
     ? replicate('-',80)
     ?
  endif

  ? REPLICATE("-",78)
  if prow()>62; FF; endif
  select rmj; hseek cRmj
  select strspr; hseek rjrmj->idStrSprod
  select rjrmj
  ?  cRMJ,'-',rmj->naz,' Po sist.izvrsilaca:',BrIzvrs,SPACE(2),"K:"+Idk1+";"+Idk2+";"+Idk3+";"+Idk4
  ?  SPACE(6),"Opis:",Opis
  ?  SPACE(6),"S.Spr:",IdStrSprOd,"-",strspr->naz
  select zanim; hseek rjrmj->idzanim1; select rjrmj
  ?  SPACE(6),"Vrsta:",Idzanim1,"-",zanim->naz
  if !empty(Idzanim2)
   select zanim; hseek rjrmj->idzanim2; select rjrmj
   ?  SPACE(6),Idzanim2,"-",zanim->naz
  endif
  if !empty(Idzanim3)
   select zanim; hseek rjrmj->idzanim3; select rjrmj
   ?  SPACE(6),Idzanim3,"-",zanim->naz
  endif
  if !empty(Idzanim4)
   select zanim; hseek rjrmj->idzanim4; select rjrmj
   ?  SPACE(6),Idzanim4,"-",zanim->naz
  endif
  ? REPLICATE("-",78)

          nPopRJS+=BrIzvrs

          select k_0
          seek rjrmj->(IdRJ+IdRMJ)
          nPopunjeno:=0
          do while rjrmj->(IdRJ+IdRMJ)=IdRJ+IdRMJ
            if (Status == 'X') // van firme
              skip
              loop
            endif
            ? str(++nPopunjeno,5)+'.',trim(prezime)+" ("+trim(ImeRod)+") "+trim(ime)
            select strspr; hseek k_0->idStrspr; select k_0
            ? space(6),IdStrSpr,"-",strspr->naz
            select zanim; hseek k_0->idzanim; select k_0
            ? space(6),IdZanim,"-",zanim->naz,SPACE(7),"__________"
            ++nPopRJ
                  ////////// postavljenja radnog staza
                  select k_1
                  seek k_0->id
                  fProsao:=.f.
                  do while k_0->id = k_1->id
                   if k_1->IdPromj $ "R1#R2"  // Postavljenje, dodavanje rad.st staza
                    if !fProsao
                      ? SPACE(5),"-Radni staz-"
                      fProsao:=.t.
                    endif
                    aRE:=GMJD(nAtr1)
                    ?  SPACE(7),DatumOd,Dokument,Opis,str(aRe[1],2)+"g.",str(aRe[2],2)+"mj.",str(aRe[3],2)+"d."
                   endif
                   skip
                  enddo
                  select k_0
                  /////////////////////
                  ////////// strucni ispit
                  select k_1
                  seek k_0->id
                  fProsao:=.f.
                  do while k_0->id = k_1->id
                   if k_1->IdPromj=="S2"  // S2 - stru~ni ispit
                    if !fProsao
                      ? SPACE(5),"-Strucni ispit-"
                      fProsao:=.t.
                    endif
                    ?  SPACE(7),DatumOd,Dokument,Opis
                   endif
                   skip
                  enddo
                  select k_0
                  /////////////////////
            skip
          enddo
          select rjrmj
          for i:=nPopunjeno+1 to BrIzvrs
           ? str(i,6)+'.',REPLICATE('_',30)
           ? SPACE(7),REPLICATE('_',50)
           ? SPACE(7),REPLICATE('_',50),space(4),"__________"
          next
 skip

 enddo

 if nPopRJS<>0
     ?
     ? '************ Popunjeno:',str(nPopRJ/nPopRJS*100,6,2),'% ************'
     ?
     ?
 endif

 end print


close all

return


