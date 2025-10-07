{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Ord typeclass
module Data.Typeclass.Ord where

import qualified Data.Typeclass.Eq as E
import qualified Prelude

-- | A dictionary containing the methods of the Ord typeclass
data Ord a = Ord
  { eqDict  :: E.Eq a                    -- ^ Associated Eq dictionary
  , compare :: a -> a -> Prelude.Ordering    -- ^ Three-way comparison
  , lt      :: a -> a -> Prelude.Bool        -- ^ Less than (<)
  , lte     :: a -> a -> Prelude.Bool        -- ^ Less than or equal (<=)
  , gt      :: a -> a -> Prelude.Bool        -- ^ Greater than (>)
  , gte     :: a -> a -> Prelude.Bool        -- ^ Greater than or equal (>=)
  , max     :: a -> a -> a           -- ^ Maximum of two values
  , min     :: a -> a -> a           -- ^ Minimum of two values
  }

-- | Construct an Ord dictionary from compare and an Eq dictionary
mkOrd :: E.Eq a -> (a -> a -> Prelude.Ordering) -> Ord a
mkOrd eqD cmp = Ord
  { eqDict  = eqD
  , compare = cmp
  , lt      = \x y -> cmp x y Prelude.== Prelude.LT
  , lte     = \x y -> cmp x y Prelude./= Prelude.GT
  , gt      = \x y -> cmp x y Prelude.== Prelude.GT
  , gte     = \x y -> cmp x y Prelude./= Prelude.LT
  , max     = \x y -> case cmp x y of
                        Prelude.GT -> x
                        _  -> y
  , min     = \x y -> case cmp x y of
                        Prelude.LT -> x
                        _  -> y
  }

-- | Standard Ord dictionary for any type with a Prelude.Ord instance
fromPreludeOrd :: Prelude.Ord a => Ord a
fromPreludeOrd = Ord
  { eqDict  = E.fromPreludeEq
  , compare = Prelude.compare
  , lt      = (Prelude.<)
  , lte     = (Prelude.<=)
  , gt      = (Prelude.>)
  , gte     = (Prelude.>=)
  , max     = Prelude.max
  , min     = Prelude.min
  }
