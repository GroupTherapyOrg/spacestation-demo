### A Pluto.jl notebook ###
# v0.1.0

using Markdown
using InteractiveUtils

# ╔═╡ a0000001-0000-4000-8000-000000000001
md"""
# 🟢🟣🔴 Welcome to SpaceStation

### A workspace for Pluto notebooks — built for humans and agents, *together.*

You opened a **folder**. The sidebar on the left is its file tree. This notebook is one
**tab**; open another file and it lands beside this one. A real **terminal** docks below.
And anything that can edit a file — *you*, or a coding agent in any terminal — works in
this same live session.

This is the unmodified [Pluto.jl](https://github.com/fonsp/Pluto.jl) editor. Everything you
know about Pluto still holds. SpaceStation adds the *space around* the notebooks.
"""

# ╔═╡ a0000002-0000-4000-8000-000000000002
md"""
## Still reactive

Change a cell and everything downstream re-runs. The classic Pluto promise — change
`planet` below and watch the two cells under it update.
"""

# ╔═╡ a0000003-0000-4000-8000-000000000003
planet = "Pluto"

# ╔═╡ a0000004-0000-4000-8000-000000000004
greeting = "Greetings from $(planet) — still a planet in our hearts. 🪐"

# ╔═╡ a0000005-0000-4000-8000-000000000005
facts = Dict(
	"Pluto"   => (au = 39.5, year = 248.0, moons = 5),
	"Neptune" => (au = 30.1, year = 164.8, moons = 14),
	"Mars"    => (au = 1.52, year = 1.88, moons = 2),
)

# ╔═╡ a0000006-0000-4000-8000-000000000006
let
	f = get(facts, planet, (au = NaN, year = NaN, moons = 0))
	Markdown.parse("""
	| | $(planet) |
	|---|---|
	| Distance from the Sun | **$(f.au) AU** |
	| One year | **$(f.year) Earth years** |
	| Moons | **$(f.moons)** |
	""")
end

# ╔═╡ a0000007-0000-4000-8000-000000000007
md"""
## A little motion

Pure stdlib — no packages needed. (The orbit traces a sine wave across an ASCII grid.)
"""

# ╔═╡ a0000008-0000-4000-8000-000000000008
let
	rows, cols = 15, 60
	orbit(c) = round(Int, (rows + 1) / 2 + (rows - 1) / 2 * sin(2π * c / cols))
	Text(join((join(orbit(c) == r ? "●" : "·" for c in 1:cols) for r in 1:rows), "\n"))
end

# ╔═╡ a0000009-0000-4000-8000-000000000009
md"""
## Where to next

| Notebook | What it shows |
|---|---|
| `02_plots.jl` | Interactive plots with **WasmMakie** + a **PlutoUI** slider |
| `03_lazy_and_cache.jl` | The **lazy** 2-file model: stale marks, the cache sidecar, restart-survival |
| `04_agent_collab.jl` | A **human + agent** session over plain files, HTTP, and a tiny CLI |

Open the **terminal** (the toggle in the corner), try a **plain file** from the tree
(`data/field-notes.md`, `scripts/sketch.jl`) — it opens in its own tab and edits with the
same CodeMirror. See `SCREENSHOTS.md` for the full guided tour. 🎈
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.6"
manifest_format = "2.0"
project_hash = "71853c6197a6a7f222db0f1978c7cb232b87c5ee"

[deps]
"""

# ╔═╡ Cell order:
# ╟─a0000001-0000-4000-8000-000000000001
# ╟─a0000002-0000-4000-8000-000000000002
# ╠═a0000003-0000-4000-8000-000000000003
# ╠═a0000004-0000-4000-8000-000000000004
# ╠═a0000005-0000-4000-8000-000000000005
# ╠═a0000006-0000-4000-8000-000000000006
# ╟─a0000007-0000-4000-8000-000000000007
# ╠═a0000008-0000-4000-8000-000000000008
# ╟─a0000009-0000-4000-8000-000000000009
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
