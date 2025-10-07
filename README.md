# syt

Type families for mapping type class constraints to dictionary types.

## Overview

This library provides type families for converting constraints to dictionary types at three different arities:

- **ConstraintToDict0**: For 0-ary (nullary) constraints like `Monoid`, `Semigroup`
- **ConstraintToDict1**: For 1-ary (unary) constraints like `Functor`, `Applicative`, `Monad`
- **ConstraintToDict2**: For 2-ary (binary) constraints like `Bifunctor`

## Type Families

```haskell
type ConstraintToDict0 :: (Type -> Constraint) -> (Type -> Type)
type ConstraintToDict1 :: ((Type -> Type) -> Constraint) -> ((Type -> Type) -> Type)
type ConstraintToDict2 :: ((Type -> Type -> Type) -> Constraint) -> ((Type -> Type -> Type) -> Type)
```

## Example Usage

```haskell
import Data.Constraint.Dict

-- For 0-ary constraints
monoidDict :: ConstraintToDict0 Monoid Int
monoidDict = MonoidDict 0 (+)

-- For 1-ary constraints
functorDict :: ConstraintToDict1 Functor []
functorDict = FunctorDict map

-- For 2-ary constraints
bifunctorDict :: ConstraintToDict2 Bifunctor (,)
bifunctorDict = BifunctorDict (\f g (x, y) -> (f x, g y))
```

## Supported Constraints

### 0-ary (Nullary)
- `Monoid` → `MonoidDict`
- `Semigroup` → `SemigroupDict`

### 1-ary (Unary)
- `Functor` → `FunctorDict`
- `Applicative` → `ApplicativeDict`
- `Monad` → `MonadDict`
- `Foldable` → `FoldableDict`
- `Traversable` → `TraversableDict`

### 2-ary (Binary)
- `Bifunctor` → `BifunctorDict`

## Building

```bash
cabal build
cabal test
```
