module Part3.Tasks where

import Util (notImplementedYet)
import Data.List
import Data.Ord
import Data.Map hiding (map)
import Data.Function

-- Функция finc принимает на вход функцию f и число n и возвращает список чисел [f(n), f(n + 1), ...]
finc :: (Int -> a) -> Int -> [a]
finc f n = f n : finc f (n + 1)

-- Функция ff принимает на вход функцию f и элемент x и возвращает список [x, f(x), f(f(x)), f(f(f(x))) ...]
ff :: (a -> a) -> a -> [a]
ff f x = x : map f (ff f x)

digs :: Int -> [Int]
digs 0 = []
digs x = digs (x `div` 10) ++ [x `mod` 10]

-- Дан список чисел. Вернуть самую часто встречающуюся *цифру* в этих числах (если таковых несколько -- вернуть любую)
mostFreq :: [Int] -> Int
mostFreq = head . head . sortOn (Down . length) . group . sort . concatMap digs

-- Дан список lst. Вернуть список элементов из lst без повторений, порядок может быть произвольным.
uniq :: (Eq a) => [a] -> [a]
uniq [] = []
uniq (x:xs)
    | x `elem` xs   = uniq xs
    | otherwise     = x : uniq xs

myGroup :: (Eq a) => [(a, b)] -> [(a, [b])]
myGroup = map (\l -> (fst . head $ l, map snd l)) . groupBy ((==) `on` fst)

-- Функция grokBy принимает на вход список Lst и функцию F и каждому возможному
-- значению результата применения F к элементам Lst ставит в соответствие список элементов Lst,
-- приводящих к этому результату. Результат следует представить в виде списка пар.
grokBy :: (Eq k) => (a -> k) -> [a] -> [(k, [a])]
grokBy f l =
    let
        fres = uniq (map f l)
        res = [(x, y) | x <- fres, y <- l, f y == x]
        r = myGroup res
    in
        r
