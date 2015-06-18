#!/bin/bash

#./plot.sh <test> <path_to_log> <output_file> <indep_var> <dep_var> <title> <xlab> <ylab

cd ..
ROOT=$PWD

mkdir -p graphs
cd graphs
GRAPHS_DIR=$PWD
mkdir -p single
cd single
mkdir -p {pt2pt,one-sided,collective}
cd ..
mkdir -p multi
cd multi
mkdir -p {pt2pt,one-sided,collective}
cd ../../

cd omb/results
RESULTS_DIR=$PWD

cd $ROOT/scripts

set -x

#single

#pt2pt
./plot.sh osu_bibw $RESULTS_DIR/single/pt2pt $GRAPHS_DIR/single/pt2pt/osu_bibw.pdf message_size bandwidth \"SINGLE\ NODE\ -\ Birectional\ Bandwidth\" \"message\ size\ \(bytes\)\" \"mean\ bandwidth\ \(MBps\)\"
./plot.sh osu_bw $RESULTS_DIR/single/pt2pt $GRAPHS_DIR/single/pt2pt/osu_bw.pdf message_size bandwidth \"SINGLE\ NODE\ -\ Bandwidth\" \"message\ size\ \(bytes\)\" \"mean\ bandwidth\ \(MBps\)\"
./plot.sh osu_latency $RESULTS_DIR/single/pt2pt $GRAPHS_DIR/single/pt2pt/osu_latency.pdf message_size latency \"SINGLE\ NODE\ -\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_latency_mt $RESULTS_DIR/single/pt2pt $GRAPHS_DIR/single/pt2pt/osu_latency_mt.pdf message_size latency \"SINGLE\ NODE\ -\ Multi-Threaded\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_mbw_mr $RESULTS_DIR/single/pt2pt $GRAPHS_DIR/single/pt2pt/osu_mbw_mr.pdf message_size bandwidth \"SINGLE\ NODE\ -\ Multiple\ Bandwidth\" \"message\ size\ \(bytes\)\" \"mean\ bandwidth\ \(MBps\)\"
./plot.sh osu_multi_lat $RESULTS_DIR/single/pt2pt $GRAPHS_DIR/single/pt2pt/osu_multi_lat.pdf message_size latency \"SINGLE\ NODE\ -\ Multi-Threaded\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"

#one-sided
./plot.sh osu_acc_latency $RESULTS_DIR/single/one-sided $GRAPHS_DIR/single/one-sided/osu_acc_latency.pdf message_size latency \"SINGLE\ NODE\ -\ Accumulate\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_cas_latency $RESULTS_DIR/single/one-sided $GRAPHS_DIR/single/one-sided/osu_cas_latency.pdf message_size latency \"SINGLE\ NODE\ -\ CAS\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_fop_latency $RESULTS_DIR/single/one-sided $GRAPHS_DIR/single/one-sided/osu_fop_latency.pdf message_size latency \"SINGLE\ NODE\ -\ FOP\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_get_acc_latency $RESULTS_DIR/single/one-sided $GRAPHS_DIR/single/one-sided/osu_get_acc_latency.pdf message_size latency \"SINGLE\ NODE\ -\ Get\ Accumulate\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_get_bw $RESULTS_DIR/single/one-sided $GRAPHS_DIR/single/one-sided/osu_get_bw.pdf message_size bandwidth \"SINGLE\ NODE\ -\ Get\ Bandwidth\" \"message\ size\ \(bytes\)\" \"mean\ bandwidth\ \(MBps\)\"
./plot.sh osu_get_latency $RESULTS_DIR/single/one-sided $GRAPHS_DIR/single/one-sided/osu_get_latency.pdf message_size latency \"SINGLE\ NODE\ -\ Get\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_put_bibw $RESULTS_DIR/single/one-sided $GRAPHS_DIR/single/one-sided/osu_put_bibw.pdf message_size bandwidth \"SINGLE\ NODE\ -\ Put\ Bidirectional\ Bandwidth\" \"message\ size\ \(bytes\)\" \"mean\ bandwidth\ \(MBps\)\"
./plot.sh osu_put_bw $RESULTS_DIR/single/one-sided $GRAPHS_DIR/single/one-sided/osu_put_bw.pdf message_size bandwidth \"SINGLE\ NODE\ -\ Put\ Bandwidth\" \"message\ size\ \(bytes\)\" \"mean\ bandwidth\ \(MBps\)\"
./plot.sh osu_put_latency $RESULTS_DIR/single/one-sided $GRAPHS_DIR/single/one-sided/osu_put_latency.pdf message_size latency \"SINGLE\ NODE\ -\ Put\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"

#collective
./plot-collective.sh osu_allgather $RESULTS_DIR/single/collective $GRAPHS_DIR/single/collective/osu_allgather.pdf message_size latency \"SINGLE\ NODE\ -\ All\ Gather\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_allgatherv $RESULTS_DIR/single/collective $GRAPHS_DIR/single/collective/osu_allgatherv.pdf message_size latency \"SINGLE\ NODE\ -\ All\ GatherV\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_allreduce $RESULTS_DIR/single/collective $GRAPHS_DIR/single/collective/osu_allreduce.pdf message_size latency \"SINGLE\ NODE\ -\ All\ Reduce\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_alltoall $RESULTS_DIR/single/collective $GRAPHS_DIR/single/collective/osu_alltoall.pdf message_size latency \"SINGLE\ NODE\ -\ AlltoAll\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_alltoallv $RESULTS_DIR/single/collective $GRAPHS_DIR/single/collective/osu_alltoallv.pdf message_size latency \"SINGLE\ NODE\ -\ AlltoAllV\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
#./plot-collective.sh osu_barrier $RESULTS_DIR/single/collective $GRAPHS_DIR/single/collective/osu_barrier.pdf message_size latency \"SINGLE\ NODE\ -\ Barrier\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_bcast $RESULTS_DIR/single/collective $GRAPHS_DIR/single/collective/osu_bcast.pdf message_size latency \"SINGLE\ NODE\ -\ Broadcast\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_gather $RESULTS_DIR/single/collective $GRAPHS_DIR/single/collective/osu_gather.pdf message_size latency \"SINGLE\ NODE\ -\ Gather\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_gatherv $RESULTS_DIR/single/collective $GRAPHS_DIR/single/collective/osu_gatherv.pdf message_size latency \"SINGLE\ NODE\ -\ GatherV\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_reduce $RESULTS_DIR/single/collective $GRAPHS_DIR/single/collective/osu_reduce.pdf message_size latency \"SINGLE\ NODE\ -\ Reduce\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_reduce_scatter $RESULTS_DIR/single/collective $GRAPHS_DIR/single/collective/osu_reduce_scatter.pdf message_size latency \"SINGLE\ NODE\ -\ Reduce\ Scatter\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_scatter $RESULTS_DIR/single/collective $GRAPHS_DIR/single/collective/osu_scatter.pdf message_size latency \"SINGLE\ NODE\ -\ Scatter\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_scatterv $RESULTS_DIR/single/collective $GRAPHS_DIR/single/collective/osu_scatterv.pdf message_size latency \"SINGLE\ NODE\ -\ ScatterV\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"


#multi

#pt2pt
./plot.sh osu_bibw $RESULTS_DIR/multi/pt2pt $GRAPHS_DIR/multi/pt2pt/osu_bibw.pdf message_size bandwidth \"Multi\ NODE\ -\ Birectional\ Bandwidth\" \"message\ size\ \(bytes\)\" \"mean\ bandwidth\ \(MBps\)\"
./plot.sh osu_bw $RESULTS_DIR/multi/pt2pt $GRAPHS_DIR/multi/pt2pt/osu_bw.pdf message_size bandwidth \"Multi\ NODE\ -\ Bandwidth\" \"message\ size\ \(bytes\)\" \"mean\ bandwidth\ \(MBps\)\"
./plot.sh osu_latency $RESULTS_DIR/multi/pt2pt $GRAPHS_DIR/multi/pt2pt/osu_latency.pdf message_size latency \"Multi\ NODE\ -\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_latency_mt $RESULTS_DIR/multi/pt2pt $GRAPHS_DIR/multi/pt2pt/osu_latency_mt.pdf message_size latency \"Multi\ NODE\ -\ Multi-Threaded\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_mbw_mr $RESULTS_DIR/multi/pt2pt $GRAPHS_DIR/multi/pt2pt/osu_mbw_mr.pdf message_size bandwidth \"Multi\ NODE\ -\ Multiple\ Bandwidth\" \"message\ size\ \(bytes\)\" \"mean\ bandwidth\ \(MBps\)\"
./plot.sh osu_multi_lat $RESULTS_DIR/multi/pt2pt $GRAPHS_DIR/multi/pt2pt/osu_multi_lat.pdf message_size latency \"Multi\ NODE\ -\ Multi-Threaded\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"

#one-sided
./plot.sh osu_acc_latency $RESULTS_DIR/multi/one-sided $GRAPHS_DIR/multi/one-sided/osu_acc_latency.pdf message_size latency \"Multi\ NODE\ -\ Accumulate\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_cas_latency $RESULTS_DIR/multi/one-sided $GRAPHS_DIR/multi/one-sided/osu_cas_latency.pdf message_size latency \"Multi\ NODE\ -\ CAS\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_fop_latency $RESULTS_DIR/multi/one-sided $GRAPHS_DIR/multi/one-sided/osu_fop_latency.pdf message_size latency \"Multi\ NODE\ -\ FOP\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_get_acc_latency $RESULTS_DIR/multi/one-sided $GRAPHS_DIR/multi/one-sided/osu_get_acc_latency.pdf message_size latency \"Multi\ NODE\ -\ Get\ Accumulate\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_get_bw $RESULTS_DIR/multi/one-sided $GRAPHS_DIR/multi/one-sided/osu_get_bw.pdf message_size bandwidth \"Multi\ NODE\ -\ Get\ Bandwidth\" \"message\ size\ \(bytes\)\" \"mean\ bandwidth\ \(MBps\)\"
./plot.sh osu_get_latency $RESULTS_DIR/multi/one-sided $GRAPHS_DIR/multi/one-sided/osu_get_latency.pdf message_size latency \"Multi\ NODE\ -\ Get\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot.sh osu_put_bibw $RESULTS_DIR/multi/one-sided $GRAPHS_DIR/multi/one-sided/osu_put_bibw.pdf message_size bandwidth \"Multi\ NODE\ -\ Put\ Bidirectional\ Bandwidth\" \"message\ size\ \(bytes\)\" \"mean\ bandwidth\ \(MBps\)\"
./plot.sh osu_put_bw $RESULTS_DIR/multi/one-sided $GRAPHS_DIR/multi/one-sided/osu_put_bw.pdf message_size bandwidth \"Multi\ NODE\ -\ Put\ Bandwidth\" \"message\ size\ \(bytes\)\" \"mean\ bandwidth\ \(MBps\)\"
./plot.sh osu_put_latency $RESULTS_DIR/multi/one-sided $GRAPHS_DIR/multi/one-sided/osu_put_latency.pdf message_size latency \"Multi\ NODE\ -\ Put\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"

#collective
./plot-collective.sh osu_allgather $RESULTS_DIR/multi/collective $GRAPHS_DIR/multi/collective/osu_allgather.pdf message_size latency \"Multi\ NODE\ -\ All\ Gather\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_allgatherv $RESULTS_DIR/multi/collective $GRAPHS_DIR/multi/collective/osu_allgatherv.pdf message_size latency \"Multi\ NODE\ -\ All\ GatherV\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_allreduce $RESULTS_DIR/multi/collective $GRAPHS_DIR/multi/collective/osu_allreduce.pdf message_size latency \"Multi\ NODE\ -\ All\ Reduce\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_alltoall $RESULTS_DIR/multi/collective $GRAPHS_DIR/multi/collective/osu_alltoall.pdf message_size latency \"Multi\ NODE\ -\ AlltoAll\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_alltoallv $RESULTS_DIR/multi/collective $GRAPHS_DIR/multi/collective/osu_alltoallv.pdf message_size latency \"Multi\ NODE\ -\ AlltoAllV\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
#./plot-collective.sh osu_barrier $RESULTS_DIR/multi/collective $GRAPHS_DIR/multi/collective/osu_barrier.pdf message_size latency \"multi\ NODE\ -\ Barrier\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_bcast $RESULTS_DIR/multi/collective $GRAPHS_DIR/multi/collective/osu_bcast.pdf message_size latency \"Multi\ NODE\ -\ Broadcast\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_gather $RESULTS_DIR/multi/collective $GRAPHS_DIR/multi/collective/osu_gather.pdf message_size latency \"Multi\ NODE\ -\ Gather\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_gatherv $RESULTS_DIR/multi/collective $GRAPHS_DIR/multi/collective/osu_gatherv.pdf message_size latency \"Multi\ NODE\ -\ GatherV\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_reduce $RESULTS_DIR/multi/collective $GRAPHS_DIR/multi/collective/osu_reduce.pdf message_size latency \"Multi\ NODE\ -\ Reduce\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_reduce_scatter $RESULTS_DIR/multi/collective $GRAPHS_DIR/multi/collective/osu_reduce_scatter.pdf message_size latency \"Multi\ NODE\ -\ Reduce\ Scatter\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_scatter $RESULTS_DIR/multi/collective $GRAPHS_DIR/multi/collective/osu_scatter.pdf message_size latency \"Multi\ NODE\ -\ Scatter\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"
./plot-collective.sh osu_scatterv $RESULTS_DIR/multi/collective $GRAPHS_DIR/multi/collective/osu_scatterv.pdf message_size latency \"Multi\ NODE\ -\ ScatterV\ Latency\" \"message\ size\ \(bytes\)\" \"mean\ latency\ \(us\)\"

set +x

