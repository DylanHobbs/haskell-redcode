module CodeWars where

import Types
import Lib
import Control.Concurrent
import Control.Monad

runSim :: String -> String -> IO ()
runSim a b = do
    -- Program 1
    contents <- readFile a
    let programA = parsePrograms [contents]

    -- Program 2
    contentsB <- readFile b
    let programB = parsePrograms [contentsB]

    let sim = newMars [programA, programB]
    forkIO $ goSim sim

goSim sim = forever do $





























