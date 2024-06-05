TL;DR ignore this folder, it is not needed for running the tutorial.

However, if you want to run the tutorial again on other machines, please have a look at the following notes.

- The two TOML files in this folder specify the exact version of julia packages we are using during the tutorial.
- On TACC machine, I created a julia sysimage which contains packages `WannierIO` and `Wannier`, therefore this folder is not needed on TACC machine.
- On other machines, one can reproduce the same environment with the following command:

    ```bash
    julia --project=julia -e 'using Pkg; Pkg.instantiate()'
    ```

    and run `mrwf.jl` with
    ```bash
    # cd ex3/
    julia --project=julia ./mrwf.jl
    ```


