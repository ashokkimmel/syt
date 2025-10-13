{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeApplications #-}

-- | Example usage of typeclass dictionaries
module Main where

import qualified Data.Typeclass.Eq as E
import qualified Data.Typeclass.Ord as O
import qualified Data.Typeclass.Num as N
import qualified Data.Typeclass.Monoid as Mon
import qualified Data.Typeclass.Functor as F
import qualified Data.Typeclass.Dict as D
import qualified Prelude

-- Example 1: Using Eq dictionary
example1 :: Prelude.IO ()
example1 = do
  Prelude.putStrLn "Example 1: Using Eq dictionary"
  let intEq = E.fromPreludeEq :: E.EqDict Prelude.Int
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
  let intOrd = O.fromPreludeOrd :: O.OrdDict Prelude.Int
  Prelude.print (O.lt intOrd 5 10)         -- True
  Prelude.print (O.max intOrd 5 10)        -- 10
  Prelude.print (O.compare intOrd 5 10)    -- LT

-- Example 4: Using Num dictionary
example4 :: Prelude.IO ()
example4 = do
  Prelude.putStrLn "\nExample 4: Using Num dictionary"
  let intNum = N.fromPreludeNum :: N.NumDict Prelude.Int
  Prelude.print (N.add intNum 5 10)         -- 15
  Prelude.print (N.multiply intNum 3 7)     -- 21
  Prelude.print (N.abs intNum (N.negate intNum 5)) -- 5

-- Example 5: Using Monoid dictionary
example5 :: Prelude.IO ()
example5 = do
  Prelude.putStrLn "\nExample 5: Using Monoid dictionary for lists"
  let listMonoid = Mon.fromPreludeMonoid :: Mon.MonoidDict [Prelude.Int]
  Prelude.print (Mon.mappend listMonoid [1,2] [3,4])  -- [1,2,3,4]
  Prelude.print (Mon.mconcat listMonoid [[1], [2], [3]])  -- [1,2,3]

-- Example 6: Using Functor dictionary
example6 :: Prelude.IO ()
example6 = do
  Prelude.putStrLn "\nExample 6: Using Functor dictionary for Maybe"
  let maybeFunctor = F.fromPreludeFunctor :: F.FunctorDict Prelude.Maybe
  Prelude.print (F.fmap maybeFunctor (Prelude.+ 1) (Prelude.Just 5))  -- Just 6
  Prelude.print (F.fmap maybeFunctor (Prelude.+ 1) Prelude.Nothing)   -- Nothing

-- Example 7: Using ToDict and DictConversion
example7 :: Prelude.IO ()
example7 = do
  Prelude.putStrLn "\nExample 7: Using ToDict type family and DictConversion class"
  -- Use toDict to automatically convert from typeclass constraint to dictionary
  let eqDict = D.toDict @Prelude.Eq @Prelude.Int
  Prelude.print (E.eq eqDict 42 42)    -- True
  Prelude.print (E.neq eqDict 42 100)  -- True
  
  -- ToDict maps typeclass to dictionary type, allowing type-level programming
  let useDict :: D.ToDict Prelude.Ord Prelude.Int -> Prelude.Int
      useDict dict = O.max dict 10 20
  Prelude.print (useDict (D.toDict @Prelude.Ord @Prelude.Int))  -- 20

main :: Prelude.IO ()
main = do
  Prelude.putStrLn "=== Typeclass Dictionary Examples ==="
  example1
  example2
  example3
  example4
  example5
  example6
  example7
  Prelude.putStrLn "\n=== All examples completed ==="
