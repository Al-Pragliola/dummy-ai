#!/bin/bash
set -e

# Check README.md exists
if [ ! -f "README.md" ]; then
  echo "FAIL: README.md does not exist"
  exit 1
fi

# Check existing project title is preserved
if ! grep -q "^# dummy-ai" README.md; then
  echo "FAIL: Project title '# dummy-ai' not found in README.md"
  exit 1
fi

# Check for ## Hello World heading
if ! grep -q "^## Hello World" README.md; then
  echo "FAIL: '## Hello World' heading not found in README.md"
  exit 1
fi

# Check "Hello World" text is present in the content
if ! grep -q "Hello World" README.md; then
  echo "FAIL: 'Hello World' text not found in README.md"
  exit 1
fi

echo "All checks passed."
exit 0
