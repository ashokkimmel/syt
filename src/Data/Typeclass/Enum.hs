{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Enum typeclass
module Data.Typeclass.Enum where

import qualified Prelude

-- | A dictionary containing the methods of the Enum typeclass
data EnumDict a = EnumDict
  { succ         :: a -> a                           -- ^ Successor
  , pred         :: a -> a                           -- ^ Predecessor
  , toEnum       :: Prelude.Int -> a                 -- ^ Convert from Int
  , fromEnum     :: a -> Prelude.Int                 -- ^ Convert to Int
  , enumFrom     :: a -> [a]                         -- ^ Enumerate from a value [n..]
  , enumFromThen :: a -> a -> [a]                    -- ^ Enumerate with step [n,n'..]
  , enumFromTo   :: a -> a -> [a]                    -- ^ Enumerate range [n..m]
  , enumFromThenTo :: a -> a -> a -> [a]             -- ^ Enumerate range with step [n,n'..m]
  }

-- | Standard Enum dictionary for any type with a Prelude.Enum instance
fromPreludeEnum :: Prelude.Enum a => EnumDict a
fromPreludeEnum = EnumDict
  { succ         = Prelude.succ
  , pred         = Prelude.pred
  , toEnum       = Prelude.toEnum
  , fromEnum     = Prelude.fromEnum
  , enumFrom     = Prelude.enumFrom
  , enumFromThen = Prelude.enumFromThen
  , enumFromTo   = Prelude.enumFromTo
  , enumFromThenTo = Prelude.enumFromThenTo
  }
