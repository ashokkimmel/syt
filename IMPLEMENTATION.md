# FromPreludeClass Type Class Implementation

## Overview

This repository implements a type class with the following kind signature:

```haskell
FromPreludeClass :: (k -> Constraint) -> (k -> Type) -> Constraint
```

## Type Class Definition

```haskell
class FromPreludeClass (cls :: k -> Constraint) (dta :: k -> Type) where
    fromPreludeClass :: forall a. cls a => dta a
```

### Parameters

- `cls`: A constraint constructor of kind `k -> Constraint` (e.g., `Show`, `Eq`, `Ord`)
- `dta`: A data type constructor of kind `k -> Type` (e.g., `Maybe`, `[]`, custom wrappers)

### Method

- `fromPreludeClass`: Converts a constraint `cls a` into a value of type `dta a`

## Required GHC Extensions

The implementation requires the following language extensions:

- `AllowAmbiguousTypes` - Allows the type class definition with ambiguous type variables
- `ConstraintKinds` - Enables using `Constraint` as a kind
- `DataKinds` - Promotes data types to kinds
- `KindSignatures` - Allows explicit kind annotations
- `MultiParamTypeClasses` - Enables type classes with multiple parameters
- `PolyKinds` - Enables kind polymorphism (the `k` parameter)
- `RankNTypes` - Required for the `forall a` in the method signature
- `TypeFamilies` - Additional type-level programming support

## Usage Example

The test suite demonstrates the type class with concrete instances:

```haskell
-- A wrapper type parameterized by 'a'
newtype ShowWrapper a = ShowWrapper { unShowWrapper :: String }

-- Instance: when 'a' has a Show constraint, 
-- we can create a ShowWrapper for it
instance Show a => FromPreludeClass Show ShowWrapper where
    fromPreludeClass = ShowWrapper "Created from Show constraint"
```

## Building and Testing

```bash
# Build the project
cabal build

# Run tests
cabal test

# Clean build artifacts
cabal clean
```

## Kind Signature Verification

You can verify the kind signature in GHCi:

```bash
$ ghci
> :load src/MyLib.hs
> :kind FromPreludeClass
FromPreludeClass :: (k -> Constraint) -> (k -> *) -> Constraint
```

Note: `*` and `Type` are synonymous in Haskell.
