{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Bounded typeclass
module Data.Typeclass.Bounded where

import qualified Prelude

-- | A dictionary containing the methods of the Bounded typeclass
data BoundedDict a = BoundedDict
  { minBound :: a  -- ^ Minimum bound
  , maxBound :: a  -- ^ Maximum bound
  }

-- | Standard Bounded dictionary for any type with a Prelude.Bounded instance
fromPreludeBounded :: Prelude.Bounded a => BoundedDict a
fromPreludeBounded = BoundedDict
  { minBound = Prelude.minBound
  , maxBound = Prelude.maxBound
  }
