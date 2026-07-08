### A Pluto.jl notebook ###
# v0.1.0

using Markdown
using InteractiveUtils

# ╔═╡ d0000001-0000-4000-8000-000000000001
md"""
# 🤝 One notebook, a human and an agent

This notebook is built to be edited by **someone who isn't in the browser** — a coding agent,
a script, you in another terminal — *while you watch it happen live*. No MCP, no plugin: just
files, plain HTTP, and a tiny CLI.

The whole agent surface is boring plumbing:

- every running server drops a connection file in `~/.local/state/pluto/servers/<port>.json`
  (port + access secret — the Jupyter idiom);
- a plain HTTP API at `/api/v1/…`;
- the [`pluto-collab`](https://github.com/GroupTherapyOrg/SpaceStation.jl/blob/main/bin/pluto-collab)
  CLI (just `curl` + `sed`).

The dependency chain below is the playground. Read `AGENTS.md` in this workspace for the
exact stanza an agent follows.
"""

# ╔═╡ d0000002-0000-4000-8000-000000000002
md"### A tiny shared experiment"

# ╔═╡ d0000003-0000-4000-8000-000000000003
# 🤖 EDIT ME. This is the line an agent (or you, from another terminal) changes.
target_temperature = 20

# ╔═╡ d0000004-0000-4000-8000-000000000004
# slow enough to watch: 48 simulated hourly readings around the target.
readings = begin
	sleep(2)
	[target_temperature + 3 * sin(i / 4) + (i % 5) * 0.4 for i in 1:48]
end

# ╔═╡ d0000005-0000-4000-8000-000000000005
summary = (
	low = round(minimum(readings); digits = 1),
	high = round(maximum(readings); digits = 1),
	mean = round(sum(readings) / length(readings); digits = 1),
)

# ╔═╡ d0000006-0000-4000-8000-000000000006
headline = "🌡️ target $(target_temperature)° → ranged $(summary.low)°–$(summary.high)°, mean $(summary.mean)°"

# ╔═╡ d0000007-0000-4000-8000-000000000007
Markdown.parse("> **$(headline)**")

# ╔═╡ d0000008-0000-4000-8000-000000000008
md"""
### The loop (try it in the terminal — or watch an agent do it)

From any terminal, with this notebook open in SpaceStation:

```sh
# what's stale right now? (per-cell: stale / cold / errored / output)
pluto-collab status notebooks/04_agent_collab.jl

# change a value the way an agent would — edit the file directly:
#   target_temperature = 26
# the matching cell turns amber in the browser within ~1s. Nothing runs yet.

# now run exactly what's outdated — you watch it go amber → running → green:
pluto-collab run notebooks/04_agent_collab.jl --stale

# outputs are also readable straight from the sidecar, no tool needed:
cat notebooks/04_agent_collab.jl.pluto-cache.toml
```

Runs requested over HTTP go through the *same* execution queue as your clicks — both sides
see every run in real time. Expensive unrelated cells are never re-run; only the stale
closure executes.
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
# ╟─d0000001-0000-4000-8000-000000000001
# ╟─d0000002-0000-4000-8000-000000000002
# ╠═d0000003-0000-4000-8000-000000000003
# ╠═d0000004-0000-4000-8000-000000000004
# ╠═d0000005-0000-4000-8000-000000000005
# ╠═d0000006-0000-4000-8000-000000000006
# ╠═d0000007-0000-4000-8000-000000000007
# ╟─d0000008-0000-4000-8000-000000000008
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
