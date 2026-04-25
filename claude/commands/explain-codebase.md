---
description: Explore and explain project structure, tech stack, architecture, and workflows for a new contributor
allowed-tools: [Read, Glob, Grep, Bash]
---

## Context

Current directory: !`pwd`
Top-level contents: !`ls -la`
Git log (last 10 commits): !`git log --oneline -10 2>/dev/null || echo "not a git repo"`
package.json: !`cat package.json 2>/dev/null || echo "not found"`
pyproject.toml: !`cat pyproject.toml 2>/dev/null || echo "not found"`
go.mod: !`cat go.mod 2>/dev/null || echo "not found"`
Cargo.toml: !`cat Cargo.toml 2>/dev/null || echo "not found"`
Makefile: !`cat Makefile 2>/dev/null || echo "not found"`
README: !`cat README.md 2>/dev/null || cat README.rst 2>/dev/null || echo "not found"`
Docker/CI files: !`ls docker-compose.yml Dockerfile .github/workflows/*.yml 2>/dev/null || echo "none found"`

## Your task

You are an expert engineer onboarding a new contributor to this codebase. Produce a clear, structured explanation covering every section below. Explore the actual files — do not guess or infer without reading the code.

### Section 1 — Project identity and purpose

Identify:
- What this project does (infer from README, package name, entry points, and source code)
- The primary language(s) and runtime versions
- Whether it is a library, application, CLI tool, service, or monorepo

### Section 2 — Tech stack and frameworks

Examine dependency files (package.json, pyproject.toml, go.mod, Cargo.toml, etc.) and source code to list:
- Core frameworks (React, FastAPI, Gin, Express, Django, etc.)
- Key libraries worth knowing (ORM, HTTP client, validation, logging, etc.)
- Build tools (webpack, vite, esbuild, tsc, poetry, cargo, etc.)
- Test framework and coverage tool
- Linter/formatter configuration (eslint, prettier, ruff, golangci-lint, etc.)

### Section 3 — Directory structure and architecture

Walk the directory tree. For each top-level directory and important sub-directory, explain its purpose and what kind of code lives there. Draw a concise annotated tree, for example:

```
src/
  api/        # HTTP handlers, route definitions
  services/   # Business logic layer
  models/     # Database models and schema
  utils/      # Shared helpers
tests/        # Test suite (mirrors src/ structure)
```

### Section 4 — Key patterns and conventions

Read representative source files to identify:
- How the codebase is structured (layered architecture, feature folders, domain-driven, etc.)
- Naming conventions for files, functions, and variables
- How errors are handled (exceptions, Result types, error codes, etc.)
- How configuration and environment variables are managed
- Any dependency injection or service container patterns

### Section 5 — Development workflows

Provide exact commands for common tasks. Check package.json scripts, Makefile targets, README, and CI config. If a workflow is not defined, say so explicitly rather than guessing.

**Install dependencies:**
```
<exact command>
```

**Run in development mode:**
```
<exact command>
```

**Run the test suite:**
```
<exact command>
```

**Build for production:**
```
<exact command>
```

**Lint / format:**
```
<exact command>
```

### Section 6 — Entry points and request/call flow

Identify the main entry point(s) of the application. Trace a representative request or call through the layers from entry to response/output, referencing the actual file and function names involved.

### Section 7 — What a new contributor should know first

Summarize in bullet points:
- The 3-5 most important files to read to understand the system
- Any non-obvious conventions or gotchas
- Parts of the codebase that are under active development or known to be complex
- How to run the project locally from scratch in the fewest steps
