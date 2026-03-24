#!/bin/bash
set -e

# Check that README.md exists
if [ ! -f "README.md" ]; then
  echo "FAIL: README.md does not exist"
  exit 1
fi

# Check that the original project title is preserved
if ! grep -q "^# dummy-ai" README.md; then
  echo "FAIL: Original project title '# dummy-ai' not found"
  exit 1
fi

# Check that a Hello World heading exists
if ! grep -q "^## Hello World" README.md; then
  echo "FAIL: '## Hello World' heading not found"
  exit 1
fi

# Check that "Hello World" text is present in the file
if ! grep -q "Hello World" README.md; then
  echo "FAIL: 'Hello World' text not found"
  exit 1
fi

echo "All checks passed."
exit 0
