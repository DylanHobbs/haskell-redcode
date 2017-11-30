module Types where

type Program = [Redcode]

{-|
  Redcode record to hold a single redcode instruction.
  Handles all types of redcode specified in spec.
-}
data Redcode = Redcode {
                instruction  :: Instruction
              , fieldA       :: Maybe Field
              , fieldB       :: Maybe Field
              }
              deriving (Read, Show)
newRedcode :: String -> Maybe String -> Maybe String -> Redcode
newRedcode instruction fieldA fieldB = Redcode (read instruction :: Instruction) fieldAA fieldBB
            where
                fieldAA  =
                  case fieldA of
                    (Just fieldA) -> newField fieldA
                    Nothing -> Nothing
                fieldBB   =
                  case fieldB of
                    (Just fieldB) -> newField fieldB
                    Nothing -> Nothing

data Instruction = DAT | ADD | SUB | JMP | JMZ | JMN | DJN | CMP | SPL | MOV
      deriving (Read, Show)

data Field = Field {
         addrMode :: Char
       , address  :: Int
       }
       deriving (Read, Show)
newField :: String -> Maybe Field
newField input = do
  let optionalAddrMode = head input
  let (addrMode, address) = case optionalAddrMode of
                              '@' -> ('@', drop 1 input)
                              '#' -> ('#', drop 1 input)
                              '<' -> ('<', drop 1 input)
                              _   -> ('$', input)
  return $ Field addrMode (read address :: Int)

{-|
  A running space represents a single task execution. A program will start with one of
  these running in a thread. The Mars simulation will be in charge of spawing new threads.
-}
data RunningSpace = RunningSpace {
        me             :: Program
      , size           :: Int
      , programCounter :: Int
      , startAddress   :: Int
      }
newRunningSpace :: Program -> RunningSpace
newRunningSpace program = RunningSpace program (length program) 0 0


{-|
  Mars Simulator.
  In charge of most of the heavy lifting.
  Controls turns
  Excecutes commands and passes relevent information back.
  Maintains what tasks belong to what program
-}
type ProgramID = Int
data Mars = Mars {
      programs    :: [(ProgramID, [RunningSpace])]
    , memorySpace :: [Maybe Redcode]
    , maxSize     :: Int
    }
newMars :: [Program] -> Mars
newMars progs = Mars (createRunningSpaces 0 progs) [] 8000

createRunningSpaces :: Int -> [Program] -> [(ProgramID, [RunningSpace])]
createRunningSpaces _ []     = []
createRunningSpaces 0 (x:xs) = (0, [newRunningSpace x]) : createRunningSpaces 1 xs
createRunningSpaces i (x:xs) = (i, [newRunningSpace x]) : createRunningSpaces (i + 1) xs



























