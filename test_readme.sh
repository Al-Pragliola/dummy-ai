#!/bin/bash
# Tests for Issue #1: Add "Hello World" to README.md

PASS=0
FAIL=0

fail() {
  echo "FAIL: $1"
  FAIL=$((FAIL + 1))
}

pass() {
  echo "PASS: $1"
  PASS=$((PASS + 1))
}

README="README.md"

# Test 1: README.md exists
if [ -f "$README" ]; then
  pass "README.md exists"
else
  fail "README.md does not exist"
  echo "Results: $PASS passed, $FAIL failed"
  exit 1
fi

# Test 2: Existing project title is preserved
if grep -q "^# dummy-ai" "$README"; then
  pass "Project title '# dummy-ai' is preserved"
else
  fail "Project title '# dummy-ai' is missing"
fi

# Test 3: Hello World heading exists
if grep -q "^## Hello World" "$README"; then
  pass "Contains '## Hello World' heading"
else
  fail "Missing '## Hello World' heading"
fi

# Test 4: Hello World text is present in the document
if grep -q "Hello World" "$README"; then
  pass "'Hello World' text is visible in the document"
else
  fail "'Hello World' text is not found in the document"
fi

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ] || exit 1
