{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Monad typeclass
module Data.Typeclass.Monad where

import qualified Data.Typeclass.Applicative as A
import qualified Data.Typeclass.Functor as F
import qualified Prelude

-- | A dictionary containing the methods of the Monad typeclass
data MonadDict m = MonadDict
  { applicativeDict :: A.ApplicativeDict m                      -- ^ Associated Applicative dictionary
  , bind            :: forall a b. m a -> (a -> m b) -> m b -- ^ Monadic bind (>>=)
  , seqR            :: forall a b. m a -> m b -> m b        -- ^ Sequence actions (>>)
  , return          :: forall a. a -> m a                   -- ^ Inject a value into the monad
  }

-- | Construct a Monad dictionary from bind and return
mkMonad :: A.ApplicativeDict m
        -> (forall a b. m a -> (a -> m b) -> m b)
        -> (forall a. a -> m a)
        -> MonadDict m
mkMonad adict bindFunc returnFunc = MonadDict
  { applicativeDict = adict
  , bind            = bindFunc
  , seqR            = \ma mb -> bindFunc ma (\_ -> mb)
  , return          = returnFunc
  }

-- | Standard Monad dictionary for any type with a Prelude.Monad instance
fromPreludeMonad :: Prelude.Monad m => MonadDict m
fromPreludeMonad = MonadDict
  { applicativeDict = A.fromPreludeApplicative
  , bind            = (Prelude.>>=)
  , seqR            = (Prelude.>>)
  , return          = Prelude.return
  }
