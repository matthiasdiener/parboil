#!/bin/bash

set -o errexit -o nounset -o posix -o pipefail

bm="bfs cutcp histo lbm mri-gridding mri-q sad sgemm spmv stencil tpacf"

for b in $bm; do
	echo -n "making $b: "
	./parboil compile $b omp_base
done

echo

for b in $bm; do
	echo "running $b"
	./parboil run --no-check $b omp_base large
	echo
done
