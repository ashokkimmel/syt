{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Fractional typeclass
module Data.Typeclass.Fractional where

import qualified Data.Typeclass.Num as N
import qualified Prelude

-- | A dictionary containing the methods of the Fractional typeclass
data FractionalDict a = FractionalDict
  { numDict :: N.NumDict a                  -- ^ Associated Num dictionary
  , divide  :: a -> a -> a              -- ^ Fractional division (/)
  , recip   :: a -> a                   -- ^ Reciprocal
  , fromRational :: Prelude.Rational -> a  -- ^ Convert from Rational
  }

-- | Construct a Fractional dictionary from division and fromRational
mkFractional :: N.NumDict a -> (a -> a -> a) -> (Prelude.Rational -> a) -> FractionalDict a
mkFractional ndict divFunc fromRat = FractionalDict
  { numDict = ndict
  , divide  = divFunc
  , recip   = \x -> fromRat 1 `divFunc` x
  , fromRational = fromRat
  }

-- | Standard Fractional dictionary for any type with a Prelude.Fractional instance
fromPreludeFractional :: Prelude.Fractional a => FractionalDict a
fromPreludeFractional = FractionalDict
  { numDict = N.fromPreludeNum
  , divide  = (Prelude./)
  , recip   = Prelude.recip
  , fromRational = Prelude.fromRational
  }
