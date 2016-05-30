{-# LANGUAGE NoMonomorphismRestriction #-}
module Main where

import Lib
import Diagrams.Prelude
import Diagrams.Backend.PGF
import Diagrams.Backend.PGF.CmdLine

stop :: [Char] -> Diagram B
stop s = (square 1 # lw none <> text s) === strutY 1 === circle 0.1 # fc black

finStops :: Diagram B
finStops = hsep 1 (map (\i -> stop (show i)) [1..5])

omegaStops :: Diagram B
omegaStops = hsep 1 [finStops, (square 1 # lw none <> text "$\\cdots$"), stop "$\\omega$"]

main :: IO ()
main = mainWith omegaStops
