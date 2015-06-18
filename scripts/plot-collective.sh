#!/bin/bash

if [ $# -ne 8 ]
then
    echo "Usage: ./plot-collective.sh <test> <path_to_log> <output_file> <indep_var> <dep_var> <title> <xlab> <ylab>"
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
input2 = read.table("$TESTNAME-2.log")
input4 = read.table("$TESTNAME-4.log")
input8 = read.table("$TESTNAME-8.log")
input16 = read.table("$TESTNAME-16.log")
#input20 = read.table("$TESTNAME-20.log")

#set column name
colnames(input2) <- c("$INDVAR", "$DEPVAR")
colnames(input4) <- c("$INDVAR", "$DEPVAR")
colnames(input8) <- c("$INDVAR", "$DEPVAR")
colnames(input16) <- c("$INDVAR", "$DEPVAR")
#colnames(input20) <- c("$INDVAR", "$DEPVAR")

#summarize results by message size
agg2  <- aggregate(input2\$$DEPVAR~input2\$$INDVAR, FUN=mean)
agg4  <- aggregate(input4\$$DEPVAR~input4\$$INDVAR, FUN=mean)
agg8  <- aggregate(input8\$$DEPVAR~input8\$$INDVAR, FUN=mean)
agg16 <- aggregate(input16\$$DEPVAR~input16\$$INDVAR, FUN=mean)
#agg20 <- aggregate(input20\$$DEPVAR~input20\$$INDVAR, FUN=mean)

#set column names
colnames(agg2) <- c("$INDVAR", "$DEPVAR")
colnames(agg4) <- c("$INDVAR", "$DEPVAR")
colnames(agg8) <- c("$INDVAR", "$DEPVAR")
colnames(agg16) <- c("$INDVAR", "$DEPVAR")
#colnames(agg20) <- c("$INDVAR", "$DEPVAR")

#output file parameters
pdf("$OUTPUTFILE", width=6, height=6)

#plot
#plot(agg20\$$DEPVAR, xlab=$XLAB, ylab=$YLAB, main=$TITLE, xaxt="n")
plot(agg16\$$DEPVAR, xlab=$XLAB, ylab=$YLAB, main=$TITLE, xaxt="n")
#points(agg16\$$DEPVAR, col="red", pch=15)
points(agg8\$$DEPVAR, col="blue", pch=5)
points(agg4\$$DEPVAR, col="red", pch=16)
points(agg2\$$DEPVAR, col="blue", pch=17)

#define x-axis labels
rows <- nrow(agg2)
axis(1, at=1:rows, labels=agg2\$$INDVAR)
#add grid
grid(10,10)

#legend("topleft", legend=c("P20", "P16", "P8", "P4", "P2"), pch=c(1,15,5,16,17), col=c("black", "red", "blue", "red", "blue"))
legend("topleft", legend=c("P16", "P8", "P4", "P2"), pch=c(1,5,16,17), col=c("black", "blue", "red", "blue"))

garbage <- dev.off()
EOF

chmod a+x plot.r
./plot.r

rm -f plot.r

