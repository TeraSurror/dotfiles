# Neovim + Tmux Workflow Guide

## The Mental Model

- **Tmux** — workspace manager (sessions, windows, panes)
- **Neovim** — editor (runs inside a tmux pane)
- **LSP** — intelligence layer inside Neovim (autocomplete, go-to-def, rename, etc.)

The prefix key for all tmux commands is `Ctrl+b` (written as `<prefix>`).

---

## Tmux

### Layout Concept

```
Session "myproject"
├── Window 1: editor (nvim)
├── Window 2: running the app (npm run dev / go run .)
└── Window 3: git / misc
```

### Sessions

```bash
tmux new -s myproject      # create a named session
tmux attach -t myproject   # reattach after closing terminal
tmux ls                    # list all sessions
```

From inside tmux:

| Action | Key |
|---|---|
| New session | `<prefix> :new-session -s myname` |
| Session picker | `<prefix> s` |
| Next session | `<prefix> )` |
| Previous session | `<prefix> (` |
| Detach from session | `<prefix> d` |

> `<prefix> s` shows a tree of all sessions and windows. Navigate with `j/k`, jump with `Enter`.

### Windows (tabs)

| Action | Key |
|---|---|
| New window | `<prefix> c` |
| Next window | `<prefix> n` |
| Previous window | `<prefix> p` |
| Jump to window N | `<prefix> 1`, `<prefix> 2`, etc. |
| Rename window | `<prefix> ,` |
| Close window | `exit` or `<prefix> &` |

### Panes (splits)

| Action | Key |
|---|---|
| Split vertically (side by side) | `<prefix> \|` |
| Split horizontally (top/bottom) | `<prefix> -` |
| Navigate panes | `<prefix> h/j/k/l` |
| Close pane | `<prefix> x` or `exit` |
| Zoom pane (fullscreen toggle) | `<prefix> z` |
| Reload config | `<prefix> r` |

> Splits always open in the same directory you're currently in.

### Typical Split Layout

```
┌──────────────────┬──────────┐
│                  │          │
│    nvim          │ terminal │
│                  │          │
└──────────────────┴──────────┘
<prefix> |   to create
<prefix> h/l to switch sides
```

---

## Neovim — Files & Navigation

### Opening a Project

```bash
nvim .    # open at project root
```

### File Explorer — `Space e`

| Action | Key |
|---|---|
| Toggle explorer | `Space e` |
| Open file | `Enter` |
| Open in vertical split | `v` |
| Create file | `a` |
| Rename file | `r` |
| Delete file | `d` |
| Copy file | `c` then `p` |
| Move/cut file | `x` then `p` |

### Telescope — Fuzzy Finding

| Action | Key |
|---|---|
| Find file by name | `Space ff` |
| Search text across project | `Space fg` |
| Switch open buffers | `Space fb` |
| Recently opened files | `Space fr` |
| Help docs | `Space fh` |

Inside Telescope: `Ctrl+j/k` to move, `Enter` to open, `Esc` to close.

> `Space fg` → type a function or class name → find it anywhere in the project instantly.

### Buffers

| Action | Key |
|---|---|
| Next buffer | `Tab` |
| Previous buffer | `Shift+Tab` |
| Close buffer | `Space bd` |

### Neovim Splits

| Action | Key |
|---|---|
| Split vertically | `Space sv` |
| Split horizontally | `Space sh` |
| Move between splits | `Ctrl+h/j/k/l` |
| Equal size splits | `Space se` |
| Close split | `Space sx` |

---

## Terminal Workflow

### Option A — Tmux pane (recommended for persistent terminals)

1. `<prefix> |` — open a new pane to the right
2. Run your command (`go run .`, `npm run dev`, etc.)
3. `<prefix> h/l` — switch between editor and terminal

### Option B — ToggleTerm (quick commands inside Neovim)

| Action | Key |
|---|---|
| Toggle floating terminal | `Ctrl+\` or `Space tt` |
| Exit terminal insert mode | `Ctrl+x` |

---

## LSP — Code Intelligence

Activates automatically for: `.py`, `.ts`, `.js`, `.go`, `.c`, `.cpp`, `.rs`

### Navigation

| Action | Key | Notes |
|---|---|---|
| Go to definition | `gd` | jump to where it's defined |
| Go to declaration | `gD` | |
| Find all references | `gr` | opens Telescope list |
| Go to implementation | `gi` | useful for interfaces |
| Hover docs | `K` | type signature + docs |
| Previous diagnostic | `[d` | jump to prev error/warning |
| Next diagnostic | `]d` | jump to next error/warning |
| Show diagnostic detail | `Space d` | full error in float |

### Refactoring

| Action | Key | Notes |
|---|---|---|
| **Rename symbol** | `Space rn` | renames across all files in project |
| Code action | `Space ca` | auto-imports, extract function, fix errors |
| Format file | `Space f` | runs prettier / gofmt / etc. |

> `Space rn` — cursor on any name → type new name → `Enter`. All usages update project-wide.

> `Space ca` is context-sensitive: on a red underline it offers fixes, on an import it offers removal, on a block it may offer "extract to function".

### Completion (in insert mode)

- `Ctrl+j` / `Ctrl+k` — navigate suggestions
- `Enter` or `Tab` — accept
- `Ctrl+e` — dismiss

---

## Editing

### Surround (`nvim-surround`)

| Action | Keys | Example |
|---|---|---|
| Wrap word | `ysiw"` | `foo` → `"foo"` |
| Wrap word | `ysiw(` | `foo` → `(foo)` |
| Change surround | `cs"'` | `"foo"` → `'foo'` |
| Delete surround | `ds"` | `"foo"` → `foo` |
| Surround selection | Visual → `S"` | wraps selection |

### Comments (`Comment.nvim`)

| Action | Key |
|---|---|
| Toggle line comment | `gcc` |
| Toggle block comment | `gbc` |
| Comment selection | Visual → `gc` |

### Moving Text

| Action | Key |
|---|---|
| Move selected lines down | Visual → `J` |
| Move selected lines up | Visual → `K` |
| Indent selection | Visual → `>` |
| Unindent selection | Visual → `<` |

### Save / Quit

| Action | Key |
|---|---|
| Save | `Space w` |
| Quit | `Space q` |
| Save and quit | `Space wq` |
| Exit insert mode | `jk` or `Esc` |
| Clear search highlight | `Space nh` |

### Scrolling

| Action | Key |
|---|---|
| Scroll down (centered) | `Ctrl+d` |
| Scroll up (centered) | `Ctrl+u` |
| Next search result (centered) | `n` |
| Previous search result (centered) | `N` |

---

## Git

| Action | Key |
|---|---|
| Git status | `Space gs` |
| Git commit | `Space gc` |
| Git push | `Space gp` |

In the git status buffer:
- `s` — stage file
- `u` — unstage file
- `cc` — commit staged
- `=` — toggle inline diff

---

## Debugging (DAP)

| Action | Key |
|---|---|
| Start / Continue | `F5` |
| Step over | `F10` |
| Step into | `F11` |
| Step out | `F12` |
| Toggle breakpoint | `Space db` |

---

## Example: Full Feature Workflow (Go)

```
1. tmux attach -t main         attach or let zsh auto-attach
2. nvim .                      open project
3. Space ff → "handler"        find handlers.go
4. gd on a function call       jump to definition
5. K                           read the type/docs
6. Space rn on a variable      rename it everywhere
7. Space ca on a red underline fix the error
8. Space f                     format the file
9. Space w                     save
10. <prefix> |                 new tmux pane
11. go build ./...             compile
12. go test ./...              run tests
13. <prefix> h                 back to nvim
14. Space gs                   git status → stage → commit
```

---

## Quick Reference

```
TMUX
  <prefix> |     split right        <prefix> -     split down
  <prefix> h/l   left/right pane    <prefix> j/k   up/down pane
  <prefix> c     new window         <prefix> 1-9   jump to window
  <prefix> s     session picker     <prefix> z     zoom pane
  <prefix> r     reload config      <prefix> d     detach

NEOVIM — FILES
  Space e        file tree          Space ff       find file
  Space fg       grep project       Space fb       buffers
  Tab            next buffer        Shift+Tab      prev buffer

NEOVIM — LSP
  gd             go to def          gr             references
  K              hover docs         Space rn       rename symbol
  Space ca       code action        Space f        format
  [d / ]d        prev/next error    Space d        error detail

NEOVIM — EDITING
  gcc            comment line       Space sv/sh    split v/h
  Ctrl+h/j/k/l   move between splits
  Space tt        floating terminal  Ctrl+x        exit terminal
  jk             exit insert mode
```
