module Puzzels where

-- length
length' a = foldr (\_ n -> 1 + n) 0 a

-- or
or' r = foldr (||) False r

-- elem
elem' x xs = foldr (||) False (map (x ==) xs)

-- map
map' m = foldr (\a b -> m a : b) []

-- ++
plusplus x xs = foldr (:) xs x

-- reverse right
reverseR r = foldr (\ a b -> b ++ [a]) [] r

-- reverse left
reverseL l = foldl (\ b a -> a:b) [] l

-- !!
-- expert :: [a] -> Int -> a
-- expert a = foldl (\ )

-- isPalindrome
isPalindrome p = p == reverse p

-- fibonacci
fibonacci = 0 : scanl (+) 1 fibonacci