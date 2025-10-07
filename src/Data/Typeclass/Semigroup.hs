{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Semigroup typeclass
module Data.Typeclass.Semigroup where

import qualified Prelude
import qualified Data.Semigroup as DS

-- | A dictionary containing the methods of the Semigroup typeclass
data Semigroup a = Semigroup
  { append :: a -> a -> a  -- ^ Associative operation (<>)
  , stimes :: forall b. Prelude.Integral b => b -> a -> a  -- ^ Repeat a value n times
  }

-- | Construct a Semigroup dictionary from just the append function
mkSemigroup :: (a -> a -> a) -> Semigroup a
mkSemigroup app = Semigroup
  { append = app
  , stimes = \n x -> stimesDefault n x
  }
  where
    stimesDefault n x
      | n Prelude.<= 0 = Prelude.error "stimes: positive multiplier expected"
      | Prelude.otherwise = go n x
      where
        go 1 a = a
        go m a = app a (go (m Prelude.- 1) a)

-- | Standard Semigroup dictionary for any type with a Prelude.Semigroup instance
fromPreludeSemigroup :: Prelude.Semigroup a => Semigroup a
fromPreludeSemigroup = Semigroup
  { append = (Prelude.<>)
  , stimes = DS.stimes
  }
