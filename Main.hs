module Main where

import           Criterion.Main
import qualified Data.ByteString.Lazy       as DBSL
import qualified Data.ByteString.Lazy.Char8 as DBSLC
import qualified Text.Show.ByteString       as TSBS

isIntegral :: Float -> Bool
isIntegral = DBSL.isSuffixOf (DBSLC.pack ".0") . TSBS.show

isIntegral' :: Float -> Bool
isIntegral' x = x == fromInteger (round x)

mapII :: [Float] -> [Bool]
mapII = map isIntegral

mapII' :: [Float] -> [Bool]
mapII' = map isIntegral'

main :: IO ()
main = defaultMain [
  bgroup "integral" [ bench "mine 1"      $ nf mapII (map (/100) [1..1000000])
                    , bench "not mine 1"  $ nf mapII' (map (/100) [1..1000000])
                    ]
  ]
