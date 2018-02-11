{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.ByteString.Lazy.Char8 as L8
import Network.HTTP.Simple

import Lib

main :: IO ()
main = do
  response <- httpLBS "http://localhost:5002"
  putStrLn $ "The status code was: " ++
    show (getResponseStatusCode response)
  print $ getResponseHeader "Content-Type" response
  L8.putStrLn $ getResponseBody response
  putStrLn $ L8.unpack $ getResponseBody response

  
