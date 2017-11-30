module Lib
    where

import System.Environment
import Types
import Data.List.Split

-- Main entry point Grab the IO Programs here
{-|
  Take a list of redcode files as arguments.
-}
someFunc :: IO ()
someFunc = do
      programPath <- getArgs
      contents <- mapM readFile programPath
      let line = map lines contents
      let programs = map parsePrograms line
      print programs

--createNew :: String -> Program
--createNew file =

{-|
  Silly utility function because I couldn't find
  it in the prelude
  (too lazy dig through docs)
-}
dropLast :: [a] -> [a]
dropLast []     = []
dropLast [x]    = []
dropLast (x:xs) = x : dropLast xs

{-|
  I put this here to separate it from the IO
  Given a single Redcode program previously
  split into lines we map a your friendly neighbourhood
  parsing function across it.
-}
parsePrograms :: [String] -> Program
parsePrograms lines = do
      let x = map (splitOn " ") lines
      let programs = createProgram x
      programs

{-|
  Friendly neighbourhood parsing function
  Redcode instructions either have 2 fields, comma
  separated or one field, no comma.
-}
createProgram :: [[String]] -> Program
createProgram ([x,y,z]:rest) = newRedcode x (Just (dropLast y)) (Just z) : createProgram rest
createProgram ([x, y]:rest)  = newRedcode x (Just y) Nothing : createProgram rest
createProgram _ = []


