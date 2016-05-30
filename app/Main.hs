{-# LANGUAGE NoMonomorphismRestriction #-}
module Main where

import Lib
import Diagrams.Prelude
import Diagrams.Backend.PGF
import Diagrams.Backend.PGF.CmdLine

-- The Double is the width of the text
stop :: [Char] -> Double -> Diagram B
stop s w = ((rect w 1 # lw none <> text s) === strutY 1 === circle 0.1 # fc black) # center

finStops :: Diagram B
finStops = hsep 1 (map (\i -> stop (show i) 3) [1..5])

cdots :: Diagram B
cdots = square 1 # lw none <> text "$\\cdots$"
-- cdots = ((stop "" 3 # center # lw none <> text "$\\cdots$") # center) # showOrigin
-- cdots = (invisibleStop <> (square 1 # lw none <> text "$\\cdots$")) # centerY
--   where invisibleStop = stop "" 3 # 

omegaStops :: Diagram B
omegaStops = hsep 1 [finStops, cdots, stop "$\\omega$" 3]

omega1Stops :: Diagram B
omega1Stops = hsep 1 [omegaStops, stop "$\\omega + 1$" 4, stop "$\\omega + 2$" 4,
                      cdots, stop "$\\omega\\cdot 2$" 4, stop "$\\omega \\cdot 2 + 1$" 5,
                      cdots, stop "$\\omega_1$" 4]

train :: IO (Diagram B)
train = do
  res <- loadImageExt "/users/michaeloconnor/Downloads/F7A-Diesel.png"
  return $ case res of
             Right x -> image x
             Left e -> error e

main :: IO ()
main = do
  train <- train
  mainWith $ omega1Stops -- === train
