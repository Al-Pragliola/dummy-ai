#!/bin/bash
set -e

# Check dummy.txt exists
test -f dummy.txt || { echo "FAIL: dummy.txt does not exist"; exit 1; }

# Check at least 3 lines
lines=$(wc -l < dummy.txt)
[ "$lines" -ge 3 ] || { echo "FAIL: dummy.txt has fewer than 3 lines (got $lines)"; exit 1; }

# Check first line
first=$(head -n1 dummy.txt)
[ "$first" = "Hello from dummy-ai" ] || { echo "FAIL: first line is '$first', expected 'Hello from dummy-ai'"; exit 1; }

# Check file ends with newline
[ "$(tail -c1 dummy.txt | wc -l)" -eq 1 ] || { echo "FAIL: file does not end with a newline"; exit 1; }

echo "All checks passed."
exit 0
