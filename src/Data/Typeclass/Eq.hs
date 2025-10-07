{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Eq typeclass
module Data.Typeclass.Eq where

-- | A dictionary containing the methods of the Eq typeclass
data EqDict a = EqDict
  { eq  :: a -> a -> Bool  -- ^ Equality test (==)
  , neq :: a -> a -> Bool  -- ^ Inequality test (/=)
  }

-- | Construct an Eq dictionary from just the (==) function
-- The (/=) function is derived as the negation of (==)
mkEq :: (a -> a -> Bool) -> EqDict a
mkEq eqFunc = EqDict
  { eq  = eqFunc
  , neq = \x y -> not (eqFunc x y)
  }

-- | Standard Eq dictionary for Int
intEq :: EqDict Int
intEq = mkEq (Prelude.==)

-- | Standard Eq dictionary for any type with a Prelude.Eq instance
fromPreludeEq :: Prelude.Eq a => EqDict a
fromPreludeEq = EqDict
  { eq  = (Prelude.==)
  , neq = (Prelude./=)
  }
