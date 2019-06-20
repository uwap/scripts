#!/usr/bin/env fish

# This file takes two arguments
#   1. An input file
#   2. An output file
# The input file shall be a CSV in the format fidor bank delivers it.
# The Output is a QIF file that works with gnucash and ynab.

set csvfile $argv[1]
if set -q argv[2]
  set qiffile $argv[2]
else
  set qiffile (string join "." (string split -r -m1 . $csvfile)[1] "qif")
end

echo "!Type:Bank" > $qiffile
tail -n +2 $csvfile \
 # | uconv -f ISO-8859-1 \
  | sed -r 's/(.*);(.*);(.*);(.*)/D\1\nM\2\nP\3\nT\4\n\^/;s/""//' \
  | string trim >> $qiffile
