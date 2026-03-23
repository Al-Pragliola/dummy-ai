#!/bin/bash
set -e

# 1. dummy.txt exists in repository root
test -f dummy.txt || { echo "FAIL: dummy.txt does not exist"; exit 1; }

# 2. File contains at least 3 lines of text
lines=$(wc -l < dummy.txt)
[ "$lines" -ge 3 ] || { echo "FAIL: dummy.txt has fewer than 3 lines (got $lines)"; exit 1; }

# 3. First line is "Hello from dummy-ai"
first=$(head -n1 dummy.txt)
[ "$first" = "Hello from dummy-ai" ] || { echo "FAIL: first line is not 'Hello from dummy-ai'"; exit 1; }

# 4. File ends with a newline
[ "$(tail -c1 dummy.txt | wc -l)" -eq 1 ] || { echo "FAIL: file does not end with a newline"; exit 1; }

echo "All checks passed."
exit 0
