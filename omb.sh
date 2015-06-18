#!/bin/bash

export BUILD=1
export SINGLE=1
export MULTI=1
export GRAPHS=1

EXPERIMENTS=2

if [ $# -ne 1 ]
then
    echo "Usage: ./omb.sh <compiler>"
    echo "    compiler options: intel gcc"
    exit
fi

if [[ $1 != "intel" && $1 != "gcc" ]]
then
    echo "valid compiler options are intel or gcc"
    exit
fi

module purge
module load $1 mvapich2

mkdir -p omb
cd omb

if [ $BUILD -eq 1 ]; then
    wget http://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-4.4.1.tar.gz
    tar -zxf osu-micro-benchmarks-4.4.1.tar.gz

    cd osu-micro-benchmarks-4.4.1
    export CC="$VT_MPI_BIN/mpicc"
    ./configure --prefix=$PWD/../build
    make -j
    make install
    cd ..
    mv build/libexec/osu-micro-benchmarks/mpi/* build/.
    rm -rf build/libexec
fi

cd build

if [ $SINGLE -eq 1 ]; then
    #single-pt2pt
    cd pt2pt/
    set -x
list=$(cat <<EOF
osu_bibw osu_bw osu_latency osu_mbw_mr osu_multi_lat
EOF
)
    for test in $list; do
        for k in `seq 1 $EXPERIMENTS`; do
            mpirun -np 2 ./$test >> $test.log 2>/dev/null
        done
    done 
    for k in `seq 1 $EXPERIMENTS`; do
        MV2_ENABLE_AFFINITY=0 mpirun -np 2 ./osu_latency_mt >> osu_latency_mt.log 2>/dev/null
    done
    set +x
    mkdir -p ../../results/single/pt2pt
    mv *.log ../../results/single/pt2pt/.

    #single-one-sided
    cd ../one-sided
    set -x
list=$(cat <<EOF
osu_acc_latency osu_fop_latency osu_get_bw osu_put_bibw osu_put_latency 
osu_cas_latency osu_get_acc_latency osu_get_latency osu_put_bw
EOF
)
    for test in $list; do
        for k in `seq 1 $EXPERIMENTS`; do
            mpirun -np 2 ./$test >> $test.log 2>/dev/null
        done
    done
    set +x
    mkdir -p ../../results/single/one-sided
    mv *.log ../../results/single/one-sided/.

    #single-collections
    cd ../collective
    set -x
list=$(cat <<EOF
osu_allgather osu_allgatherv osu_allreduce osu_alltoall osu_alltoallv osu_barrier
osu_bcast osu_gather osu_gatherv osu_reduce osu_reduce_scatter osu_scatter osu_scatterv
EOF
)
    for i in 2 4 8 16 20; do
        for test in $list; do
            for k in `seq 1 $EXPERIMENTS`; do
                mpirun -np $i ./$test >> $test-$i.log 2>/dev/null
            done
        done
    done
    set +x
    mkdir -p ../../results/single/collective
    mv *.log ../../results/single/collective/.
    cd ..
fi


if [ $MULTI -eq 1 ]; then
    #multi-pt2pt
    cd pt2pt/
    set -x
    export HOSTS="nr050,nr051"
list=$(cat <<EOF
osu_bibw osu_bw osu_latency osu_mbw_mr osu_multi_lat
EOF
)
    for test in $list; do
        for k in `seq 1 $EXPERIMENTS`; do
            mpirun -hosts $HOSTS -np 2 ./$test >> $test.log 2>/dev/null
        done
    done
    for k in `seq 1 $EXPERIMENTS`; do
        MV2_ENABLE_AFFINITY=0 mpirun -hosts $HOSTS -np 2 ./osu_latency_mt >> osu_latency_mt.log 2>/dev/null
    done
    set +x
    mkdir -p ../../results/multi/pt2pt
    mv *.log ../../results/multi/pt2pt/.

    #multi-one-sided
    cd ../one-sided
    set -x
    export HOSTS="nr050,nr051"
list=$(cat <<EOF
osu_acc_latency osu_fop_latency osu_get_bw osu_put_bibw osu_put_latency 
osu_cas_latency osu_get_acc_latency osu_get_latency osu_put_bw
EOF
)
    for test in $list; do
        for k in `seq 1 $EXPERIMENTS`; do
            mpirun -hosts $HOSTS -np 2 ./$test >> $test.log 2>/dev/null
        done
    done
    set +x
    mkdir -p ../../results/multi/one-sided
    mv *.log ../../results/multi/one-sided/.

    #multi-collections
    cd ../collective
    set -x
list=$(cat <<EOF
osu_allgather osu_allgatherv osu_allreduce osu_alltoall osu_alltoallv osu_barrier
osu_bcast osu_gather osu_gatherv osu_reduce osu_reduce_scatter osu_scatter osu_scatterv
EOF
)
    for i in 2 4 8 16; do
        limit=`expr $((49+$i))`
        HOSTS="nr050"
        for j in `seq 51 $limit`; do
           HOSTS="$HOSTS,nr0$j"
        done

        for test in $list; do
            for k in `seq 1 $EXPERIMENTS`; do
                mpirun -hosts $HOSTS -np $i ./$test >> $test-$i.log 2>/dev/null
            done
        done
    done
    set +x
    mkdir -p ../../results/multi/collective
    mv *.log ../../results/multi/collective/.

    cd ../
fi

cd ../../
echo $PWD

if [ $GRAPHS -eq 1 ]; then
    cd scripts
    ./create-graphs.sh    
fi
