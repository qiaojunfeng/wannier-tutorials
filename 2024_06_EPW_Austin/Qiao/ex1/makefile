outfiles := bands.out \
bandsx.out \
graphene.bands.dat \
graphene.bands.dat.gnu \
graphene.bands.dat.proj \
graphene.bands.dat.proj.projwfc_up \
graphene.bands.dat.rap \
graphene.pdos_atm\#1\(C\)_wfc\#1\(s\) \
graphene.pdos_atm\#1\(C\)_wfc\#2\(p\) \
graphene.pdos_atm\#2\(C\)_wfc\#1\(s\) \
graphene.pdos_atm\#2\(C\)_wfc\#2\(p\) \
graphene.pdos_tot \
graphene.plotband.gnu \
graphene.plotband.pdf \
graphene.plotband.ps \
graphene.projbands.gnu \
graphene.projbands.gnu_projected.pdf \
graphene.projbands.gnu_projected.ps \
out/ \
plotband.out \
projwfc.out \
scf.out \
CRASH \
graphene.plotband.gnu.dat \
graphene.werr \
graphene.wout \
nscf.out \
pw2wan.out \
graphene.amn \
graphene.eig \
graphene.mmn \
graphene.node_00000.werr \
graphene_bandsdiff.pdf

infiles := graphene.bands \
graphene.bandsx \
graphene.nscf \
graphene.plotband \
graphene.projwfc \
graphene.pw2wan \
graphene.scf \
graphene.win

default:
	@echo "Usage: make clean"

clean:
	echo "Cleaning up..."
	rm -r $(outfiles)

MPI_NP = 8

test:
	@echo "Testing all calculations"
	mpirun -n $(MPI_NP) pw.x < graphene.scf > scf.out
	mpirun -n $(MPI_NP) pw.x < graphene.bands > bands.out
	mpirun -n $(MPI_NP) projwfc.x < graphene.projwfc > projwfc.out
	mpirun -n $(MPI_NP) bands.x < graphene.bandsx > bandsx.out
	mv graphene.bands.dat.proj.projwfc_up graphene.bands.dat.proj
	plotband.x < graphene.plotband > plotband.out
	gnuplot graphene.projbands.gnu
	ps2pdf graphene.projbands.gnu_projected.ps
	mpirun -n $(MPI_NP) pw.x < graphene.nscf > nscf.out
	wannier90.x -pp graphene
	mpirun -n $(MPI_NP) pw2wannier90.x < graphene.pw2wan > pw2wan.out
	mpirun -n $(MPI_NP) wannier90.x graphene
	./graphene_bandsdiff.gnu
	@echo "All calculations finished successfully"
