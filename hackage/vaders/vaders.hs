#!/usr/bin/env -S stack script --compile --resolver lts-20 --package gloss
import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Interact
import GHC.Clock
import Data.Bits
import Control.Applicative
import Control.Monad(guard)
import Data.List(partition)

main = do
    seed <- getMonotonicTimeNSec
    play (InWindow "Vaders" (600, 600) (0, 0)) white 60
      (0,(seed`mod`0x10000)+1,0,20,[],Nothing,0)
      render input step

shipY = -28

scaleFactor = 10
render (_,_,shipX,_,ms,b,z) = (translate (-300) (-250) (text(show z))<>)$
  scale scaleFactor scaleFactor $
  translate shipX shipY ship <>
  foldMap($ bullet)(fmap (uncurry translate) b)<>
  foldMap($ vader)(map (uncurry translate) ms)

ship=polygon[(-1,0),(0,2),(1,0)];vader=line[(-1,2),(0,0),(1,2)];bullet=line[(0,0),(0,1)]

input(EventKey (SpecialKey k) Down _ _)(w,s,x,d,m,b,z)|k==KeyLeft = (w,s,x,-20,m,b,z)
  | k==KeyRight=(w,s,x,20,m,b,z)|k`elem`[KeyCtrlL,KeyCtrlR]=(w,s,x,d,m,b<|>Just(x,shipY),z)
input _ s = s


step dt (w, seed, shipX, dir, m,bullet,z) = (w', seed', shipX + dt * dir', dir', m',bullet',z')
  where
    seed' = (seed`div`2) `xor` if odd seed then 0xd008 else 0
    dir' | shipX > 30 = -20| shipX < -30 = 20| otherwise = dir
    (c,nc) | Just b<-bullet = partition (n b) m| True = ([], m)
    m1=map(\(x,y)->(x,y-dt*10))nc
    (w',m')|w>0=(w-dt,m1)|True=(0.35,(fromIntegral(seed `mod` 80) - 40, 30):m1)
    bullet' = bullet>>= \(x,y)->guard (null c&&(y<30))*>pure(x,y+dt*20)
    z'|any(n(shipX,shipY))nc = 0
      |True=z+length c

n (a,b) (x,y) = all(<1)(map abs[a-x,b-y])

-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/vaders (gergoerdi)


-}
