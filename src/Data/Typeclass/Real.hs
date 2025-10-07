{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Real typeclass
module Data.Typeclass.Real where

import qualified Data.Typeclass.Num as N
import qualified Data.Typeclass.Ord as O
import qualified Prelude

-- | A dictionary containing the methods of the Real typeclass
data RealDict a = RealDict
  { numDict :: N.NumDict a                -- ^ Associated Num dictionary
  , ordDict :: O.OrdDict a                -- ^ Associated Ord dictionary
  , toRational :: a -> Prelude.Rational  -- ^ Convert to Rational
  }

-- | Standard Real dictionary for any type with a Prelude.Real instance
fromPreludeReal :: Prelude.Real a => RealDict a
fromPreludeReal = RealDict
  { numDict = N.fromPreludeNum
  , ordDict = O.fromPreludeOrd
  , toRational = Prelude.toRational
  }
