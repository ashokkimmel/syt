{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Traversable typeclass
module Data.Typeclass.Traversable where

import qualified Prelude
import qualified Data.Typeclass.Functor as F
import qualified Data.Typeclass.Foldable as Fold

-- | A dictionary containing the methods of the Traversable typeclass
data Traversable t = Traversable
  { functorDict  :: F.Functor t                                                          -- ^ Associated Functor dictionary
  , foldableDict :: Fold.Foldable t                                                      -- ^ Associated Foldable dictionary
  , traverse     :: forall f a b. Prelude.Applicative f => (a -> f b) -> t a -> f (t b) -- ^ Map and collect effects
  , sequenceA    :: forall f a. Prelude.Applicative f => t (f a) -> f (t a)             -- ^ Collect effects
  , mapM         :: forall m a b. Prelude.Monad m => (a -> m b) -> t a -> m (t b)       -- ^ Monadic map
  , sequence     :: forall m a. Prelude.Monad m => t (m a) -> m (t a)                   -- ^ Monadic sequence
  }

-- | Standard Traversable dictionary for any type with a Prelude.Traversable instance
fromPreludeTraversable :: Prelude.Traversable t => Traversable t
fromPreludeTraversable = Traversable
  { functorDict  = F.fromPreludeFunctor
  , foldableDict = Fold.fromPreludeFoldable
  , traverse     = Prelude.traverse
  , sequenceA    = Prelude.sequenceA
  , mapM         = Prelude.mapM
  , sequence     = Prelude.sequence
  }
