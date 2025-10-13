{-# LANGUAGE RankNTypes #-}

-- | Datatype representation of the Show typeclass
module Data.Typeclass.Show where

import qualified Prelude

-- | A dictionary containing the methods of the Show typeclass
data ShowDict a = ShowDict
  { showsPrec :: Prelude.Int -> a -> Prelude.ShowS  -- ^ Convert to string with precedence
  , show      :: a -> Prelude.String                -- ^ Convert to string
  , showList  :: [a] -> Prelude.ShowS               -- ^ Convert a list to string
  }

-- | Construct a Show dictionary from just the show function
mkShow :: (a -> Prelude.String) -> ShowDict a
mkShow showFunc = ShowDict
  { showsPrec = \_ x -> Prelude.showString (showFunc x)
  , show      = showFunc
  , showList  = \xs -> Prelude.showString "[" Prelude.. showListImpl xs Prelude.. Prelude.showString "]"
  }
  where
    showListImpl [] = Prelude.id
    showListImpl [x] = Prelude.showString (showFunc x)
    showListImpl (x:xs) = Prelude.showString (showFunc x) Prelude.. Prelude.showString "," Prelude.. showListImpl xs

-- | Standard Show dictionary for any type with a Prelude.Show instance
fromPreludeShow :: Prelude.Show a => ShowDict a
fromPreludeShow = ShowDict
  { showsPrec = Prelude.showsPrec
  , show      = Prelude.show
  , showList  = Prelude.showList
  }
