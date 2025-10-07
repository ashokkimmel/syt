{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeFamilies #-}

module MyLib (FromPreludeClass(..)) where

import Data.Kind (Type, Constraint)

-- | A type class with kind (k -> Constraint) -> (k -> Type) -> Constraint
-- that allows converting from a Prelude constraint to a data type
class FromPreludeClass (cls :: k -> Constraint) (dta :: k -> Type) where
    fromPreludeClass :: forall a. cls a => dta a
