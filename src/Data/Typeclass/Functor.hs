{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Functor typeclass
module Data.Typeclass.Functor where

import qualified Prelude
import qualified Data.Functor as DF

-- | A dictionary containing the methods of the Functor typeclass
data Functor f = Functor
  { fmap :: forall a b. (a -> b) -> f a -> f b  -- ^ Map a function over the structure
  , voidOp :: forall a. f a -> f ()             -- ^ Replace all values with ()
  }

-- | Construct a Functor dictionary from just fmap
mkFunctor :: (forall a b. (a -> b) -> f a -> f b) -> Functor f
mkFunctor fmapFunc = Functor
  { fmap = fmapFunc
  , voidOp = \fa -> fmapFunc (\_ -> ()) fa
  }

-- | Standard Functor dictionary for any type with a Prelude.Functor instance
fromPreludeFunctor :: Prelude.Functor f => Functor f
fromPreludeFunctor = Functor
  { fmap = Prelude.fmap
  , voidOp = DF.void
  }
