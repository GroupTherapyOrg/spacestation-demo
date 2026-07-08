### A Pluto.jl notebook ###
# v0.1.0

using Markdown
using InteractiveUtils

# ╔═╡ c0000001-0000-4000-8000-000000000001
md"""
# 🟡 Lazy mode: the two-file reactive model

SpaceStation's default is **lazy**. Editing a cell — in the browser *or* on disk — marks it (and
everything downstream) **stale** instead of running it. *You* decide when to run, and a run
executes exactly the stale closure and nothing more.

Two files hold the whole story:

1. **`03_lazy_and_cache.jl`** — the notebook (this file). The source of truth for *code*.
2. **`03_lazy_and_cache.jl.pluto-cache.toml`** — a plain-TOML sidecar holding every cell's
   *output* plus a content-addressed **execution key**. Delete it any time; it's just a cache.

The pipeline below has deliberately **slow** cells, so "run only what's stale" actually saves
you something. Try the experiments at the bottom. 👇
"""

# ╔═╡ c0000002-0000-4000-8000-000000000002
md"### The pipeline"

# ╔═╡ c0000003-0000-4000-8000-000000000003
# 🎛️ the knob. Change this and the whole chain below goes stale.
sample_size = 1_000

# ╔═╡ c0000004-0000-4000-8000-000000000004
# 💢 EXPENSIVE: pretend this is a big data pull or a simulation.
samples = begin
	sleep(3)
	[sin(i / 13) + 0.3 * sin(i / 2) + 0.05 * (i % 7) for i in 1:sample_size]
end

# ╔═╡ c0000005-0000-4000-8000-000000000005
# 💢 also slow: a 9-point moving-average smoother over the samples.
smoothed = begin
	sleep(2)
	[sum(samples[max(1, i - 8):i]) / length(max(1, i - 8):i) for i in eachindex(samples)]
end

# ╔═╡ c0000006-0000-4000-8000-000000000006
# cheap: a summary of the smoothed signal.
stats = (
	n = length(smoothed),
	peak = round(maximum(smoothed); digits = 3),
	trough = round(minimum(smoothed); digits = 3),
	mean = round(sum(smoothed) / length(smoothed); digits = 3),
	spread = round(maximum(smoothed) - minimum(smoothed); digits = 3),
)

# ╔═╡ c0000007-0000-4000-8000-000000000007
# ╠═╡ always_stale = true
# 🎲 IMPURE & STANDALONE: uses rand() and the clock, so its result can't be reproduced — and
# nothing depends on it. The metadata line above (always_stale = true) tells SpaceStation to NEVER
# trust a cached value here: it comes back stale after every restart, even though the code
# never changed, while the rest of the pipeline restores green.
run_token = "🎲 fresh every run — roll $(rand(1:9999)) at t=$(round(Int, time()))"

# ╔═╡ c0000008-0000-4000-8000-000000000008
# cheap leaf: pure formatting over `stats`. Editing the text here re-runs ONLY this cell (and
# the one under it) — the expensive cells above stay green.
report = "📊 n=$(stats.n) · peak=$(stats.peak) · trough=$(stats.trough) · mean=$(stats.mean) · spread=$(stats.spread)"

# ╔═╡ c0000009-0000-4000-8000-000000000009
Markdown.parse("> **$(report)**")

# ╔═╡ c000000a-0000-4000-8000-00000000000a
md"""
### Try it (great for the recording)

**1 · Run-what's-stale.** Everything is stale on first open. Click the *"N cells are stale —
run"* notice, or hit `Ctrl/Cmd+S`. Watch the chain go amber → running → green. ~5 s.

**2 · Edit a leaf, keep the expensive work.** Change the text inside `report` (e.g. add an
emoji). Only `report` and the cell under it go stale — `samples` and `smoothed` stay green.
Run it: instant. *That's the point.*

**3 · Revert un-stales for free.** Change `sample_size` to `2_000`. The whole chain goes
stale. Now change it **back** to `1_000` — the stale marks vanish with **no run**, because the
execution keys prove nothing actually changed.

**4 · Outputs survive a restart.** After running, stop the server and reopen this notebook.
Every output is restored instantly from the sidecar — *except* `run_token`, which is
`always_stale` and comes back marked stale.

**5 · Edit from outside.** With the notebook open, edit this `.jl` file in another editor (or
let an agent do it). The matching cell turns amber in your browser within a second — and
nothing runs until you say so. See `04_agent_collab.jl`.
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
# ╟─c0000001-0000-4000-8000-000000000001
# ╟─c0000002-0000-4000-8000-000000000002
# ╠═c0000003-0000-4000-8000-000000000003
# ╠═c0000004-0000-4000-8000-000000000004
# ╠═c0000005-0000-4000-8000-000000000005
# ╠═c0000006-0000-4000-8000-000000000006
# ╠═c0000007-0000-4000-8000-000000000007
# ╠═c0000008-0000-4000-8000-000000000008
# ╠═c0000009-0000-4000-8000-000000000009
# ╟─c000000a-0000-4000-8000-00000000000a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
