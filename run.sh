#!/usr/bin/env bash

set -o errexit -o nounset -o posix -o pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# 10 in total
bm="bfs cutcp histo lbm mri-gridding mri-q sgemm spmv stencil tpacf"

mkdir -p run

for b in $bm; do
	echo "running $b"
	export GOMP_CPU_AFFINITY=0-256 KMP_AFFINITY=explicit,verbose,proclist=[0-256]
	sudo -E perf stat -A -a -e instructions,cache-misses,cache-references,cycles ./parboil run --no-check $b omp_base large |& tee run/$b.txt
	echo
done
