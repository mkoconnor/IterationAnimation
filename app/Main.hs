{-# LANGUAGE NoMonomorphismRestriction #-}
module Main where

import Lib
import Diagrams.Prelude
import Diagrams.Backend.PGF
import Diagrams.Backend.PGF.CmdLine

example :: Diagram B
example = mconcat $ map circle [1..10]

main :: IO ()
main = mainWith (example ||| (text "$\\alpha$ and $\\omega$" <> (square 5)))
