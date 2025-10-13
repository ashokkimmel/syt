{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}

-- | Type families for converting between typeclasses and their dictionary representations
module Data.Typeclass.Dict
  ( ToDict
  , FromDict
  , DictConversion(..)
  ) where

import Data.Kind (Type, Constraint)
import qualified Data.Typeclass.Eq as E
import qualified Data.Typeclass.Ord as O
import qualified Data.Typeclass.Num as N
import qualified Data.Typeclass.Show as S
import qualified Data.Typeclass.Read as R
import qualified Data.Typeclass.Enum as En
import qualified Data.Typeclass.Bounded as B
import qualified Data.Typeclass.Semigroup as Sg
import qualified Data.Typeclass.Monoid as Mon
import qualified Data.Typeclass.Functor as F
import qualified Data.Typeclass.Applicative as A
import qualified Data.Typeclass.Monad as M
import qualified Data.Typeclass.Foldable as Fo
import qualified Data.Typeclass.Traversable as T
import qualified Data.Typeclass.Real as Re
import qualified Data.Typeclass.Integral as I
import qualified Data.Typeclass.Fractional as Fr
import qualified Data.Typeclass.Floating as Fl
import qualified Data.Typeclass.RealFrac as RF
import qualified Data.Typeclass.RealFloat as RFl
import qualified Prelude

-- | Type family mapping from typeclass constraints to their dictionary types
-- This has kind (k -> Constraint) -> (k -> Type)
type family ToDict (c :: k -> Constraint) :: k -> Type

-- Type instances for standard typeclasses
type instance ToDict Prelude.Eq = E.EqDict
type instance ToDict Prelude.Ord = O.OrdDict
type instance ToDict Prelude.Num = N.NumDict
type instance ToDict Prelude.Show = S.ShowDict
type instance ToDict Prelude.Read = R.ReadDict
type instance ToDict Prelude.Enum = En.EnumDict
type instance ToDict Prelude.Bounded = B.BoundedDict
type instance ToDict Prelude.Semigroup = Sg.SemigroupDict
type instance ToDict Prelude.Monoid = Mon.MonoidDict
type instance ToDict Prelude.Functor = F.FunctorDict
type instance ToDict Prelude.Applicative = A.ApplicativeDict
type instance ToDict Prelude.Monad = M.MonadDict
type instance ToDict Prelude.Foldable = Fo.FoldableDict
type instance ToDict Prelude.Traversable = T.TraversableDict
type instance ToDict Prelude.Real = Re.RealDict
type instance ToDict Prelude.Integral = I.IntegralDict
type instance ToDict Prelude.Fractional = Fr.FractionalDict
type instance ToDict Prelude.Floating = Fl.FloatingDict
type instance ToDict Prelude.RealFrac = RF.RealFracDict
type instance ToDict Prelude.RealFloat = RFl.RealFloatDict

-- | Type family mapping from dictionary types back to their typeclass constraints
-- This has kind (k -> Type) -> (k -> Constraint)
type family FromDict (d :: k -> Type) :: k -> Constraint

-- Type instances for dictionary types
type instance FromDict E.EqDict = Prelude.Eq
type instance FromDict O.OrdDict = Prelude.Ord
type instance FromDict N.NumDict = Prelude.Num
type instance FromDict S.ShowDict = Prelude.Show
type instance FromDict R.ReadDict = Prelude.Read
type instance FromDict En.EnumDict = Prelude.Enum
type instance FromDict B.BoundedDict = Prelude.Bounded
type instance FromDict Sg.SemigroupDict = Prelude.Semigroup
type instance FromDict Mon.MonoidDict = Prelude.Monoid
type instance FromDict F.FunctorDict = Prelude.Functor
type instance FromDict A.ApplicativeDict = Prelude.Applicative
type instance FromDict M.MonadDict = Prelude.Monad
type instance FromDict Fo.FoldableDict = Prelude.Foldable
type instance FromDict T.TraversableDict = Prelude.Traversable
type instance FromDict Re.RealDict = Prelude.Real
type instance FromDict I.IntegralDict = Prelude.Integral
type instance FromDict Fr.FractionalDict = Prelude.Fractional
type instance FromDict Fl.FloatingDict = Prelude.Floating
type instance FromDict RF.RealFracDict = Prelude.RealFrac
type instance FromDict RFl.RealFloatDict = Prelude.RealFloat

-- | Class for converting between typeclass instances and their dictionary representations
class DictConversion c where
  -- | Convert a typeclass constraint to a dictionary
  toDict :: c a => ToDict c a
  -- | Convert a dictionary to operations (requires the dictionary as an argument)
  -- Note: We can't truly convert back to a constraint, but we can provide
  -- a function that takes a dictionary and uses it

-- Instances for all supported typeclasses
instance DictConversion Prelude.Eq where
  toDict = E.fromPreludeEq

instance DictConversion Prelude.Ord where
  toDict = O.fromPreludeOrd

instance DictConversion Prelude.Num where
  toDict = N.fromPreludeNum

instance DictConversion Prelude.Show where
  toDict = S.fromPreludeShow

instance DictConversion Prelude.Read where
  toDict = R.fromPreludeRead

instance DictConversion Prelude.Enum where
  toDict = En.fromPreludeEnum

instance DictConversion Prelude.Bounded where
  toDict = B.fromPreludeBounded

instance DictConversion Prelude.Semigroup where
  toDict = Sg.fromPreludeSemigroup

instance DictConversion Prelude.Monoid where
  toDict = Mon.fromPreludeMonoid

instance DictConversion Prelude.Functor where
  toDict = F.fromPreludeFunctor

instance DictConversion Prelude.Applicative where
  toDict = A.fromPreludeApplicative

instance DictConversion Prelude.Monad where
  toDict = M.fromPreludeMonad

instance DictConversion Prelude.Foldable where
  toDict = Fo.fromPreludeFoldable

instance DictConversion Prelude.Traversable where
  toDict = T.fromPreludeTraversable

instance DictConversion Prelude.Real where
  toDict = Re.fromPreludeReal

instance DictConversion Prelude.Integral where
  toDict = I.fromPreludeIntegral

instance DictConversion Prelude.Fractional where
  toDict = Fr.fromPreludeFractional

instance DictConversion Prelude.Floating where
  toDict = Fl.fromPreludeFloating

instance DictConversion Prelude.RealFrac where
  toDict = RF.fromPreludeRealFrac

instance DictConversion Prelude.RealFloat where
  toDict = RFl.fromPreludeRealFloat
