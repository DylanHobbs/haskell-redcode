module Types where

type Program = [Redcode]

{-|
  Redcode data type hold a single redcode instruction.
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
                              _   -> ('$', input)
  return $ Field addrMode (read address :: Int)

