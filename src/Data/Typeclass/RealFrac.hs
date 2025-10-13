{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the RealFrac typeclass
module Data.Typeclass.RealFrac where

import qualified Data.Typeclass.Real as R
import qualified Data.Typeclass.Fractional as F
import qualified Prelude

-- | A dictionary containing the methods of the RealFrac typeclass
data RealFracDict a = RealFracDict
  { realDict       :: R.RealDict a                    -- ^ Associated Real dictionary
  , fractionalDict :: F.FractionalDict a              -- ^ Associated Fractional dictionary
  , properFraction :: forall b. Prelude.Integral b => a -> (b, a)  -- ^ Split into integer and fractional parts
  , truncate       :: forall b. Prelude.Integral b => a -> b       -- ^ Round toward zero
  , round          :: forall b. Prelude.Integral b => a -> b       -- ^ Round to nearest integer
  , ceiling        :: forall b. Prelude.Integral b => a -> b       -- ^ Round toward positive infinity
  , floor          :: forall b. Prelude.Integral b => a -> b       -- ^ Round toward negative infinity
  }

-- | Standard RealFrac dictionary for any type with a Prelude.RealFrac instance
fromPreludeRealFrac :: Prelude.RealFrac a => RealFracDict a
fromPreludeRealFrac = RealFracDict
  { realDict       = R.fromPreludeReal
  , fractionalDict = F.fromPreludeFractional
  , properFraction = Prelude.properFraction
  , truncate       = Prelude.truncate
  , round          = Prelude.round
  , ceiling        = Prelude.ceiling
  , floor          = Prelude.floor
  }
