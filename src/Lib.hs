module Lib
    where

import System.Environment
import Types
import Data.List.Split

-- Main entry point Grab the IO Programs here
-- Lets get one file read for now
someFunc :: IO ()
someFunc = do
      programPath <- getArgs
      contents <- mapM readFile programPath
      let line = map lines contents
      let programs = map parseProgram line
      print programs

dropLast :: String -> String
dropLast []     = []
dropLast [x]    = []
dropLast (x:xs) = x : dropLast xs

parseProgram :: [String] -> Program
parseProgram lines = do
      --contents <- readFile file
      --let line = lines contents
      --[(addr, f1, f2)] <- map splitOn line
      let x = map (splitOn " ") lines
      let programs = createProgram x
      programs

createProgram :: [[String]] -> Program
createProgram ([x,y,z]:rest) = newRedcode x (Just (dropLast y)) (Just z) : createProgram rest
createProgram _ = []
