module Types where

type Program = [Redcode]

data Redcode = Redcode {
                instruction  :: Instruction
              , fieldA       :: Maybe Field
              , fieldB       :: Maybe Field
              }
              deriving (Read, Show)
newRedcode :: String -> Maybe String -> Maybe String -> Maybe Redcode
newRedcode instruction fieldA fieldB = do
  fieldAA   <-
    case fieldA of
      (Just fieldA) -> Just $ newField fieldA
      Nothing -> Nothing
  fieldBB   <-
    case fieldB of
      (Just fieldB) -> Just $ newField fieldB
      Nothing -> Nothing
  return $ Redcode (read instruction :: Instruction) fieldAA fieldBB


data Instruction = DAT | ADD | SUB | JMP | JMZ | JMN | DJN | CMP | SPL
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
                              _   -> ('$', read input)
  return $ Field addrMode (read address :: Int)

