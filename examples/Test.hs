-----------------------------------------------------------------------------
-- |
-- Module      :  Test
-- Copyright   :  (c) Simon Marlow 2002
-- License     :  BSD-style
-- 
-- Maintainer  :  libraries@haskell.org
-- Stability   :  provisional
-- Portability :  portable
--
-- This module illustrates & tests most of the features of Haddock.
-- Testing references from the description: 'T', 'f', 'g', 'Visible.visible'.
--
-----------------------------------------------------------------------------

-- This is plain comment, ignored by Haddock.

module Test ( 

	-- Section headings are introduced with '-- *':
	-- * Type declarations

	-- Subsection headings are introduced with '-- **' and so on.
	-- ** Data types
	T(..), T2, T3(..), T4(..), T5(..),
	N1(..), N2(..), N3(..), N4, N5(..), N6(..), N7(..),

	-- ** Records
	R(..),

	-- * Class declarations
	C(a,b), D(..), E, F(..),

	-- * Function types
	f, g,

	-- $aux2
	-- * Auxiliary stuff

	-- $aux1

	-- $aux2

	-- $aux3

	-- $aux4

	-- $aux5

	-- | This is some inline documentation in the export list
	--
	-- > a code block using bird-tracks
	-- > each line must begin with > (which isn\'t significant unless it
	-- > is at the beginning of the line).

	-- * A hidden module
	module Hidden,

	-- * A visible module
	module Visible,

	{-| nested-style doc comments -}

	-- * Existential \/ Universal types
	Ex(..),

	-- * Type signatures with argument docs
	k, l, m, n, o,
   ) where


-- | This comment applies to the /following/ declaration
-- and it continues until the next non-comment line
data T a b
 = A Int (Maybe Float) -- ^ This comment describes the 'A' constructor
 | -- | This comment describes the 'B' constructor
   B (T a b, T Int Float) -- ^ 

-- | An abstract data declaration
data T2 a b = T2 a b

-- | A data declaration with no documentation annotations on the constructors
data T3 a b = A1 a | B1 b

-- A data declaration with no documentation annotations at all
data T4 a b = A2 a | B2 b

-- A data declaration documentation on the constructors only
data T5 a b
  = A3 a -- ^ documents 'A3'
  | B3 b -- ^ documents 'B3'

-- | A newtype
newtype N1 a b = N1 (a b)

-- | A newtype with a fieldname
newtype N2 a b = N2 {n :: a b}

-- | A newtype with a fieldname, documentation on the field
newtype N3 a b = N3 {n3 :: a b -- ^ this is the 'n3' field 
		    }

-- | An abstract newtype - we show this one as data rather than newtype because
-- the difference isn\'t visible to the programmer for an abstract type.
newtype N4 a b = N4 a

newtype N5 a b = N5 {n5 :: a b -- ^ no docs on the datatype or the constructor
		    }

newtype N6 a b = N6 {n6 :: a b
		    }
		 -- ^ docs on the constructor only

-- | docs on the newtype and the constructor
newtype N7 a b = N7 {n7 :: a b
		    }
		-- ^ The 'N7' constructor
		 

class (D a) => C a  where
   -- |this is a description of the 'a' method
   a :: Int
   b :: Float
   -- ^ this is a description of the 'b' method
   c :: Double -- c is hidden in the export list

-- ^ This comment applies to the /previous/ declaration (the 'C' class)

class D a where
   d :: T a b
   e :: (a,a)
-- ^ This is a class declaration with no separate docs for the methods

instance D Int

class E a where
  ee :: Int
-- ^ This is a class declaration with no methods (or no methods exported)

-- This is a class declaration with no documentation at all
class F a where
  ff :: Float

-- | This is the documentation for the 'R' record, which has four fields,
-- 'p', 'q', 'r', and 's'.
data R = 
  -- | This is the 'C1' record constructor, with the following fields:
  C1 { p :: Int -- ^ This comment applies to the 'p' field
     , q :: forall a . a->a  -- ^ This comment applies to the 'q' field
     , -- | This comment applies to both 'r' and 's'
       r,s :: Int
     }
  | C2 { t :: T1 -> T2 -> T3 -> T4 -> T5,
       u,v :: Int
     }
  -- ^ This is the 'C2' record constructor, also with some fields:

-- These section headers are only used when there is no export list to
-- give the structure of the documentation:

-- * This is a section header (level 1)
-- ** This is a section header (level 2)
-- *** This is a section header (level 3)

{-|
In a comment string we can refer to identifiers in scope with
single quotes like this: 'T', and we can refer to modules by
using double quotes: "Foo".  We can add emphasis /like this/.

   * This is a bulleted list

   - This is the next item (different kind of bullet)

   (1) This is an ordered list
 
   2. This is the next item (different kind of bullet)

@
     This is a block of code, which can include other markup: 'R'
     formatting
               is
                 significant
@

> this is another block of code

We can also include URLs in documentation: <http://www.haskell.org/>.
-}

f :: C a => Int -> Int


-- | we can export foreign declarations too
foreign import ccall g :: Int -> IO CInt

-- | this doc string has a parse error in it: \'
h :: Int
h = 42


-- $aux1 This is some documentation that is attached to a name ($aux1)
-- rather than a source declaration.  The documentation may be
-- referred to in the export list using its name.
--
-- @ code block in named doc @

-- $aux2 This is some documentation that is attached to a name ($aux2)

-- $aux3
-- @ code block on its own in named doc @

-- $aux4
--
-- @ code block on its own in named doc (after newline) @

{- $aux5 a nested, named doc comment

   with a paragraph,

   @ and a code block @
-}

-- | A data-type using existential\/universal types
data Ex a 
  = forall b . C b => Ex1 b
  | forall b . Ex2 b
  | C a => Ex3 b
  | Ex4 (forall a . a -> a)

-- | This is a function with documentation for each argument
k :: T 		-- ^ This argument has type 'T'
  -> T2 	-- ^ This argument has type 'T2'
  -> (T3 -> T4) -- ^ This argument has type @T3 -> T4@
  -> T5		-- ^ This argument has a very long description that should
		-- hopefully cause some wrapping to happen when it is finally
		-- rendered by Haddock in the generated HTML page.
  -> IO ()	-- ^ This is the result type

-- This function has arg docs but no docs for the function itself
l :: (Int, Int, Float) -- ^ takes a triple
  -> Int -- ^ returns an 'Int'

-- | This function has some arg docs 
m :: R
  -> N1		-- ^ one of the arguments
  -> IO Int	-- ^ and the return value

-- | This function has some arg docs but not a return value doc
n :: R		-- ^ one of the arguments, an 'R'
  -> N1		-- ^ one of the arguments
  -> IO Int

-- | A foreign import with argument docs
foreign import ccall unsafe 
 o :: Float  -- ^ The input float
   -> IO Float  -- ^ The output float