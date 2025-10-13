{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Integral typeclass
module Data.Typeclass.Integral where

import qualified Data.Typeclass.Real as R
import qualified Data.Typeclass.Enum as E
import qualified Prelude

-- | A dictionary containing the methods of the Integral typeclass
data IntegralDict a = IntegralDict
  { realDict :: R.RealDict a                           -- ^ Associated Real dictionary
  , enumDict :: E.EnumDict a                           -- ^ Associated Enum dictionary
  , quot     :: a -> a -> a                        -- ^ Integer division truncated toward zero
  , rem      :: a -> a -> a                        -- ^ Integer remainder satisfying (x `quot` y)*y + (x `rem` y) == x
  , div      :: a -> a -> a                        -- ^ Integer division truncated toward negative infinity
  , mod      :: a -> a -> a                        -- ^ Integer modulus satisfying (x `div` y)*y + (x `mod` y) == x
  , quotRem  :: a -> a -> (a, a)                   -- ^ Simultaneous quot and rem
  , divMod   :: a -> a -> (a, a)                   -- ^ Simultaneous div and mod
  , toInteger :: a -> Prelude.Integer              -- ^ Convert to Integer
  }

-- | Standard Integral dictionary for any type with a Prelude.Integral instance
fromPreludeIntegral :: Prelude.Integral a => IntegralDict a
fromPreludeIntegral = IntegralDict
  { realDict  = R.fromPreludeReal
  , enumDict  = E.fromPreludeEnum
  , quot      = Prelude.quot
  , rem       = Prelude.rem
  , div       = Prelude.div
  , mod       = Prelude.mod
  , quotRem   = Prelude.quotRem
  , divMod    = Prelude.divMod
  , toInteger = Prelude.toInteger
  }
