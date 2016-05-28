{-# LANGUAGE NoMonomorphismRestriction #-}
module Main where

import Lib
import Diagrams.Prelude
-- import Diagrams.Backend.SVG
import Diagrams.Backend.Rasterific.CmdLine

handmadeDollar :: Diagram B
handmadeDollar =
  (text "$" <> square 1.5 # fc green # lc black # lwL 0.03) # scaleX 7 # scaleY 3

example :: Double -> Diagram B -> Diagram B
example i acc =
  if i <= 0
     then acc
     else example (i - 1) (circle (2 * i) # fcA (withOpacity red (1/(i+1))) ||| acc)

example2 :: Diagram B
example2 = regPoly 7 4 # lc blue # fc yellow

spiderWeb :: Diagram B
spiderWeb = mconcat (map (regPoly 7) [1..5])

to_3_char_string i =
  reverse (take 3 (reverse (show i) <> repeat '0'))

main :: IO ()
main = gifMain $ map (\i -> (handmadeDollar # rotateBy (fromIntegral i / 60), 1)) [0..120]
