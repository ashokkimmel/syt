{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Foldable typeclass
module Data.Typeclass.Foldable where

import qualified Prelude
import qualified Data.Typeclass.Monoid as M
import qualified Data.Foldable as DF

-- | A dictionary containing the methods of the Foldable typeclass
data FoldableDict t = FoldableDict
  { fold    :: forall m. Prelude.Monoid m => t m -> m                          -- ^ Combine elements with monoid
  , foldMap :: forall m a. Prelude.Monoid m => (a -> m) -> t a -> m            -- ^ Map and combine
  , foldr   :: forall a b. (a -> b -> b) -> b -> t a -> b                       -- ^ Right-associative fold
  , foldr'  :: forall a b. (a -> b -> b) -> b -> t a -> b                       -- ^ Strict right fold
  , foldl   :: forall b a. (b -> a -> b) -> b -> t a -> b                       -- ^ Left-associative fold
  , foldl'  :: forall b a. (b -> a -> b) -> b -> t a -> b                       -- ^ Strict left fold
  , foldr1  :: forall a. (a -> a -> a) -> t a -> a                              -- ^ Right fold without base case
  , foldl1  :: forall a. (a -> a -> a) -> t a -> a                              -- ^ Left fold without base case
  , toList  :: forall a. t a -> [a]                                             -- ^ Convert to list
  , null    :: forall a. t a -> Prelude.Bool                                    -- ^ Test if empty
  , length  :: forall a. t a -> Prelude.Int                                     -- ^ Number of elements
  , elem    :: forall a. Prelude.Eq a => a -> t a -> Prelude.Bool              -- ^ Element membership test
  , maximum :: forall a. Prelude.Ord a => t a -> a                              -- ^ Maximum element
  , minimum :: forall a. Prelude.Ord a => t a -> a                              -- ^ Minimum element
  , sum     :: forall a. Prelude.Num a => t a -> a                              -- ^ Sum of elements
  , product :: forall a. Prelude.Num a => t a -> a                              -- ^ Product of elements
  }

-- | Standard Foldable dictionary for any type with a Prelude.Foldable instance
fromPreludeFoldable :: Prelude.Foldable t => FoldableDict t
fromPreludeFoldable = FoldableDict
  { fold    = DF.fold
  , foldMap = DF.foldMap
  , foldr   = Prelude.foldr
  , foldr'  = DF.foldr'
  , foldl   = Prelude.foldl
  , foldl'  = Prelude.foldl'
  , foldr1  = Prelude.foldr1
  , foldl1  = Prelude.foldl1
  , toList  = DF.toList
  , null    = Prelude.null
  , length  = Prelude.length
  , elem    = Prelude.elem
  , maximum = Prelude.maximum
  , minimum = Prelude.minimum
  , sum     = Prelude.sum
  , product = Prelude.product
  }
