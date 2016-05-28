module Main where

import Lib
import Diagrams.Prelude
-- import Diagrams.Backend.SVG (loadImageSVG)
import Diagrams.Backend.SVG.CmdLine

-- example :: Diagram B
-- example = unitSquare # fc blue ||| strut (1/4) ||| circle (1/2) # fc yellow
-- 
-- example :: Diagram B

dollar = do
   result <- loadImageEmb "/Users/michaeloconnor/Downloads/banknote.png"
   return $ case result of
     Left err -> error err
     Right x -> image x

-- dollar = loadImageSVG "/Users/michaeloconnor/Downloads/banknote.svg"

example :: Double -> Diagram B -> Diagram B
example i acc =
  if i <= 0
     then acc
     else example (i - 1) (circle (2 * i) # fcA (withOpacity red (1/(i+1))) ||| acc)

example1 :: IO (Diagram B)
example1 = do
   banknote <- dollar
   return $ example 5 (banknote :: Diagram B)


example2 :: Diagram B
example2 = regPoly 7 4 # lc blue # fc yellow

spiderWeb :: Diagram B
spiderWeb = mconcat (map (regPoly 7) [1..5])

main :: IO ()
main = mainWith example1
