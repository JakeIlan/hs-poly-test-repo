module Part1.Tasks where

import Util(notImplementedYet)
import Data.List

factorial :: Double -> Double
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- синус числа (формула Тейлора)
mySin :: Double -> Double
mySin x = sinCalc x 0
    where
        sinCalc :: Double -> Double -> Double
        sinCalc x n
            | n == 20       = (-1)**n * x**(2*n + 1) / factorial (2*n + 1)
            | otherwise     = (-1)**n * x**(2*n + 1) / factorial (2*n + 1) + sinCalc x (n + 1)

-- косинус числа (формула Тейлора)
myCos :: Double -> Double
myCos x = cosCalc x 0
    where
        cosCalc :: Double -> Double -> Double
        cosCalc x n
            | n == 19       = (-1)**n * x**(2*n) / factorial (2*n)
            | otherwise     = (-1)**n * x**(2*n) / factorial (2*n) + cosCalc x (n + 1)

-- наибольший общий делитель двух чисел
myGCD :: Integer -> Integer -> Integer
myGCD a b
    | a == 0        = abs b
    | b == 0        = abs a
    | mod a b == 0  = abs b
    | mod b a == 0  = abs a
    | abs a > abs b = myGCD (mod a b) b
    | otherwise     = myGCD a (mod b a)

-- является ли дата корректной с учётом количества дней в месяце и
-- вискокосных годов?
isDateCorrect :: Integer -> Integer -> Integer -> Bool
isDateCorrect day month year =
    (day > 0 && month > 0 && year > 0) &&
    (month `elem` [1,3,5,7,8,10,12] && day <= 31 ||
    month `elem` [4,6,9,11] && day <= 30 ||
    month == 2 && (year `mod` 400 == 0 || year `mod` 4 == 0 && year `mod` 100 /= 0) && day <= 29 ||
    month == 2 && day <= 28)



-- возведение числа в степень, duh
-- готовые функции и плавающую арифметику использовать нельзя
myPow :: Integer -> Integer -> Integer
myPow x 0 = 1
myPow x power = x * myPow x (power - 1)

-- является ли данное число простым?
isPrime :: Integer -> Bool
isPrime x = primeCalc x (x-1)
    where
        primeCalc x n
            | x < 2     = False
            | x == 2    = True
            | n == 2    = x `mod` n /= 0
            | otherwise = x `mod` n /= 0 && primeCalc x (n-1)

type Point2D = (Double, Double)

-- рассчитайте площадь многоугольника по формуле Гаусса
-- многоугольник задан списком координат
shapeArea :: [Point2D] -> Double
shapeArea [] = 0
shapeArea points =
    let
        xs = map fst points
        ys = map snd points
        a = [x * y | x <- init xs, y <- tail ys]
        a' = sum a + last xs * head ys
        b = [x * y | x <- tail xs, y <- init ys]
        b' = sum b + head xs * last ys
    in
        abs(a' - b') / 2



-- треугольник задан длиной трёх своих сторон.
-- функция должна вернуть
--  0, если он тупоугольный
--  1, если он остроугольный
--  2, если он прямоугольный
--  -1, если это не треугольник
triangleKind :: Double -> Double -> Double -> Integer
triangleKind a b c = evalTriangle (sort [a, b, c])
    where
        evalTriangle :: [Double] -> Integer
        evalTriangle sides
            | last sides > sum (init sides)   = -1
            | last sides^2 == sum (zipWith (^) (init sides) [2,2]) = 2
            | last sides^2 < sum (zipWith (^) (init sides) [2,2]) = 1
            | last sides^2 > sum (zipWith (^) (init sides) [2,2]) = 0
            | otherwise = -1
