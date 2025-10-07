# syt

A Haskell library implementing a type class with advanced kind signatures.

## Type Class: FromPreludeClass

This library provides a type class with the following kind signature:

```haskell
FromPreludeClass :: (k -> Constraint) -> (k -> Type) -> Constraint
```

The type class allows converting from Prelude constraint classes (like `Show`, `Eq`, `Ord`) to custom data types.

### Definition

```haskell
class FromPreludeClass (cls :: k -> Constraint) (dta :: k -> Type) where
    fromPreludeClass :: forall a. cls a => dta a
```

## Getting Started

### Building

```bash
cabal build
```

### Running Tests

```bash
cabal test
```

### Documentation

See [IMPLEMENTATION.md](IMPLEMENTATION.md) for detailed documentation on the type class implementation, required extensions, and usage examples.

## Features

- Kind polymorphism with `PolyKinds`
- Constraint-kind support with `ConstraintKinds`
- Higher-kinded type class design
- Example instances for `Show` and `Eq` constraints

## Requirements

- GHC 9.12.2 or compatible
- Cabal 3.0 or higher
