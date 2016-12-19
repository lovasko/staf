module Stats.Foldable
( amean  -- f a -> Maybe a
, min    -- f a -> Maybe a
, max    -- f a -> Maybe a
, var    -- f a -> Maybe a
, stddev -- f a -> Maybe a
, covar  -- f a -> f a -> Maybe a
, correl -- f a -> f a -> Maybe a
) where

import Prelude hiding (min, max)
import Control.Monad (guard)
import Data.List (genericLength)
import qualified Data.Foldable as F

-- | Determine if the Foldable object contains any elements.
isNonEmpty :: (F.Foldable f)
        => f a  -- ^ container
        -> Bool -- ^ decision
isNonEmpty = not . null . F.toList

-- | Number of elements in the Foldable container.
size :: (F.Foldable f, Num n)
     => f a -- ^ container
     -> n   -- ^ size
size = genericLength . F.toList

-- | Find the minimal value of a series.
min :: (F.Foldable f, Ord a)
    => f a     -- ^ population
    -> Maybe a -- ^ minimal value
min xs = guard (isNonEmpty xs) >> return (F.minimum xs)

-- | Find the maximal value of a population.
max :: (F.Foldable f, Ord a)
    => f a     -- ^ population
    -> Maybe a -- ^ maximal value
max xs = guard (isNonEmpty xs) >> return (F.maximum xs)

-- | Compute the arithmetic mean of a population.
amean :: (F.Foldable f, Floating a)
     => f a     -- ^ population
     -> Maybe a -- ^ arithmetic mean
amean xs = guard (isNonEmpty xs) >> return (F.sum xs / size xs)

-- | Compute the standard deviation of a population.
stddev :: (F.Foldable f, Floating a)
       => f a     -- ^ population
       -> Maybe a -- ^ standard deviation
stddev = fmap sqrt . var

-- | Compute the variance of a population.
var :: (F.Foldable f, Floating a)
    => f a     -- ^ population
    -> Maybe a -- ^ variance
var xs = do
  mean <- amean xs
  return $ F.foldr (\x v -> v + (x-mean) * (x-mean)) 0 xs / size xs

-- Compute the covariance of two populations.
covar :: (F.Foldable f, Floating a)
      => f a     -- ^ first population
      -> f a     -- ^ second population
      -> Maybe a -- ^ covariance
covar xs ys = do
  xmean <- amean xs
  ymean <- amean ys
  let xs' = map (subtract xmean) (F.toList xs)
  let ys' = map (subtract ymean) (F.toList ys)
  return $ F.sum (zipWith (*) xs' ys') / size xs

-- | Compute the correlation of two populations.
correl :: (F.Foldable f, Floating a)
       => f a     -- ^ first population
       -> f a     -- ^ second population
       -> Maybe a -- ^ correlation
correl xs ys = do
  sdx <- stddev xs
  sdy <- stddev ys
  cv  <- covar xs ys
  return $ cv / sdx * sdy
