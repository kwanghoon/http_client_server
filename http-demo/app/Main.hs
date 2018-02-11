module Main where

import Control.Concurrent
import System.IO
import Network

import qualified Data.ByteString.Lazy.Char8 as L8
import Data.Aeson

import Lib

main :: IO ()
main = withSocketsDo $ do
  sock <- listenOn $ PortNumber 5002
  loop sock

loop sock = do
  (h,_,_) <- accept sock
  forkIO $ body h
  loop sock
  where
    body h = do
      hPutStr h (json_msg)
      hFlush h
      hClose h

msg = "HTTP/1.0 200 OK\r\nContent-Length: 5\r\n\r\nPong!\r\n"

json_msg =
  "HTTP/1.0 200 OK\r\nContent-Length: " ++ len_msg ++ "\r\n\r\n" ++ j_msg ++ "\r\n"
  where
    len_msg = show (length j_msg)
    j_msg = L8.unpack (encode ([1,2,3] :: [Int]))
  

