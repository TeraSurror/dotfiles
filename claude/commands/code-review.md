---
description: Detect language and framework, explain best practices, then review code written by ChatGPT/Codex for bugs, antipatterns, and security issues
allowed-tools: [Read, Glob, Grep, Bash]
---

## Context

Current directory: !`pwd`
Files in project root: !`ls -1`
Recent git changes: !`git diff HEAD 2>/dev/null || echo "not a git repo or no changes"`
Git log (last 5 commits): !`git log --oneline -5 2>/dev/null || echo "not a git repo"`
package.json: !`cat package.json 2>/dev/null || echo "not found"`
pyproject.toml: !`cat pyproject.toml 2>/dev/null || echo "not found"`
go.mod: !`cat go.mod 2>/dev/null || echo "not found"`
Cargo.toml: !`cat Cargo.toml 2>/dev/null || echo "not found"`

## Your task

You are a senior engineer conducting a thorough code review. This code was written by ChatGPT and Codex — AI code generators with known failure modes. Follow every step below in order.

### Step 1 — Detect language and framework

Read the dependency files and source to identify:
- Primary language(s) and runtime version
- Framework(s) in use (React, FastAPI, Gin, Express, Django, Next.js, etc.)
- Linter/formatter configuration (eslint, prettier, ruff, golangci-lint, etc.)
- Build toolchain

### Step 2 — Best practices briefing

Before looking at the code, document the key best practices for the detected language and framework. Cover:
- Idiomatic patterns and conventions (e.g. Go error handling, React hooks rules, Python type hints)
- Common pitfalls specific to this stack
- Security considerations (input validation, auth patterns, secrets management)
- Performance guidelines
- Style and naming conventions

This establishes the standard the code will be measured against.

### Step 3 — AI-generated code lens

Since the code was written by ChatGPT and Codex, explicitly scan for these AI generation antipatterns before doing the general review:

- **Hallucinated APIs** — calls to functions, methods, or modules that don't exist or have been deprecated
- **Over-engineering** — unnecessary abstractions, design patterns, or indirection for simple problems
- **Verbose boilerplate** — repetitive code that could be replaced by stdlib or framework utilities
- **Generic variable names** — `data`, `result`, `temp`, `response`, `obj`, `item` that convey no intent
- **Missing error handling** — ignored errors, bare `except`, unhandled promise rejections, unchecked return values
- **Security antipatterns** — SQL injection via string concatenation, XSS via unescaped output, hardcoded secrets, insecure defaults, improper input validation
- **Stdlib re-implementations** — hand-rolling something that already exists in the standard library or framework
- **Plausible but wrong logic** — off-by-one errors, inverted conditions, wrong operator (e.g. `&` vs `&&`), subtle race conditions

### Step 4 — Code review

Walk through the changed or relevant source files. For each file, provide structured findings using these severity levels:

- **Critical** — bugs, security vulnerabilities, data loss risks. Must be fixed before merge.
- **Warning** — logic issues, missing error handling, performance problems. Should be fixed.
- **Suggestion** — style, readability, idiomatic improvements. Nice to have.
- **Praise** — what is done well. Call it out explicitly.

For every Critical and Warning finding:
1. Cite the exact file and line range
2. Explain clearly why it is an issue
3. Provide a concrete fix or corrected code snippet

### Step 5 — Summary

Close with a concise verdict:
- **Quality rating**: 1–5 (1 = needs major rework, 5 = production-ready)
- **Top 3 must-fix items** before this code is merged
- **Confidence level**: how confident you are this code is safe to ship, and why
