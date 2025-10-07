{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Num typeclass
module Data.Typeclass.Num where

import qualified Prelude

-- | A dictionary containing the methods of the Num typeclass
data NumDict a = NumDict
  { add      :: a -> a -> a  -- ^ Addition (+)
  , subtract :: a -> a -> a  -- ^ Subtraction (-)
  , multiply :: a -> a -> a  -- ^ Multiplication (*)
  , negate   :: a -> a       -- ^ Unary negation
  , abs      :: a -> a       -- ^ Absolute value
  , signum   :: a -> a       -- ^ Sign of a number
  , fromInteger :: Prelude.Integer -> a  -- ^ Conversion from Integer
  }

-- | Standard Num dictionary for any type with a Prelude.Num instance
fromPreludeNum :: Prelude.Num a => NumDict a
fromPreludeNum = NumDict
  { add      = (Prelude.+)
  , subtract = (Prelude.-)
  , multiply = (Prelude.*)
  , negate   = Prelude.negate
  , abs      = Prelude.abs
  , signum   = Prelude.signum
  , fromInteger = Prelude.fromInteger
  }
