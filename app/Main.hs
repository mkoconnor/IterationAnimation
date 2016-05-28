{-# LANGUAGE NoMonomorphismRestriction #-}
module Main where

import Lib
import Diagrams.Prelude
import Diagrams.Backend.SVG
import Diagrams.Backend.SVG.CmdLine

-- example :: Diagram B
-- example = unitSquare # fc blue ||| strut (1/4) ||| circle (1/2) # fc yellow
--
-- example :: Diagram B

dollar :: IO (Diagram B)
dollar = do
   result <- loadImageEmb "/Users/michaeloconnor/Downloads/100-dollar-bill.png"
   return $ case result of
     Left err -> error err
     Right x -> image x # scale 0.05 # rotate (45 @@ deg)

-- dollar = loadImageSVG "/Users/michaeloconnor/Downloads/banknote.svg"

handmadeDollar :: Diagram B
handmadeDollar =
  (text "$" <> square 1.5 # fc green) # scaleX 7 # scaleY 3

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

to_3_char_string i =
  reverse (take 3 (reverse (show i) <> repeat '0'))

renderThis i handmadeDollar =
  if i >= 60
  then return ()
  else do
    renderSVG ("/tmp/foo" <> to_3_char_string i <> ".svg") (dims (r2 (600,400))) $ ((handmadeDollar # rotateBy (1 / 60)) <> regPoly 7 3 # fc blue) ||| fromOffsets [r2 (1,1),r2 (1,0),r2 (1/2,1/2)] # strokeLine # lc black # lwL 0.3
    renderThis (i + 1) (handmadeDollar # rotateBy (1/60))

main :: IO ()
main = renderThis 0 handmadeDollar
