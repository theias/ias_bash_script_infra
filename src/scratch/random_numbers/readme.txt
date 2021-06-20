This is not a "fantastic" random number generation thing, it's going to
be more biased toward the beginning of the range, but only slightly
if the range itself is small compared to the max random size (32767).

This, for numbers around 60, comes to a percentage of 0.1%, which,
in some cases, might be acceptable for a "purely bash" random number
generator.  (Bash only does integer division) 

./do_random.sh 1000 30 | ./plot_distribution.sh
