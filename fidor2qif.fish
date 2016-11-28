#!/bin/env fish

# This file takes two arguments
#   1. An input file
#   2. An output file
# The input file shall be a CSV in the format fidor bank delivers it.
# The Output is a QIF file that works with gnucash.

echo "!Type:Cash" > $argv[2]
tail -n +2 $argv[1] \
  | uconv -f ISO-8859-1 \
  | sed -r 's/(.*);(.*);(.*);(.*)/D\1\nM\2 \3\nT\4\n\^/;s/""//' \
  | string trim >> $argv[2]
