{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Bounded typeclass
module Data.Typeclass.Bounded where

import qualified Prelude

-- | A dictionary containing the methods of the Bounded typeclass
data Bounded a = Bounded
  { minBound :: a  -- ^ Minimum bound
  , maxBound :: a  -- ^ Maximum bound
  }

-- | Standard Bounded dictionary for any type with a Prelude.Bounded instance
fromPreludeBounded :: Prelude.Bounded a => Bounded a
fromPreludeBounded = Bounded
  { minBound = Prelude.minBound
  , maxBound = Prelude.maxBound
  }
