set -ex

LINALG_LIBS="-llapack -lblas"

if [[ "$mpi" != "nompi" ]]; then
  export CC=mpicc
  export FC=mpifort
  LINALG_LIBS="-lscalapack ${LINALG_LIBS}"
  export FFLAGS="-I$PREFIX/include ${FFLAGS} -fallow-argument-mismatch"
  export FCFLAGS=$FFLAGS
fi

cd MatrixSwitch
bash autogen.sh
./configure --prefix=$PREFIX LINALG_LIBS="${LINALG_LIBS}"
make -j ${CPU_COUNT:-1}
make install
