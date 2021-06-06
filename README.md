# grep.sh

This is a reimplementation of grep(1) in bash, made to complete exercisim.io's challenge.

You can read though my through process on my website [hannibaladportas.dev](https://hannibaladportas.dev/posts/exercism_bash/)

# Installing

It is a bash script. Put it in your path and make sure you have bash installed.

# Running

``` sh
grep.sh [OPTION...] PATTERN FILE
```

# Options


 - -n: Print the line numbers of each matching line.
 - -l: Print only the names of files that contain at least one matching line.
 - -i: Match line using a case-insensitive comparison.
 - -v: Invert the program – collect all lines that fail to match the pattern.
 - -x: Only match entire lines, instead of lines that contain a match.
