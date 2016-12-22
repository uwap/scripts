#!/bin/env fish

# This converts a CVS in the format the fidor bank uses
# and converts it to QIF using fidor2qif and then
# uses https://github.com/wesabe/fixofx to convert it
# to OFX.

. ~/Projekte/Skripte/fidor2qif.fish $argv[1] /tmp/2ofxtmp
/bin/env python2 fixofx.py -f /tmp/2ofxtmp --curdef=EUR --lang=DEU --dayfirst > $argv[2]
