{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the RealFloat typeclass
module Data.Typeclass.RealFloat where

import qualified Data.Typeclass.RealFrac as RF
import qualified Data.Typeclass.Floating as Fl
import qualified Prelude

-- | A dictionary containing the methods of the RealFloat typeclass
data RealFloat a = RealFloat
  { realFracDict   :: RF.RealFrac a                       -- ^ Associated RealFrac dictionary
  , floatingDict   :: Fl.Floating a                       -- ^ Associated Floating dictionary
  , floatRadix     :: a -> Prelude.Integer                -- ^ Radix of the representation
  , floatDigits    :: a -> Prelude.Int                    -- ^ Number of digits in the mantissa
  , floatRange     :: a -> (Prelude.Int, Prelude.Int)     -- ^ Range of the exponent
  , decodeFloat    :: a -> (Prelude.Integer, Prelude.Int) -- ^ Decode to mantissa and exponent
  , encodeFloat    :: Prelude.Integer -> Prelude.Int -> a -- ^ Encode from mantissa and exponent
  , exponent       :: a -> Prelude.Int                    -- ^ Exponent
  , significand    :: a -> a                              -- ^ Significand (mantissa normalized to [0,1))
  , scaleFloat     :: Prelude.Int -> a -> a               -- ^ Multiply by integer power of radix
  , isNaN          :: a -> Prelude.Bool                   -- ^ Test for NaN
  , isInfinite     :: a -> Prelude.Bool                   -- ^ Test for infinity
  , isDenormalized :: a -> Prelude.Bool                   -- ^ Test for denormalized number
  , isNegativeZero :: a -> Prelude.Bool                   -- ^ Test for negative zero
  , isIEEE         :: a -> Prelude.Bool                   -- ^ Test if uses IEEE representation
  , atan2          :: a -> a -> a                         -- ^ Two-argument arctangent
  }

-- | Standard RealFloat dictionary for any type with a Prelude.RealFloat instance
fromPreludeRealFloat :: Prelude.RealFloat a => RealFloat a
fromPreludeRealFloat = RealFloat
  { realFracDict   = RF.fromPreludeRealFrac
  , floatingDict   = Fl.fromPreludeFloating
  , floatRadix     = Prelude.floatRadix
  , floatDigits    = Prelude.floatDigits
  , floatRange     = Prelude.floatRange
  , decodeFloat    = Prelude.decodeFloat
  , encodeFloat    = Prelude.encodeFloat
  , exponent       = Prelude.exponent
  , significand    = Prelude.significand
  , scaleFloat     = Prelude.scaleFloat
  , isNaN          = Prelude.isNaN
  , isInfinite     = Prelude.isInfinite
  , isDenormalized = Prelude.isDenormalized
  , isNegativeZero = Prelude.isNegativeZero
  , isIEEE         = Prelude.isIEEE
  , atan2          = Prelude.atan2
  }
