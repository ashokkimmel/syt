{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE StandaloneKindSignatures #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE RankNTypes #-}

module Data.Constraint.Dict
  ( -- * Type Families
    ConstraintToDict0
  , ConstraintToDict1
  , ConstraintToDict2
  
  -- * Dictionary Types for 0-ary constraints
  , MonoidDict(..)
  , SemigroupDict(..)
  
  -- * Dictionary Types for 1-ary constraints
  , FunctorDict(..)
  , ApplicativeDict(..)
  , MonadDict(..)
  , FoldableDict(..)
  , TraversableDict(..)
  
  -- * Dictionary Types for 2-ary constraints
  , BifunctorDict(..)
  ) where

import Data.Kind (Type, Constraint)
import Data.Bifunctor (Bifunctor)

-- | Type family for 0-ary (nullary) constraints
-- Maps a constraint of kind (Type -> Constraint) to its dictionary type constructor
type ConstraintToDict0 :: (Type -> Constraint) -> (Type -> Type)
type family ConstraintToDict0 c

-- | Type family for 1-ary (unary) constraints
-- Maps a constraint of kind ((Type -> Type) -> Constraint) to its dictionary type constructor
type ConstraintToDict1 :: ((Type -> Type) -> Constraint) -> ((Type -> Type) -> Type)
type family ConstraintToDict1 c

-- | Type family for 2-ary (binary) constraints
-- Maps a constraint of kind ((Type -> Type -> Type) -> Constraint) to its dictionary type constructor
type ConstraintToDict2 :: ((Type -> Type -> Type) -> Constraint) -> ((Type -> Type -> Type) -> Type)
type family ConstraintToDict2 c

-- Dictionary types for 0-ary constraints

-- | Dictionary for Monoid constraint
data MonoidDict a = MonoidDict
  { monoidMempty :: a
  , monoidMappend :: a -> a -> a
  }

-- | Dictionary for Semigroup constraint
data SemigroupDict a = SemigroupDict
  { semigroupAppend :: a -> a -> a
  }

-- Type instances for 0-ary constraints
type instance ConstraintToDict0 Monoid = MonoidDict
type instance ConstraintToDict0 Semigroup = SemigroupDict

-- Dictionary types for 1-ary constraints

-- | Dictionary for Functor constraint
data FunctorDict f = FunctorDict
  { functorFmap :: forall a b. (a -> b) -> f a -> f b
  }

-- | Dictionary for Applicative constraint
data ApplicativeDict f = ApplicativeDict
  { applicativePure :: forall a. a -> f a
  , applicativeAp :: forall a b. f (a -> b) -> f a -> f b
  }

-- | Dictionary for Monad constraint
data MonadDict m = MonadDict
  { monadReturn :: forall a. a -> m a
  , monadBind :: forall a b. m a -> (a -> m b) -> m b
  }

-- | Dictionary for Foldable constraint
data FoldableDict f = FoldableDict
  { foldableFoldr :: forall a b. (a -> b -> b) -> b -> f a -> b
  }

-- | Dictionary for Traversable constraint
data TraversableDict t = TraversableDict
  { traversableTraverse :: forall f a b. Applicative f => (a -> f b) -> t a -> f (t b)
  }

-- Type instances for 1-ary constraints
type instance ConstraintToDict1 Functor = FunctorDict
type instance ConstraintToDict1 Applicative = ApplicativeDict
type instance ConstraintToDict1 Monad = MonadDict
type instance ConstraintToDict1 Foldable = FoldableDict
type instance ConstraintToDict1 Traversable = TraversableDict

-- Dictionary types for 2-ary constraints

-- | Dictionary for Bifunctor constraint
data BifunctorDict p = BifunctorDict
  { bifunctorBimap :: forall a b c d. (a -> b) -> (c -> d) -> p a c -> p b d
  }

-- Type instances for 2-ary constraints
type instance ConstraintToDict2 Bifunctor = BifunctorDict
