{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Applicative typeclass
module Data.Typeclass.Applicative where

import qualified Data.Typeclass.Functor as F
import qualified Prelude

-- | A dictionary containing the methods of the Applicative typeclass
data ApplicativeDict f = ApplicativeDict
  { functorDict :: F.FunctorDict f                                -- ^ Associated Functor dictionary
  , pure        :: forall a. a -> f a                         -- ^ Lift a value
  , ap          :: forall a b. f (a -> b) -> f a -> f b      -- ^ Sequential application (<*>)
  , liftA2      :: forall a b c. (a -> b -> c) -> f a -> f b -> f c  -- ^ Lift a binary function
  , apR         :: forall a b. f a -> f b -> f b             -- ^ Sequence actions, discarding left (*>)
  , apL         :: forall a b. f a -> f b -> f a             -- ^ Sequence actions, discarding right (<*)
  }

-- | Construct an Applicative dictionary from pure and ap
mkApplicative :: F.FunctorDict f 
              -> (forall a. a -> f a) 
              -> (forall a b. f (a -> b) -> f a -> f b) 
              -> ApplicativeDict f
mkApplicative fdict pureFunc apFunc = ApplicativeDict
  { functorDict = fdict
  , pure        = pureFunc
  , ap          = apFunc
  , liftA2      = \f x y -> apFunc (F.fmap fdict f x) y
  , apR         = \x y -> apFunc (F.fmap fdict (\_ -> Prelude.id) x) y
  , apL         = \x y -> apFunc (F.fmap fdict Prelude.const x) y
  }

-- | Standard Applicative dictionary for any type with a Prelude.Applicative instance
fromPreludeApplicative :: Prelude.Applicative f => ApplicativeDict f
fromPreludeApplicative = ApplicativeDict
  { functorDict = F.fromPreludeFunctor
  , pure        = Prelude.pure
  , ap          = (Prelude.<*>)
  , liftA2      = Prelude.liftA2
  , apR         = (Prelude.*>)
  , apL         = (Prelude.<*)
  }
