#!/bin/bash

set -o errexit -o nounset -o posix -o pipefail

bm="bfs cutcp histo lbm mri-gridding mri-q sad sgemm spmv stencil tpacf"

for b in $bm; do
	echo $b
	./parboil compile $b omp_base
done

