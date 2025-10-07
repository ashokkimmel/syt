{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Floating typeclass
module Data.Typeclass.Floating where

import qualified Data.Typeclass.Fractional as F
import qualified Prelude

-- | A dictionary containing the methods of the Floating typeclass
data FloatingDict a = FloatingDict
  { fractionalDict :: F.FractionalDict a  -- ^ Associated Fractional dictionary
  , pi             :: a               -- ^ Mathematical constant pi
  , exp            :: a -> a          -- ^ Exponential function
  , log            :: a -> a          -- ^ Natural logarithm
  , sqrt           :: a -> a          -- ^ Square root
  , pow            :: a -> a -> a     -- ^ Exponentiation (**)
  , logBase        :: a -> a -> a     -- ^ Logarithm with custom base
  , sin            :: a -> a          -- ^ Sine
  , cos            :: a -> a          -- ^ Cosine
  , tan            :: a -> a          -- ^ Tangent
  , asin           :: a -> a          -- ^ Arcsine
  , acos           :: a -> a          -- ^ Arccosine
  , atan           :: a -> a          -- ^ Arctangent
  , sinh           :: a -> a          -- ^ Hyperbolic sine
  , cosh           :: a -> a          -- ^ Hyperbolic cosine
  , tanh           :: a -> a          -- ^ Hyperbolic tangent
  , asinh          :: a -> a          -- ^ Inverse hyperbolic sine
  , acosh          :: a -> a          -- ^ Inverse hyperbolic cosine
  , atanh          :: a -> a          -- ^ Inverse hyperbolic tangent
  }

-- | Standard Floating dictionary for any type with a Prelude.Floating instance
fromPreludeFloating :: Prelude.Floating a => FloatingDict a
fromPreludeFloating = FloatingDict
  { fractionalDict = F.fromPreludeFractional
  , pi             = Prelude.pi
  , exp            = Prelude.exp
  , log            = Prelude.log
  , sqrt           = Prelude.sqrt
  , pow            = (Prelude.**)
  , logBase        = Prelude.logBase
  , sin            = Prelude.sin
  , cos            = Prelude.cos
  , tan            = Prelude.tan
  , asin           = Prelude.asin
  , acos           = Prelude.acos
  , atan           = Prelude.atan
  , sinh           = Prelude.sinh
  , cosh           = Prelude.cosh
  , tanh           = Prelude.tanh
  , asinh          = Prelude.asinh
  , acosh          = Prelude.acosh
  , atanh          = Prelude.atanh
  }
