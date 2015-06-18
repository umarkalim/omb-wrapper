# omb-wrapper
A quick and dirty wrapper for OSU MPI Benchmarks.

The intention is to automate execution and repitition of OSU MPI benchmarks and generate graphs from the performance results. 

The script downloads the [OSU MPI benchmarks](http://mvapich.cse.ohio-state.edu/benchmarks/) and builds the binaries. The input arguments dictate which compiler to use. The number of times an experiment is repeated is set by the EXPERIMENTS variable. First the within-node experiments are run, referred to as single-node tests. Later the between-nodes experiments are executed, referred to as multi-node tests. The number of nodes for collectives can be varied. The defaults vary from 2--16.

To use the mult-node tests, you would have to update the host list. I wrote these for [Virginia Tech's New River](http://www.arc.vt.edu) cluster.

[R](http://www.r-project.org/) is used to aggregate the results and plot graphs.
