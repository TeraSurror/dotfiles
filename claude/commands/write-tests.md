---
description: Detect test framework, fix failing tests, analyze coverage, and write new tests to reach ~100% coverage
allowed-tools: [Read, Glob, Grep, Bash]
---

## Context

Current directory: !`pwd`
Files in project root: !`ls -1`
Existing test files: !`find . -type f \( -name "*.test.*" -o -name "*.spec.*" -o -name "*_test.*" -o -name "test_*.py" \) -not -path "*/node_modules/*" -not -path "*/.git/*" 2>/dev/null | head -40`
package.json: !`cat package.json 2>/dev/null || echo "not found"`
pyproject.toml / setup.cfg: !`cat pyproject.toml 2>/dev/null || cat setup.cfg 2>/dev/null || echo "not found"`
go.mod: !`cat go.mod 2>/dev/null || echo "not found"`

## Your task

You are a senior engineer tasked with achieving near-complete test coverage for this codebase. Follow every step below in order. Do not skip steps.

### Step 1 — Detect the testing framework

Examine the project root, package.json, pyproject.toml, go.mod, and any existing test files to determine:
- Language(s): JavaScript/TypeScript, Python, Go, or other
- Test runner: Jest, Vitest, Mocha, pytest, Go test, or other
- Coverage tool: Istanbul/nyc, jest --coverage, pytest-cov, go test -cover, or other
- Where tests live (co-located, `__tests__/`, `tests/`, `*_test.go`, etc.)
- Any existing test scripts in package.json or Makefile

### Step 2 — Run existing tests and identify failures

Run the test suite with the detected runner. Capture all output. Identify:
- Which tests pass and which fail
- The failure messages and stack traces for each failing test
- Whether failures are in test logic, in source code, or due to missing dependencies/setup

Use the appropriate command for the detected stack:
- JS/TS (Jest): `npx jest --no-coverage 2>&1` or `npm test 2>&1`
- JS/TS (Vitest): `npx vitest run 2>&1`
- Python: `python -m pytest -v 2>&1`
- Go: `go test ./... 2>&1`

### Step 3 — Fix failing tests

For each failing test:
1. Read the source file being tested
2. Read the test file
3. Understand the root cause of the failure (changed API, wrong assertion, missing mock, etc.)
4. Fix the test or the source code, depending on what is actually broken
5. Re-run the specific failing test to confirm it now passes before moving on

Do not move to Step 4 until all pre-existing tests pass.

### Step 4 — Analyze current coverage

Run coverage analysis with the detected tool:
- Jest: `npx jest --coverage --coverageReporters=text 2>&1`
- Vitest: `npx vitest run --coverage 2>&1`
- pytest: `python -m pytest --cov=. --cov-report=term-missing 2>&1`
- Go: `go test ./... -coverprofile=coverage.out 2>&1 && go tool cover -func=coverage.out 2>&1`

Identify:
- Overall coverage percentage
- Files/packages with the lowest coverage
- Specific uncovered lines (branches, error paths, edge cases)

### Step 5 — Write new tests to reach ~100% coverage

For each under-covered file, in order of lowest coverage first:
1. Read the source file carefully to understand all exported functions, classes, and their branches
2. Write tests that cover:
   - The happy path for each function/method
   - All error paths and thrown exceptions
   - Edge cases: empty inputs, null/nil/undefined, boundary values, zero, negative numbers
   - Each branch of conditional logic
3. Place new tests in the same location as existing tests for that file (co-located or in the `tests/` directory — match the existing convention)
4. Use the same testing style, imports, describe/it structure, and assertion library already present in the codebase

After writing all new tests, run the full suite with coverage again to confirm the improvement.

### Output

Summarize:
- Framework and coverage tool detected
- Tests that were failing and how you fixed them
- Coverage percentage before and after
- New test files or test cases added
