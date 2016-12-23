[![Build Status](https://travis-ci.org/lovasko/staf.svg?branch=master)](https://travis-ci.org/lovasko/staf)
[![Code Climate](https://codeclimate.com/github/lovasko/staf/badges/gpa.svg)](https://codeclimate.com/github/lovasko/staf)
# Stats.Foldable
A pure Haskell module that implements a safe interface to a set of statistical
computations for all `Foldable` containers. Folding (i.e. _reducing_ or
_crushing_) is a great fit for statistics, where a full data set has to be
reduced to a single object that represents the set in a meaningful way.

## Install
There are two standard ways of obtainig the module:
 * by cloning the GitHub repository: `git clone https://github.com/lovasko/staf`
 * by using the central Hackage server: `cabal install staf`

## API
All `staf` functions use the `Maybe` type to represent a failure (e.g. an empty
container provided as the input). All numerical arguments are limited to the
least-assuming typeclass. The module exports the following 7 functions:

#### Arithmetic mean
```haskell
amean :: (F.Foldable f, Floating a)
     => f a     -- ^ population
     -> Maybe a -- ^ arithmetic mean
```

#### Minimum
```haskell
min :: (F.Foldable f, Ord a)
    => f a     -- ^ population
    -> Maybe a -- ^ minimal value
```

#### Maximum
```haskell
max :: (F.Foldable f, Ord a)
    => f a     -- ^ population
    -> Maybe a -- ^ maximal value
```

#### Variance
```haskell
var :: (F.Foldable f, Floating a)
    => f a     -- ^ population
    -> Maybe a -- ^ variance
```

#### Standard deviation
```haskell
stddev :: (F.Foldable f, Floating a)
       => f a     -- ^ population
       -> Maybe a -- ^ standard deviation
```

#### Covariance
```haskell
covar :: (F.Foldable f, Floating a)
      => f a     -- ^ first population
      -> f a     -- ^ second population
      -> Maybe a -- ^ covariance
```

#### Pearson correlation
```haskell
correl :: (F.Foldable f, Floating a)
       => f a     -- ^ first population
       -> f a     -- ^ second population
       -> Maybe a -- ^ correlation
```

## Numerical stability
There is no current stability guarantee in any of the provided algorithms.

## License
The `staf` module is licensed under the [2-clause BSD license](LICENSE). In
case that any other licensing is needed, feel free to contact the author.

## Author
Daniel Lovasko <daniel.lovasko@gmail.com>
