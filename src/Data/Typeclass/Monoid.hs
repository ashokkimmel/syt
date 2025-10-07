{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Monoid typeclass
module Data.Typeclass.Monoid where

import qualified Data.Typeclass.Semigroup as S
import qualified Prelude

-- | A dictionary containing the methods of the Monoid typeclass
data MonoidDict a = MonoidDict
  { semigroupDict :: S.SemigroupDict a  -- ^ Associated Semigroup dictionary
  , mempty        :: a              -- ^ Identity element
  , mappend       :: a -> a -> a    -- ^ Associative operation (usually same as <>)
  , mconcat       :: [a] -> a       -- ^ Fold a list using the monoid
  }

-- | Construct a Monoid dictionary from mempty and mappend
mkMonoid :: a -> (a -> a -> a) -> MonoidDict a
mkMonoid empty app = MonoidDict
  { semigroupDict = S.mkSemigroup app
  , mempty        = empty
  , mappend       = app
  , mconcat       = Prelude.foldr app empty
  }

-- | Standard Monoid dictionary for any type with a Prelude.Monoid instance
fromPreludeMonoid :: Prelude.Monoid a => MonoidDict a
fromPreludeMonoid = MonoidDict
  { semigroupDict = S.fromPreludeSemigroup
  , mempty        = Prelude.mempty
  , mappend       = Prelude.mappend
  , mconcat       = Prelude.mconcat
  }
