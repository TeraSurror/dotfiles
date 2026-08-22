# Neovim + Tmux Master Workflow Guide
### *Staff-Engineer Grade Development Environment*

---

## 1. The Mental Model & Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                           TMUX                                  │
│  Session Manager  •  Windows (Tabs)  •  Panes (Splits)          │
│                                                                 │
│   ┌──────────────────────────────┬───────────────────────────┐  │
│   │                              │                           │  │
│   │           NEOVIM             │      PERSISTENT CLI       │  │
│   │  • LSP Intelligence          │  • Dev Server / Logs      │  │
│   │  • DAP Debugger (IntelliJ)   │  • DB / Docker containers │  │
│   │  • Neogit & Diffview         │  • Build monitoring       │  │
│   │  • Harpoon 2 & Telescope     │                           │  │
│   │  • Overseer Task Runner      │                           │  │
│   │  • Neotest Suite             │                           │  │
│   │                              │                           │  │
│   └──────────────────────────────┴───────────────────────────┘  │
│    ◄── Seamless Navigation via Ctrl+h / Ctrl+j / Ctrl+k / Ctrl+l ──►│
└─────────────────────────────────────────────────────────────────┘
```

- **Tmux**: Global multiplexer managing persistent project sessions, long-running processes, and splits.
- **Neovim**: High-performance modal editor configured with modular `lazy.nvim` plugin architecture.
- **LSP / Treesitter / Mason**: Semantic code intelligence, syntax parsing, and automated toolchain management.
- **DAP (Debug Adapter Protocol)**: Full visual debugging with call stacks, watches, scopes, and REPL.
- **Overseer**: Run configurations and build task runner supporting `.vscode/tasks.json` and `.vscode/launch.json`.

---

## 2. Tmux & Split Navigation

Navigation between **Neovim windows** and **Tmux panes** is 100% unified with `vim-tmux-navigator`. You never have to think about whether you are inside Vim or Tmux.

| Action | Keybinding |
|---|---|
| Navigate Left (Nvim split or Tmux pane) | `Ctrl + h` |
| Navigate Down (Nvim split or Tmux pane) | `Ctrl + j` |
| Navigate Up (Nvim split or Tmux pane) | `Ctrl + k` |
| Navigate Right (Nvim split or Tmux pane) | `Ctrl + l` |

### Tmux Essentials (Prefix: `Ctrl + b`)

| Action | Keybinding | Notes |
|---|---|---|
| Split Vertically (side-by-side) | `<prefix> \|` | Opens in current working directory |
| Split Horizontally (top/bottom) | `<prefix> -` | Opens in current working directory |
| Zoom Pane (Toggle Fullscreen) | `<prefix> z` | Focus temporarily on one pane |
| New Window (tab) | `<prefix> c` | Creates new tab |
| Switch to Window `N` | `<prefix> 1..9` | Direct tab jump |
| Session Picker | `<prefix> s` | Interactive tree of all project sessions |
| Detach Session | `<prefix> d` | Keeps background jobs running |
| Reload Tmux Config | `<prefix> r` | Applies `~/.tmux.conf` changes |

---

## 3. Neovim: Fast Navigation & File Exploration

### A. Instant Working-Set Context Switching (Harpoon 2)
Staff engineers pin their active 3–4 working files rather than repeatedly fuzzy searching.

| Action | Keybinding | Workflow |
|---|---|---|
| **Pin current file** | `<leader>a` | Adds file to Harpoon list |
| **Open Harpoon menu** | `<leader>h` | Visual list of pinned files |
| **Jump to file 1** | `<leader>1` | Instant 1-keystroke jump |
| **Jump to file 2** | `<leader>2` | Instant 1-keystroke jump |
| **Jump to file 3** | `<leader>3` | Instant 1-keystroke jump |
| **Jump to file 4** | `<leader>4` | Instant 1-keystroke jump |

### B. Fuzzy Finding (Telescope)

| Action | Keybinding | Description |
|---|---|---|
| Find Files | `<leader>ff` | Search file names in project |
| Find All Files | `<leader>fa` | Search all files (including hidden/ignored) |
| Live Grep | `<leader>fg` | Full text search across codebase |
| Grep Word Under Cursor | `<leader>fw` | Find all occurrences of current symbol |
| Open Buffers | `<leader>fb` | Switch active open buffers |
| Recent Files | `<leader>fr` | Jump to recently opened files |
| Document Symbols | `<leader>fs` | Functions, classes, variables in current file |
| Workspace Symbols | `<leader>fS` | Symbols across entire project |
| Help Tags | `<leader>fh` | Neovim documentation search |
| Resume Search | `<leader>f/` | Reopen last search with previous query |

### C. Motion & Structure Navigation
- **Flash Jump (`s` + 2 chars)**: Jump to any visible symbol or word on the screen instantly.
- **Flash Treesitter (`S`)**: Select syntax blocks (functions, loops, expressions) visually.
- **Aerial Code Outline (`<leader>co`)**: Opens a persistent sidebar showing functions, types, and classes (identical to IntelliJ's *Structure* tool window). Jump between symbols with `{` and `}`.
- **File Explorer (`<leader>e`)**: Toggle file tree (`<leader>ef` reveals active file in tree).

---

## 4. Multi-Language Code Intelligence (LSP)

Configured for **Python**, **JavaScript/TypeScript**, **Go**, **Rust**, **C**, and **C++**.

### Navigation & Inspection

| Action | Keybinding | Description |
|---|---|---|
| **Go to Definition** | `gd` | Jump directly to declaration/source |
| **Go to Declaration** | `gD` | Jump to header/type declaration |
| **Find References** | `gr` | Open Telescope reference list |
| **Go to Implementation** | `gi` | Jump to concrete interface implementation |
| **Type Definition** | `gy` | Jump to type definition |
| **Hover Docs** | `K` | View type signature and docstrings |
| **Signature Help** | `<C-k>` or `<leader>ck` | View function argument signature while typing |
| **Toggle Inlay Hints** | `<leader>th` | Toggle parameter names and inferred types |

### Refactoring & Code Actions

| Action | Keybinding | Description |
|---|---|---|
| **Rename Symbol** | `<leader>cr` or `<leader>rn` | Project-wide atomic symbol rename |
| **Code Action** | `<leader>ca` | Auto-imports, error fixes, extract function |
| **Format Document** | `<leader>cf` or `<leader>f` | Format buffer via `conform.nvim` |

### Diagnostics & Trouble Explorer

| Action | Keybinding | Description |
|---|---|---|
| Next / Prev Diagnostic | `]d` / `[d` | Jump between compilation warnings/errors |
| Line Diagnostics | `<leader>cd` | Floating popup showing full error message |
| **Workspace Diagnostics** | `<leader>xx` | Interactive Trouble table of all errors |
| **Buffer Diagnostics** | `<leader>xX` | Errors in active buffer |
| **LSP Defs / References** | `<leader>cl` | Trouble tree of definitions and usages |
| **Search TODOs** | `<leader>st` | Search `TODO`, `FIXME`, `BUG`, `HACK` in project |

---

## 5. Interactive Git Suite

### A. Full Git Client (Neogit - Magit equivalent)
Open Neogit with `<leader>gg` or `<leader>gs`.

| In Neogit Buffer | Key | Action |
|---|---|---|
| Stage / Unstage File or Hunk | `s` / `u` | Stage/unstage item under cursor |
| Commit | `c` | Opens commit menu (`cc` for standard commit) |
| Push | `P` | Push to remote branch (`Pp` push to origin) |
| Pull | `p` | Pull from remote branch (`pp` pull from origin) |
| Branch Management | `b` | Create (`bc`), checkout (`bb`), or delete branch |
| Stash | `z` | Create or apply git stash |
| Log | `l` | Interactive commit graph |

### B. Visual Diff & Conflict Resolution (Diffview)

| Action | Keybinding | Description |
|---|---|---|
| **Open Git Diff** | `<leader>gd` | Side-by-side visual diff against HEAD/branch |
| **Close Git Diff** | `<leader>gD` | Exit diff viewer |
| **File History** | `<leader>gh` | Visual commit log and diffs for current file |
| **Branch History** | `<leader>gH` | Full project commit log with diff inspector |

### C. Gutter Signs & Hunk Operations (Gitsigns)

| Action | Keybinding | Description |
|---|---|---|
| Next / Prev Hunk | `]c` / `[c` | Jump to next/previous modified hunk |
| Stage Hunk | `<leader>hs` | Stage only the current hunk |
| Reset Hunk | `<leader>hr` | Discard changes in current hunk |
| Preview Hunk | `<leader>hp` | Floating diff preview of current hunk |
| Detailed Blame | `<leader>hb` | Floating popup with full commit details |
| Toggle Inline Blame | `<leader>tb` | Show inline virtual text git blame |

---

## 6. IntelliJ-Grade Debugging (DAP)

Visual debugger supporting **Python (`debugpy`)**, **Go (`delve`)**, **Rust/C/C++ (`codelldb`)**, and **JS/TS (`js-debug-adapter`)**.

### Debug Controls

```
  ┌────────────────────────────────────────────────────────┐
  │  F5: Continue/Start    F10: Step Over   F11: Step Into │
  │  F12: Step Out         <leader>dx: Terminate           │
  └────────────────────────────────────────────────────────┘
```

| Action | Keybinding | Notes |
|---|---|---|
| **Start / Continue** | `F5` or `<leader>dc` | Launches active configuration |
| **Step Over** | `F10` or `<leader>do` | Step to next line |
| **Step Into** | `F11` or `<leader>di` | Step into function call |
| **Step Out** | `F12` or `<leader>dO` | Step out of current frame |
| **Toggle Breakpoint** | `<leader>db` | Sets red breakpoint marker (●) |
| **Conditional Breakpoint** | `<leader>dB` | Breakpoint triggered on condition (◆) |
| **Set Log Point** | `<leader>lp` | Logs message without halting execution |
| **Toggle Debug UI** | `<leader>du` | Toggles Scopes, Watches, Stacks panels |
| **Toggle REPL** | `<leader>dr` | Interactive debugger expression evaluator |
| **Load `launch.json`** | `<leader>dl` | Dynamically loads `.vscode/launch.json` |
| **Terminate Session** | `<leader>dx` | Ends debugging session and closes panels |

---

## 7. Run Configurations & Task Execution (Overseer & Terminal)

### A. Task Runner (`overseer.nvim`)
Automatically discovers `.vscode/tasks.json`, `npm` scripts, `Cargo.toml`, and `Makefile` targets.

| Action | Keybinding | Description |
|---|---|---|
| **Run Task** | `<leader>or` | Opens interactive task selector |
| **Toggle Task Panel** | `<leader>ot` | Shows running background tasks and statuses |
| **Restart Last Task** | `<leader>ol` | Re-executes the most recent task |
| **Run Build Task** | `<leader>ob` | Executes default project build task |

### B. Quick Terminal Runners (`toggleterm.nvim`)

| Action | Keybinding | Description |
|---|---|---|
| **Run Current File** | `<leader>tr` | Auto-detects Python, Go, Rust, C++, Node and runs |
| **Floating Terminal** | `<leader>tf` or `Ctrl+\` | Quick scratch terminal popup |
| **Bottom Split Terminal** | `<leader>th` | Persistent horizontal terminal split |
| **Right Split Terminal** | `<leader>tv` | Persistent vertical terminal split |
| **Exit Terminal Insert** | `<Esc><Esc>` or `Ctrl+x` | Return to normal mode inside terminal |

---

## 8. Test-Driven Development (Neotest)

Run, watch, and debug unit tests with visual test trees for **Python (pytest)**, **Go (go test)**, **Rust (cargo test)**, and **JS/TS (jest/vitest)**.

| Action | Keybinding | Description |
|---|---|---|
| **Run Nearest Test** | `<leader>tn` | Runs the test function under the cursor |
| **Run Test File** | `<leader>tF` | Runs all tests in current file |
| **Toggle Test Tree** | `<leader>ts` | Visual test hierarchy and pass/fail badges |
| **Debug Nearest Test** | `<leader>tD` | Launches DAP debugger inside test function |
| **Toggle Watch Mode** | `<leader>tW` | Auto re-runs tests on file save |
| **Show Test Output** | `<leader>tO` | Opens floating window with test assertion logs |
| **Stop Running Test** | `<leader>tX` | Terminates active test run |

---

## 9. Senior / Staff Engineer Workflows

### Recipe A: Investigating a Production Bug in a Large Codebase
1. **Find entry point**: `<leader>fg` (Live Grep) for error code / endpoint name.
2. **Pin key files**: Press `<leader>a` on the router, service, and data layer files.
3. **Inspect code history**: Cursor on the suspicious line → `<leader>gh` (Diffview File History) to view PR and commit context.
4. **Set Conditional Breakpoint**: Navigate to bug location → `<leader>dB` → Enter condition (e.g. `userId == nil`).
5. **Debug**: Press `F5` to start debugging. Step through with `F10`/`F11`. Inspect variables in DAP UI Scopes panel.

### Recipe B: High-Speed TDD & Refactoring
1. **Open implementation & test**: Pin both with `<leader>a`. Switch instantly via `<leader>1` and `<leader>2`.
2. **Start Test Watcher**: On the test file, press `<leader>tW` (Neotest watch mode).
3. **Refactor**: Use `<leader>cr` (Rename symbol), `ysiw"` (Surround word), and `<leader>ca` (Code action auto-import).
4. **Format & Verify**: Press `<leader>w` to save; auto-formatter cleans syntax and Neotest immediately validates test suite.

### Recipe C: Preparing a Clean Pull Request
1. **Review Diff**: `<leader>gd` (Diffview Open) to review all modified files side-by-side against `main`.
2. **Interactive Staging**: `<leader>gs` (Neogit) → Navigate files with `j/k` → Press `s` to stage only intended changes.
3. **Commit & Push**: Press `c` → `c` in Neogit, type atomic commit message, then `P` → `p` to push to remote branch.
