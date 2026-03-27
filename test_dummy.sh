#!/usr/bin/env bash
# Tests for dummy.txt as described in Issue #2

set -euo pipefail

PASS=0
FAIL=0

assert() {
  local description="$1"
  local result="$2"
  if [ "$result" = "true" ]; then
    echo "PASS: $description"
    PASS=$((PASS + 1))
  else
    echo "FAIL: $description"
    FAIL=$((FAIL + 1))
  fi
}

# Test 1: dummy.txt exists in the repository root
assert "dummy.txt exists in the repository root" \
  "$([ -f dummy.txt ] && echo true || echo false)"

# Test 2: The file contains at least 3 lines of text
if [ -f dummy.txt ]; then
  line_count=$(wc -l < dummy.txt)
  assert "dummy.txt contains at least 3 lines" \
    "$([ "$line_count" -ge 3 ] && echo true || echo false)"
else
  assert "dummy.txt contains at least 3 lines" "false"
fi

# Test 3: The first line is 'Hello from dummy-ai'
if [ -f dummy.txt ]; then
  first_line=$(head -n 1 dummy.txt)
  assert "First line is 'Hello from dummy-ai'" \
    "$([ "$first_line" = "Hello from dummy-ai" ] && echo true || echo false)"
else
  assert "First line is 'Hello from dummy-ai'" "false"
fi

# Test 4: The file ends with a newline character
if [ -f dummy.txt ]; then
  # tail -c 1 returns empty string when file ends with newline (due to command substitution)
  last_char=$(tail -c 1 dummy.txt | wc -l)
  assert "File ends with a newline character" \
    "$([ "$last_char" -eq 1 ] && echo true || echo false)"
else
  assert "File ends with a newline character" "false"
fi

# Test 5: README.md still exists (no existing files deleted)
assert "README.md still exists (no existing files modified or deleted)" \
  "$([ -f README.md ] && echo true || echo false)"

echo ""
echo "Results: $PASS passed, $FAIL failed"

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
