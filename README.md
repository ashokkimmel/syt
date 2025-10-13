# syt

**Scrape Your Typeclasses** - Datatype representations of Haskell typeclasses from base.

## Overview

This library provides datatype representations of standard Haskell typeclasses. Instead of using typeclasses directly, you can pass around dictionaries containing the typeclass methods as data. This technique is known as "dictionary-passing style" and can be useful for various advanced programming techniques.

## Motivation

Haskell's typeclass system is powerful, but sometimes you need more flexibility:
- Passing multiple different implementations of the same typeclass for a type
- Dynamically choosing implementations at runtime
- Understanding how typeclasses work "under the hood"
- Building custom typeclass-like abstractions

## Available Typeclass Dictionaries

This library provides datatype representations for the following typeclasses:

### Basic Typeclasses
- **Eq** - Equality testing
- **Ord** - Ordering and comparison
- **Show** - Converting values to strings
- **Read** - Parsing values from strings
- **Enum** - Enumeration
- **Bounded** - Types with upper and lower bounds

### Numeric Typeclasses
- **Num** - Basic numeric operations
- **Real** - Real number operations
- **Integral** - Integer operations
- **Fractional** - Fractional number operations
- **Floating** - Floating-point operations
- **RealFrac** - Real fractional operations
- **RealFloat** - Real floating-point operations

### Algebraic Typeclasses
- **Semigroup** - Associative binary operation
- **Monoid** - Semigroup with identity element

### Functor Hierarchy
- **Functor** - Mappable structures
- **Applicative** - Applicative functors
- **Monad** - Monadic operations
- **Foldable** - Foldable structures
- **Traversable** - Traversable structures

## Example Usage

```haskell
import qualified Data.Typeclass.Eq as E
import qualified Data.Typeclass.Ord as O

-- Create a custom Eq dictionary
myEq :: E.Eq MyType
myEq = E.mkEq (\x y -> ...)

-- Use it
E.eq myEq value1 value2

-- Get a dictionary from an existing instance
intOrd :: O.Ord Int
intOrd = O.fromPreludeOrd
```

## Installation

Add this package to your cabal file or stack.yaml.

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

BSD-3-Clause
