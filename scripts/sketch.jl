# sketch.jl — a plain Julia script (NOT a Pluto notebook).
#
# Notice: no `# ╔═╡` cell markers, no Cell order block. SpaceStation opens this as a plain
# file in a tab and edits it with CodeMirror — it does not try to run it reactively.
# Run it the normal way from the integrated terminal:  julia scripts/sketch.jl

function collatz_steps(n::Integer)
    steps = 0
    while n != 1
        n = iseven(n) ? n ÷ 2 : 3n + 1
        steps += 1
    end
    steps
end

# the first few Collatz stopping times
for n in 1:15
    println(lpad(n, 2), " → ", collatz_steps(n), " steps")
end

longest = argmax(collatz_steps, 1:10_000)
println("\nlongest under 10,000: $longest needs $(collatz_steps(longest)) steps")
