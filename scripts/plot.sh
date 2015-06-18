#!/bin/bash

if [ $# -ne 8 ]
then
    echo "Usage: ./plot.sh <test> <path_to_log> <output_file> <indep_var> <dep_var> <title> <xlab> <ylab>"
    exit
fi

cd ..

TESTNAME=$1
PATHTOLOG=$2
OUTPUTFILE=$3
INDVAR=$4
DEPVAR=$5
TITLE=$6
XLAB=$7
YLAB=$8

module purge
module load intel R

cat > "plot.r" <<EOF
#!$R_DIR/bin/Rscript

#getwd()
setwd("$PATHTOLOG")

#How to read from a file
#http://www.r-tutor.com/r-introduction/data-frame/data-import
input = read.table("$TESTNAME.log")
#set column name
colnames(input) <- c("$INDVAR", "$DEPVAR")
#summarize results by message size
agg <- aggregate(input\$$DEPVAR~input\$$INDVAR, FUN=mean)
#set column names
colnames(agg) <- c("$INDVAR", "$DEPVAR")
#output file parameters
pdf("$OUTPUTFILE", width=6, height=6)
#plot
plot(agg\$$DEPVAR, xlab=$XLAB, ylab=$YLAB, main=$TITLE, xaxt="n")
#define x-axis labels
rows <- nrow(agg)
axis(1, at=1:rows, labels=agg\$$INDVAR)
#add grid
grid(10,10)
#fit curve
#lo <- loess(agg\$$DEPVAR~agg\$$INDVAR)
#lines(predict(lo), col='red', lwd=1)
#write file
garbage <- dev.off()
EOF

chmod a+x plot.r
./plot.r

rm -f plot.r

