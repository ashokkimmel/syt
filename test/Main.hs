{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Data.Constraint.Dict
import Data.Bifunctor (Bifunctor)

-- Test that the type families work as expected
-- These definitions demonstrate that the type families resolve correctly

-- For 0-ary constraints:
-- ConstraintToDict0 Monoid should be MonoidDict
testMonoidDict :: ConstraintToDict0 Monoid Int
testMonoidDict = MonoidDict 0 (+)

testSemigroupDict :: ConstraintToDict0 Semigroup String
testSemigroupDict = SemigroupDict (++)

-- For 1-ary constraints:
-- ConstraintToDict1 Functor should be FunctorDict
testFunctorDict :: ConstraintToDict1 Functor []
testFunctorDict = FunctorDict map

testApplicativeDict :: ConstraintToDict1 Applicative Maybe
testApplicativeDict = ApplicativeDict Just (\mf mx -> case mf of
                                                         Nothing -> Nothing
                                                         Just f -> fmap f mx)

testMonadDict :: ConstraintToDict1 Monad Maybe
testMonadDict = MonadDict Just (\mx f -> case mx of
                                           Nothing -> Nothing
                                           Just x -> f x)

testFoldableDict :: ConstraintToDict1 Foldable []
testFoldableDict = FoldableDict foldr

-- For 2-ary constraints:
-- ConstraintToDict2 Bifunctor should be BifunctorDict
testBifunctorDict :: ConstraintToDict2 Bifunctor (,)
testBifunctorDict = BifunctorDict (\f g (x, y) -> (f x, g y))

main :: IO ()
main = do
  putStrLn "Type family tests compiled successfully!"
  
  -- Test 0-ary dictionaries
  let MonoidDict mempty' mappend' = testMonoidDict
  print $ mappend' mempty' 42  -- Should print 42
  
  let SemigroupDict append' = testSemigroupDict
  print $ append' "Hello " "World"  -- Should print "Hello World"
  
  -- Test 1-ary dictionaries
  let FunctorDict fmap' = testFunctorDict
  print $ fmap' (+1) [1,2,3]  -- Should print [2,3,4]
  
  let ApplicativeDict pure' _ = testApplicativeDict
  print $ pure' 42  -- Should print "Just 42"
  
  let MonadDict return' _ = testMonadDict
  print $ return' "Hello"  -- Should print "Just \"Hello\""
  
  let FoldableDict foldr' = testFoldableDict
  print $ foldr' (+) 0 [1,2,3]  -- Should print 6
  
  -- Test 2-ary dictionaries
  let BifunctorDict bimap' = testBifunctorDict
  print $ bimap' (+1) (*2) (1, 2)  -- Should print (2,4)
  
  putStrLn "All tests passed!"
