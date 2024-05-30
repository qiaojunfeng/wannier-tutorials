#!/usr/bin/env -S julia --project=jl_project
# Split valence and conduction Wannier functions.
using Wannier

seedname = "silicon"
win = read_win("$seedname.win")

# number of valence bands
nval = 4

outdir_val = "val"
outdir_cond = "cond"

# read the valcond amn/mmn/eig/chk files
model = read_w90_with_chk(seedname)

# split the original val+cond MLWFs into 2 groups: val, cond
# the first 4 bands are valence bands, the rest are conduction bands
indices = [1:nval, (nval+1):n_wannier(model)]
outdirs = [outdir_val, outdir_cond]

println("Model will be split into $(length(indices)) groups")
for (i, idxs) in enumerate(indices)
    println("  Group $i:")
    println("    indices: $(idxs)")
    println("    outdir : $(outdirs[i])")
end

models_Us = split_wannierize(model, indices)

for (i, (m, U)) in enumerate(models_Us)
    @info "Group $i after parallel transport:" omega(m)
    println("\n")

    # write files
    outdir = outdirs[i]
    mkpath(outdir)
    seedname_i = joinpath(outdir, seedname)
    write_w90(seedname_i, m)

    # prepare win files for val and cond, with correct num_wann
    win_i = Dict(pairs(win))
    for k in [:num_bands, :dis_froz_proj, :dis_proj_min, :dis_proj_max,
        :dis_win_min, :dis_win_max, :dis_froz_min, :dis_froz_max,
        :auto_projections,
    ]
        pop!(win_i, k, nothing)
    end
    # just write a random projection as a placeholder
    win_i[:projections] = ["random"]
    win_i[:num_wann] = n_wannier(m)
    win_i[:num_iter] = 1000
    write_win("$seedname_i.win"; win_i...)

    # you need to execute w90 in each of these folders
    # - `val` for VB
    # - `cond` for CB
end
