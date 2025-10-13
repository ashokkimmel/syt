{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Read typeclass
module Data.Typeclass.Read where

import qualified Prelude
import qualified Text.ParserCombinators.ReadP as ReadP
import qualified Text.Read as Read

-- | A dictionary containing the methods of the Read typeclass
data ReadDict a = ReadDict
  { readsPrec :: Prelude.Int -> Prelude.ReadS a  -- ^ Parse with precedence
  , readList  :: Prelude.ReadS [a]                -- ^ Parse a list
  , readPrec  :: Read.ReadPrec a                  -- ^ Parser with precedence
  , readListPrec :: Read.ReadPrec [a]             -- ^ List parser with precedence
  }

-- | Standard Read dictionary for any type with a Prelude.Read instance
fromPreludeRead :: Prelude.Read a => ReadDict a
fromPreludeRead = ReadDict
  { readsPrec = Prelude.readsPrec
  , readList  = Prelude.readList
  , readPrec  = Read.readPrec
  , readListPrec = Read.readListPrec
  }
