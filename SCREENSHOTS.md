# 📸 SpaceStation guided shot list

Every screenshot/clip needed for the SpaceStation README, in recording order. Each entry says
**what it proves**, **how to set it up**, and **what to capture**. Features marked
*(unique to SpaceStation)* are the ones Pluto.jl doesn't have — those are the point.

---

## 0 · Prep (once)

```sh
# the demo workspace
DEMO=~/Documents/dev/GroupTherapyOrg/spacestation-demo

# `spacestation` and the `pluto-collab` CLI are both on PATH from the Pkg App install
# (julia> import Pkg; Pkg.Apps.add(url="https://github.com/GroupTherapyOrg/SpaceStation.jl"))
```

- **Window:** size the browser to a clean 16:9 (e.g. 1600×900) and keep it fixed across every
  shot so the README images line up.
- **Theme:** decide light or dark once (top-right toggle in any notebook) and stick with it.
- **Reset to a clean slate** any time you want the "everything stale on first open" look:
  ```sh
  rm -f "$DEMO"/notebooks/*.pluto-cache.toml
  ```

---

## 1 · The workspace opener  *(unique)*

**Proves:** SpaceStation starts at a VS Code-style "Open Folder" hub, not a notebook.

**Setup:** launch with **no** folder:
```sh
spacestation
```

**Capture:**
- the opener page — the SpaceStation wordmark, **recent workspaces**, and the folder browser.
- click into a couple of folders to show the breadcrumb + folder grid (the "browse the
  server's filesystem" picker).
- the **paste-a-path** field.

---

## 2 · Open the folder → the full IDE  *(unique)*

**Proves:** a folder becomes a workspace: file-tree sidebar + tabbed editor in one window.

**Setup:**
```sh
spacestation "$DEMO"
```
Expand `notebooks/`, `data/`, `docs/` in the sidebar. Open `notebooks/01_welcome.jl`.

**Capture:**
- the **whole window**: sidebar file tree on the left, `01_welcome.jl` open as a tab. This is
  the hero shot.
- the **resizable / collapsible sidebar** (drag its edge; hide it) — one shot each.

---

## 3 · Tabs: notebooks *and* plain files  *(unique)*

**Proves:** notebooks and ordinary files all open as tabs in the same editor.

**Setup & capture:**
- open `notebooks/02_plots.jl` too → **two notebook tabs** in the strip.
- open `data/field-notes.md` → a **plain Markdown file** in a tab (edit a line; `Cmd/Ctrl+S`).
- open `scripts/sketch.jl` → a **plain Julia script** (no cells — it is *not* run reactively).
- open `data/planets.csv` → tabular text in a tab.

Capture the tab strip with a mix of notebook + file tabs, and one shot of a plain file being
edited (cursor in the CodeMirror editor).

---

## 4 · Add / delete from the tree  *(unique)*

**Proves:** the workspace tree manages files, not just displays them.

**Setup & capture:** hover a folder row → click the **`+`** action → create a new notebook
and a new file in place. Then delete one. Capture the `+` affordance and the new entry
appearing in the tree.

---

## 5 · Integrated terminal  *(unique)*

**Proves:** a real shell lives in the workspace, docks anywhere, and survives refreshes.

**Setup & capture:**
- click **`⌨ Terminal`** (bottom of the editor area) → a real PTY shell, cwd = the workspace.
- run something: `julia scripts/sketch.jl` (prints Collatz stopping times).
- **dock it right**, then **bottom** (drag-resize each) — show both layouts.
- **persistence:** with the terminal mid-output, **reload the page**. The shell reattaches and
  replays scrollback (you'll briefly see *"the shell is still running; reload to reattach"*).
  This is the tmux-style persistent session — capture the reattach.

---

## 6 · Plots in the browser — WasmMakie + PlutoUI

**Proves:** rich, interactive output (and Pluto's package handling) inside SpaceStation.

**Setup:** open `notebooks/02_plots.jl`. The committed cache restores all figures instantly, so
it looks complete on open. To capture *live* rendering, run it (`Cmd/Ctrl+S`) — the first run
instantiates the notebook's embedded environment and loads WasmMakie, so give it a few seconds
(the slider cell may flash an error during the package load, then settle green — that's Pluto
moving the workspace as each package loads).

**Capture:**
- the gallery: the **line**, **scatter**, and **heatmap** figures.
- drag the **PlutoUI slider** (`frequency`) and capture the figure redrawing — best as a clip.

> Note: this notebook carries its **own embedded environment** (PlutoUI + WasmMakie pinned by
> git commit via `[sources]`), managed by Pluto's package manager — no `Pkg.activate`, no separate
> folder. Don't run `julia`/`precompile` on these packages in the terminal while the notebook is
> loading — two processes compiling the same env will error each other out.

---

## 7 · Lazy mode: edits mark cells stale, you run what changed  *(unique — the core)*

**Proves:** SpaceStation's default isn't autorun. Edits make cells **stale**; you run exactly the
stale closure. This is what the slow cells in `03_lazy_and_cache.jl` are for.

**Setup:** reset caches (`rm -f "$DEMO"/notebooks/*.pluto-cache.toml`), then open
`notebooks/03_lazy_and_cache.jl`.

**Capture, in this order:**
1. **All stale on open** — every cell shows the amber "changed but not run" marker, and the
   run-all affordance is available (`Cmd/Ctrl+S` = *Save and run all changed cells*). Capture
   the all-amber state.
2. **A run in flight** — trigger run-all and capture the chain mid-run: amber → running →
   green. The `sleep(3)` + `sleep(2)` cells make this a watchable ~5 s.
3. **Edit a leaf, keep the expensive work** — change the text inside the `report` cell. Only
   `report` (and the cell under it) go amber; `samples` and `smoothed` **stay green**. Run →
   instant. Capture the "only the leaf is stale" state side by side with the green expensive
   cells. *This is the headline screenshot for lazy mode.*
4. **Revert un-stales for free** — change `sample_size` to `2_000` (whole chain amber), then
   change it **back** to `1_000`. The amber marks vanish **with no run**. Capture before/after.

---

## 8 · The two-file model + the sidecar  *(unique)*

**Proves:** code lives in `<nb>.jl`; outputs live in a plain-TOML cache beside it.

**Setup & capture:** after running `03_lazy_and_cache.jl`, open
`notebooks/03_lazy_and_cache.jl.pluto-cache.toml` **as a tab** (it's in the tree). Capture the
TOML — per-cell `execution_key`, `result_hash`, `text_representation`, etc. Caption: *"outputs
are machine-readable; any tool can read results without running anything."*

---

## 9 · Outputs survive a restart  *(unique)*

**Proves:** reopening a notebook restores every output instantly from the sidecar — no run.

**Setup & capture:**
1. run `03_lazy_and_cache.jl` fully (all green).
2. **stop the server** (`Ctrl+C` in the launching terminal) and relaunch
   `spacestation "$DEMO"`; reopen the notebook.
3. Capture: outputs are **all present immediately** — the chart, the stats, the report — with
   nothing recomputed. The only cell that comes back **stale** is `run_token` (see §10).

---

## 10 · `always_stale`: impurity opts out of caching  *(unique)*

**Proves:** cells that use `rand()`/the clock/I/O can declare they're never trustworthy from
cache.

**Setup & capture:** in `03_lazy_and_cache.jl`, the `run_token` cell carries
`# ╠═╡ always_stale = true`. After a restart (§9) it is the **one** cell marked stale even
though its code never changed. Capture it amber among the restored-green cells; optionally
show the `# ╠═╡ always_stale = true` line in the file.

---

## 11 · Human + agent on one live session  *(unique — the showpiece)*

**Proves:** anything that can edit a file + run `curl` collaborates in the *same* session, in
real time. No MCP, no plugin.

**Setup:** open `notebooks/04_agent_collab.jl` in the browser. Run it once so it's green.
Arrange the browser and a terminal side by side.

**Capture (a split-screen clip is ideal):**
1. **Discovery / connection file** — show the connection file the running server wrote:
   ```sh
   ls ~/.local/state/pluto/servers/
   cat ~/.local/state/pluto/servers/*.json     # port + secret (the Jupyter idiom)
   pluto-collab servers
   pluto-collab notebooks
   ```
2. **Status** —
   ```sh
   cd "$DEMO"
   pluto-collab status notebooks/04_agent_collab.jl
   ```
3. **An "agent" edits the file** — change `target_temperature = 20` to `= 26` (do it from the
   terminal/another editor, or actually drive Claude Code). Capture the matching cell turning
   **amber in the browser within ~1 s**, with nothing running.
4. **Run the stale closure over HTTP** —
   ```sh
   pluto-collab run notebooks/04_agent_collab.jl --stale
   ```
   Capture the browser cells going amber → running → green **driven from the terminal**.
5. **Read outputs without the tool** —
   ```sh
   cat notebooks/04_agent_collab.jl.pluto-cache.toml
   ```

> The strongest version of this clip is a real coding agent (Claude Code) editing the file and
> running `pluto-collab run --stale` while your browser updates live — it makes the
> "humans and agents, together" line literal. `AGENTS.md`/`CLAUDE.md` in this folder is the
> stanza the agent follows.

---

## 12 · SSH remote workspaces  *(unique, experimental)*

**Proves:** the entire workspace — files, kernels, terminal, agent API — can run on a remote machine
over an SSH tunnel, point-and-click (the VS Code Remote-SSH model).

**Prerequisite:** a host in `~/.ssh/config` reachable with **keyed** auth (`BatchMode=yes`; no
password prompt). The remote needs `git` and `julia` available via a login shell.

**Setup & capture:** launch `spacestation` with **no** folder (the opener, §1). If you have SSH
hosts, an **"SSH Remotes"** section lists them as pills.
1. Click a host. Capture the progress banner: *"Connecting to `<host>` — connecting /
   checking / installing / starting / tunneling / ready"*, including the first-time note
   *"First-time setup compiles a lot of Julia — this is the slow step."*
2. When it flips to **ready**, capture the opened remote workspace — then open a notebook and a
   terminal **on the remote** to show it's the full workspace, not a thin client.

> First contact clones + instantiates SpaceStation on the remote (minutes); reconnects after that
> are instant. If you don't have a remote handy, capture just the opener's SSH Remotes section
> and the progress banner.

---

## 13 · Branding & polish

**Capture:** the SpaceStation **wordmark** in the sidebar header, the **favicon** in the browser
tab, and Pluto's **Safe-preview** intro on first opening a notebook. Small, but they make the
README feel finished.

---

## Feature → where to shoot it (quick map)

| Unique feature | Notebook / file | Section |
|---|---|---|
| Workspace opener (Open Folder) | — (launch with no folder) | §1 |
| Folder workspace + file tree + tabs | the whole folder | §2–3 |
| Plain-file editing in tabs | `data/field-notes.md`, `scripts/sketch.jl`, `data/planets.csv` | §3 |
| Add/delete files from tree | any folder row `+` | §4 |
| Integrated persistent terminal | `scripts/sketch.jl` to run | §5 |
| Browser plots | `notebooks/02_plots.jl` | §6 |
| Lazy mode / run-what's-stale | `notebooks/03_lazy_and_cache.jl` | §7 |
| Two-file model / sidecar | `…03_lazy_and_cache.jl.pluto-cache.toml` | §8 |
| Restart-survival | `notebooks/03_lazy_and_cache.jl` | §9 |
| `always_stale` | `run_token` cell in `03` | §10 |
| Human + agent collab (HTTP + CLI) | `notebooks/04_agent_collab.jl` + `AGENTS.md` | §11 |
| SSH remote workspaces | — (opener, needs an SSH host) | §12 |
