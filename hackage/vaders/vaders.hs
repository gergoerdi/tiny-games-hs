#!/usr/bin/env -S stack script --resolver lts-20 --package gloss
import Imports;tr=translate;o=True;d f=foldMap(\(x,y)->tr x y f);main=do{
 getMonotonicTimeNSec>>= \s->play(InWindow "Vaders"(600,600)(0,0))white 60((0,(s
 .&.255)+1,[],0),0,20,mzero)r i st};y0= -28;r((_,_,m,z),x,_,b)=text(show z)<>(
 scale 10 10$tr x y0 sh<>d q b<>d v m);sh=circle 1;v=line[(-1,2),(0,0),(1,2)];
q=line[(0,0),(0,1)];i(EventKey(Char k)Down _ _)(s,x,d,b)|k=='a'=(s,x,-20,b)|
 k=='d'=(s,x,20,b)|k=='w'=(s,x,d,b<|>Just(x,y0));i _ s=s;n(a,b)(x,y)=all(<1)(map
 abs[a-x,b-y]);st t((w,s,m,z),a,d,b)=((v,p,l,q),a+t*e,e,u)where{p=(s`div`2)`xor`
 if odd s then 180 else 0;e|a>30= -20|a< -30=20|o=d;(c,nc)|Just b<-b=partition(n
 b)m|o=([], m);m1=map(\(x,y)->(x,y-t*10))nc;(v,l)|w>0=(w-t,m1)|o=(0.35,(
 fromIntegral(s`mod`80)-40,30):m1);u=b>>= \(x,y)->(x,y+t*20)<$guard(null c&&(y<30)
 );q|any(n(a,y0))nc=0|o=z+length c}

-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/vaders (gergoerdi)


-}
