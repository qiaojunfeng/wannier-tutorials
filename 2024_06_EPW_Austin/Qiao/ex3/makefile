outfiles := bands.out \
bandsx.out \
silicon.bands.dat \
silicon.bands.dat.gnu \
silicon.bands.dat.proj \
silicon.bands.dat.proj.projwfc_up \
silicon.bands.dat.rap \
silicon.pdos_atm\#1\(C\)_wfc\#1\(s\) \
silicon.pdos_atm\#1\(C\)_wfc\#2\(p\) \
silicon.pdos_atm\#2\(C\)_wfc\#1\(s\) \
silicon.pdos_atm\#2\(C\)_wfc\#2\(p\) \
silicon.pdos_tot \
silicon.plotband.gnu \
silicon.plotband.pdf \
silicon.plotband.ps \
silicon.projbands.gnu \
silicon.projbands.gnu_projected.pdf \
silicon.projbands.gnu_projected.ps \
out/ \
plotband.out \
projwfc.out \
scf.out \
CRASH \
silicon.plotband.gnu.dat \
silicon.werr \
silicon.wout \
nscf.out \
pw2wan.out \
silicon.amn \
silicon.eig \
silicon.mmn \
silicon.node_00000.werr \
silicon_bandsdiff.pdf \
silicon.chk \
silicon.nnkp \
silicon_band.dat \
silicon_band.gnu \
silicon_band.kpt \
silicon_band.labelinfo.dat \
val \
cond

infiles := silicon.bands \
silicon.bandsx \
silicon.nscf \
silicon.plotband \
silicon.projwfc \
silicon.pw2wan \
silicon.scf \
silicon.win

default:
	@echo "Usage: make clean"

clean:
	echo "Cleaning up..."
	rm -r $(outfiles)

MPI_NP = 8

test:
	@echo "Testing all calculations"
	mpirun -n $(MPI_NP) pw.x < silicon.scf > scf.out
	mpirun -n $(MPI_NP) pw.x < silicon.bands > bands.out
	mpirun -n $(MPI_NP) bands.x < silicon.bandsx > bandsx.out
	mpirun -n $(MPI_NP) pw.x < silicon.nscf > nscf.out
	wannier90.x -pp silicon
	mpirun -n $(MPI_NP) pw2wannier90.x < silicon.pw2wan > pw2wan.out
	mpirun -n $(MPI_NP) wannier90.x silicon
	./silicon_bandsdiff.gnu
	julia --project=jl_project -e 'using Pkg; Pkg.instantiate()'
	./mrwf.jl
	cd val
	mpirun -n $(MPI_NP) wannier90.x silicon
	cd ../cond
	mpirun -n $(MPI_NP) wannier90.x silicon
	./silicon_bandsdiff_val.gnu
	./silicon_bandsdiff_cond.gnu
	@echo "All calculations finished successfully"
