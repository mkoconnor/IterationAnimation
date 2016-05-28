module Main where

import Lib
import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine

example :: Diagram B
example = ((circle 2 # showEnvelope) ||| (pentagon 3 # showEnvelope)) # showOrigin
  
main :: IO ()
main = mainWith example
