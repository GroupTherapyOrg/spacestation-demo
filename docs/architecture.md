# How the pieces fit (a nested doc)

This file lives in `docs/` — a subfolder, so the workspace tree shows it nested. Expand
folders in the sidebar to reach it.

## The two layers

```
┌─────────────────────────────────────────────────────────────┐
│  SpaceStation shell  — the "space"                             │
│  • folder workspace + file tree                               │
│  • notebooks & plain files as tabs                            │
│  • integrated terminal (persistent PTY)                       │
│  • SSH remote workspaces (VS Code Remote-SSH model)           │
│  • collab HTTP API + connection files + pluto-collab CLI      │
└───────────────────────────────┬─────────────────────────────┘
                                 │ each tab is an unmodified…
┌───────────────────────────────▼─────────────────────────────┐
│  Pluto.jl  — the notebook engine                              │
│  • reactive dependency graph (no execution to analyze)        │
│  • isolated worker processes per notebook                     │
│  • the .jl notebook file format                               │
└─────────────────────────────────────────────────────────────┘
```

## The two files per notebook (lazy mode)

| File | Holds | Safe to delete? |
|------|-------|-----------------|
| `<nb>.jl` | the **code** (source of truth) | no — it's your notebook |
| `<nb>.jl.pluto-cache.toml` | the **outputs** + execution keys | yes — it's only a cache |

Staleness is *verified*, not guessed: each cell stores an execution key (a hash of its own
code plus the result-hashes of its inputs). Reverting an edit clears the stale mark with no
run; cached outputs are trusted on reopen only when the keys prove code and inputs are
unchanged.
