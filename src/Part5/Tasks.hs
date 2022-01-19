module Part5.Tasks where

import Util(notImplementedYet)

-- Реализуйте левую свёртку
myFoldl :: (b -> a -> b) -> b -> [a] -> b
myFoldl f acc [] = acc
myFoldl f acc (x:xs) = myFoldl f (f acc x) xs

-- Реализуйте правую свёртку
myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr f acc [] = acc
myFoldr f acc (x:xs) = f x (myFoldr f acc xs)

-- Используя реализации свёрток выше, реализуйте все остальные функции в данном файле

myMap :: (a -> b) -> [a] -> [b]
myMap f = myFoldr ((:) . f) []

myConcatMap :: (a -> [b]) -> [a] -> [b]
myConcatMap f = myFoldr ((++) . f) []

myConcat :: [[a]] -> [a]
myConcat = myFoldr (++) []

myReverse :: [a] -> [a]
myReverse = myFoldr (\x list -> list ++ [x]) []

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter p = myFoldr (\x list -> if p x then x:list else list) []

myPartition :: (a -> Bool) -> [a] -> ([a], [a])
myPartition p list = (myFilter p list, myFilter (not . p) list)

