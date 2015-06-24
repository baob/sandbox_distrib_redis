# README

Distributing arbitrary work (primes) using resque

## TODO

Seem to have several concepts mixed up:

Prime Results List 

1) Need include? to check for algorithm integrity (not adding twice)

2) Can be implemented as set irrespective of whether we do 1

3) Needs to take account of adding non-primes so we can do 

4) Needs to exist in two varieties (a) straight list, no assumptions,
and (b) answer must be consecutive primes regardless of arrival order

5) REDIS implemementation sounds like a sorted set (Z)

Integer Queue

1) Don't need include?

2) Probably not a set as we need blocking pop eventually

3) non-primes not relevant

4) no consecutive/non-consectutive considerations, but must be sure
we're not testing larger results than we're allowed (watch biggest
consecutive prime and WRITE TEST

5) REDIS implementation sounds like a list (L)

