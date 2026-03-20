#!/bin/bash
set -e

README="README.md"
ERRORS=0

# Check that README.md exists
if [ ! -f "$README" ]; then
  echo "FAIL: $README does not exist"
  exit 1
fi

# 1. README.md contains a "## Hello World" heading
if ! grep -q '^## Hello World' "$README"; then
  echo "FAIL: README.md does not contain a '## Hello World' heading"
  ERRORS=$((ERRORS + 1))
fi

# 2. The section includes the text "Hello World"
if ! grep -q 'Hello World' "$README"; then
  echo "FAIL: README.md does not contain the text 'Hello World'"
  ERRORS=$((ERRORS + 1))
fi

# 3. The existing content (project title # dummy-ai) is preserved
if ! grep -q '^# dummy-ai' "$README"; then
  echo "FAIL: README.md does not contain the original project title '# dummy-ai'"
  ERRORS=$((ERRORS + 1))
fi

# 4. The change is committed to the main branch
if ! git log --oneline --all --grep="Hello World" | grep -q .; then
  echo "FAIL: No commit found with 'Hello World' in the message"
  ERRORS=$((ERRORS + 1))
fi

if [ "$ERRORS" -gt 0 ]; then
  echo "$ERRORS check(s) failed"
  exit 1
fi

echo "All checks passed"
exit 0
