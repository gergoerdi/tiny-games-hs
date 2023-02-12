#!/usr/bin/env -S stack script --resolver lts-20 --package gloss
import Imports

main=do{getMonotonicTimeNSec>>= \s->play(InWindow "Vaders" (600,600) (0,0))
white 60(0,(s`mod`0x10000)+1,0,20,[],Nothing,0)render i step};y0= -28;
render (_,_,shipX,_,ms,b,z) = (translate (-300) (-250) (text(show z))<>)$scale
 10 10 $translate shipX y0 sh <>foldMap($q)(fmap (uncurry translate)b)<>foldMap
 ($v)(map (uncurry translate) ms)

sh=polygon[(-1,0),(0,2),(1,0)];v=line[(-1,2),(0,0),(1,2)];q=line[(0,0),(0,1)]

i(EventKey(SpecialKey k)Down _ _)(w,s,x,d,m,b,z)|k==KeyLeft=(w,s,x,-20,m,b,z)|k
 ==KeyRight=(w,s,x,20,m,b,z)|k`elem`[KeyCtrlL,KeyCtrlR]=(w,s,x,d,m,b<|>Just(x,y0)
 ,z);i _ s = s;n(a,b)(x,y)=all(<1)(map abs[a-x,b-y])


step t(w,s,a,d,m,b,z)=(w',s',a+t*d',d',m',b',z')where{s'=(s`div`2) `xor` if odd
 s then 0xd008 else 0;d'|a>30= -20|a< -30=20|True=d;(c,nc)|Just b<-b=partition(n
 b)m|True = ([], m);m1=map(\(x,y)->(x,y-t*10))nc;(w',m')|w>0=(w-t,m1)|True=(0.35,
 (fromIntegral(s`mod`80)-40,30):m1);b' = b>>= \(x,y)->guard (null c&&(y<30))*>pure
 (x,y+t*20);z'|any(n(a,y0))nc=0|True=z+length c}

-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/vaders (gergoerdi)


-}
