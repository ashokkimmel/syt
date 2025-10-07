{-# LANGUAGE RankNTypes #-}

-- | Example usage of typeclass dictionaries
module Main where

import qualified Data.Typeclass.Eq as E
import qualified Data.Typeclass.Ord as O
import qualified Data.Typeclass.Num as N
import qualified Data.Typeclass.Monoid as Mon
import qualified Data.Typeclass.Functor as F
import qualified Prelude

-- Example 1: Using Eq dictionary
example1 :: Prelude.IO ()
example1 = do
  Prelude.putStrLn "Example 1: Using Eq dictionary"
  let intEq = E.fromPreludeEq :: E.Eq Prelude.Int
  Prelude.print (E.eq intEq 5 5)    -- True
  Prelude.print (E.neq intEq 5 10)  -- True

-- Example 2: Custom Eq for a pair that ignores second element
example2 :: Prelude.IO ()
example2 = do
  Prelude.putStrLn "\nExample 2: Custom Eq for pairs (ignoring second element)"
  let pairEq = E.mkEq (\(x1, _) (x2, _) -> x1 Prelude.== x2)
  Prelude.print (E.eq pairEq (1, "foo") (1, "bar"))  -- True
  Prelude.print (E.eq pairEq (1, "foo") (2, "foo"))  -- False

-- Example 3: Using Ord dictionary
example3 :: Prelude.IO ()
example3 = do
  Prelude.putStrLn "\nExample 3: Using Ord dictionary"
  let intOrd = O.fromPreludeOrd :: O.Ord Prelude.Int
  Prelude.print (O.lt intOrd 5 10)         -- True
  Prelude.print (O.max intOrd 5 10)        -- 10
  Prelude.print (O.compare intOrd 5 10)    -- LT

-- Example 4: Using Num dictionary
example4 :: Prelude.IO ()
example4 = do
  Prelude.putStrLn "\nExample 4: Using Num dictionary"
  let intNum = N.fromPreludeNum :: N.Num Prelude.Int
  Prelude.print (N.add intNum 5 10)         -- 15
  Prelude.print (N.multiply intNum 3 7)     -- 21
  Prelude.print (N.abs intNum (N.negate intNum 5)) -- 5

-- Example 5: Using Monoid dictionary
example5 :: Prelude.IO ()
example5 = do
  Prelude.putStrLn "\nExample 5: Using Monoid dictionary for lists"
  let listMonoid = Mon.fromPreludeMonoid :: Mon.Monoid [Prelude.Int]
  Prelude.print (Mon.mappend listMonoid [1,2] [3,4])  -- [1,2,3,4]
  Prelude.print (Mon.mconcat listMonoid [[1], [2], [3]])  -- [1,2,3]

-- Example 6: Using Functor dictionary
example6 :: Prelude.IO ()
example6 = do
  Prelude.putStrLn "\nExample 6: Using Functor dictionary for Maybe"
  let maybeFunctor = F.fromPreludeFunctor :: F.Functor Prelude.Maybe
  Prelude.print (F.fmap maybeFunctor (Prelude.+ 1) (Prelude.Just 5))  -- Just 6
  Prelude.print (F.fmap maybeFunctor (Prelude.+ 1) Prelude.Nothing)   -- Nothing

main :: Prelude.IO ()
main = do
  Prelude.putStrLn "=== Typeclass Dictionary Examples ==="
  example1
  example2
  example3
  example4
  example5
  example6
  Prelude.putStrLn "\n=== All examples completed ==="
